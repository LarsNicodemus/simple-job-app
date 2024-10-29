//
//  Toast.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//
import SwiftUI

struct Toast: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowing {
                VStack {
                    Spacer()
                    Text(message)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.3), value: isShowing)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isShowing = false
                    }
                }
            }
        }
    }
}

// Extension für einfachere Verwendung
extension View {
    func toast(isShowing: Binding<Bool>, message: String) -> some View {
        modifier(Toast(isShowing: isShowing, message: message))
    }
}
