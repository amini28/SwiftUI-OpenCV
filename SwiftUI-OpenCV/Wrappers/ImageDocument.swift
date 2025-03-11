//
//  ImageDocument.swift
//  SwiftUI-OpenCV
//
//  Created by Amini on 11/03/25.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct ImageDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.jpeg] }
    var image: UIImage
    
    init(image: UIImage?) {
        self.image = image ?? UIImage()
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let image = UIImage(data: data)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.image = image
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: image.jpegData(compressionQuality: 1.0)!)
    }
}
