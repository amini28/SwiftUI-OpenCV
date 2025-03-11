//
//  HWheelPicker.swift
//  SwiftUI-OpenCV
//
//  Created by Amini on 09/03/25.
//

import SwiftUI

struct HWheelPicker: View {
    
    struct Config: Equatable {
        var steps: Int
        var starterStep: Int = 0
        var spacing: CGFloat = 10
        var showsText: Bool = true
    }
    
    var config: Config
    @Binding var value: Int
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let horizontalPadding = size.width / 2
            
            ScrollView(.horizontal) {
                ScrollViewReader { proxy in
                    HStack(spacing: config.spacing) {
                        let totalSteps = config.steps + config.starterStep
                        ForEach(config.starterStep...totalSteps, id: \.self) { index in
                            Divider()
                                .background(Color.primary)
                                .frame(width: 0, height: 20, alignment: .center)
                                .frame(maxHeight: 20, alignment: .bottom)
                        }
                    }
                    .frame(height: size.height)
                    .scrollTargetLayout()
                    .onAppear {
                        proxy.scrollTo(0, anchor: .bottom)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: .init(get: {
                let position: Int? = value
                return position
            }, set: { newValue in
                if let newValue {
                    value = newValue
                }
            }))
            .overlay(alignment: .center) {
                Rectangle()
                    .frame(width: 1, height: 40)
                    .padding(.bottom, 20)
            }
            .overlay(alignment: .bottom) {
                if config.showsText {
                    Text("\(value)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .fixedSize()
                        .offset(y: 20)
                }
            }
            .safeAreaPadding(.horizontal, horizontalPadding)
        }
    }
}

