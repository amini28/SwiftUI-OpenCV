//
//  ImageProcessingViewModel.swift
//  SwiftUI-OpenCV
//
//  Created by Amini on 09/03/25.
//
import Combine
import SwiftUI

class ImageProcessingViewModel: ObservableObject {
    
    @Published var wheelValue: Int = 0
    @Published var originalImage: UIImage = UIImage(named: "alex-nicolopoulos-unsplash")!
    @Published var filteredImage: UIImage?

    var config: HWheelPicker.Config = .init(steps: 50, starterStep: -25)
    
    func applyWarmFilter() {
        filteredImage = OpencvWrappers.applyWarmFilter(to: originalImage, intensity: Int32(wheelValue))
    }
}

