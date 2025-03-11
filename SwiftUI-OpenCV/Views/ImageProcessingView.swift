//
//  ImageProcessingView.swift
//  SwiftUI-OpenCV
//
//  Created by Amini on 09/03/25.
//

import SwiftUI
import Combine
import UniformTypeIdentifiers

struct ImageProcessingView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var viewModel = ImageProcessingViewModel()
    
    @State private var debouncedValue: Int = 0
    @State private var cancellable: AnyCancellable?
    @State private var isFileExporterPresented = false
    @State private var exportedFileUrl: URL?
    @State private var showingAlert = false
    @State private var messageAlert = ""
    
    let selectedURL: URL
    
    var body: some View {
        VStack {
            if let filtered = viewModel.filteredImage {
                Image(uiImage: filtered)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                
            } else {
                Image(uiImage: viewModel.originalImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
            }
            
            HWheelPicker(config: viewModel.config, value: $viewModel.wheelValue)
                .frame(height: 60)
            
            ButtonView(title: "export image", buttonScheme: .primer, action: { isFileExporterPresented = true })
            
        }
        .padding()
        .fileExporter(
            isPresented: $isFileExporterPresented,
            document: ImageDocument(image: viewModel.filteredImage),
            contentType: .jpeg,
            defaultFilename: "exported-image.jpeg"
        ) { result in
            switch result {
            case .success(let url):
                exportedFileUrl = url
                showingAlert = true
                messageAlert = "save image success"

            case .failure(let error):
                print("Export failed: \(error.localizedDescription)")
                showingAlert = true
                messageAlert = "Failed to save image"
            }
        }
        .onChange(of: viewModel.wheelValue, { oldValue, newValue in
            cancellable?.cancel()
            cancellable = Just(newValue)
                .delay(for: .milliseconds(100), scheduler: DispatchQueue.main)
                .sink(receiveValue: {
                    debouncedValue = $0
                    viewModel.applyWarmFilter()
                })
        })
        .onAppear {
            if selectedURL.startAccessingSecurityScopedResource() {
                defer { selectedURL.stopAccessingSecurityScopedResource() }
                do {
                    let imageData = try Data(contentsOf: selectedURL)
                    if let uiImage = UIImage(data: imageData) {
                        viewModel.originalImage = uiImage
                    } else {
                        print("Error: Unable to convert data to UIImage.")
                        showingAlert = true
                        messageAlert = "Failed to open image"
                    }
                } catch {
                    print("Error loading image: \(error.localizedDescription)")
                    showingAlert = true
                    messageAlert = "Failed to load image"
                }
            } else {
                showingAlert = true
                messageAlert = "Failed to access resource"
            }
        }
        .alert(messageAlert, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}

