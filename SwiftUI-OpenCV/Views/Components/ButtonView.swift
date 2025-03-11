//
//  ButtonView.swift
//  SwiftUI-OpenCV
//
//  Created by Amini on 11/03/25.
//

import SwiftUI

enum ButtonColorScheme {
    case primer
    case sekunder
}

struct ButtonView: View {
    let title: String
    var buttonScheme: ButtonColorScheme = .primer
    var action: () -> Void
    
    
    @State private var isPressed = false
    
    
    var body: some View {
        Button(action: {
            action()
            isPressed.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed.toggle()
            }
        }) {
            Text(title)
                .font(.caption)
                .bold()
                .foregroundStyle( buttonScheme == .primer ? .white : .black)
                .frame(height: 50)
                .padding(.horizontal, 80)
                .background(buttonScheme == .primer ? .black : .white)
                .cornerRadius(25)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .scaleEffect(isPressed ? 1.1 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: isPressed)
                .padding()
        }
    }
}
