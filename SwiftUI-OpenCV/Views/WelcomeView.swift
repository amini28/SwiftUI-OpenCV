//
//  WelcomeView.swift
//  SwiftUI-OpenCV
//
//  Created by Amini on 10/03/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isFileImporterPresented = false
    @State private var selectedFileURL: URL?
    @State private var navigateToImageProcessing = false
    
    @State private var showingAlert = false
    @State private var messageAlert = ""
        
    var body: some View {
        NavigationStack {
            ZStack {
                Image("alex-nicolopoulos-unsplash")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("Enhance Your \nPhoto with \nFilter and \nEffect")
                        .foregroundStyle(.white)
                        .font(.system(size: 58, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20)
                    
                    ButtonView(title: "load your image", buttonScheme: .sekunder, action: {
                        isFileImporterPresented = true
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    })
                }
                .fileImporter(
                    isPresented: $isFileImporterPresented,
                    allowedContentTypes: [.jpeg],
                    allowsMultipleSelection: false
                ) { result in
                    do {
                        selectedFileURL = try result.get().first
                        navigateToImageProcessing = true
                    } catch {
                        print("Error selecting file: \(error.localizedDescription)")
                        messageAlert = "File Selection Failed"
                        showingAlert = true
                    }
                }
                .navigationDestination(isPresented: $navigateToImageProcessing) {
                    ImageProcessingView(selectedURL: selectedFileURL ?? URL(fileURLWithPath: ""))
                }
            }
        }
        .tint(.black)
        .alert(messageAlert, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        }

    }
}

#Preview {
    WelcomeView()
}
