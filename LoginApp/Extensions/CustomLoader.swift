//
//  CoustomLoader.swift



import SwiftUI

struct CustomLoader: View {
    var loadingMessage:String = "Loading..."
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 10) {
                ProgressView(loadingMessage)
                    .frame(width: 80, height: 60, alignment: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundColor(.white)
                    .font(.headline)

            }
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(10)
        }
    }
}

#Preview {
    CustomLoader()
}

//
//import SwiftUI
//import UIKit
//
//struct CustomLoader: View {
//    // MARK: - Configurable Properties
//    let message: String
//    let tintColor: Color
//    let backgroundOpacity: Double
//    @State private var pulseScale: CGFloat = 1.0
//    
//    // MARK: - Init
//    init(message: String = "Please wait...", tintColor: Color = .white, backgroundOpacity: Double = 0.6) {
//        self.message = message
//        self.tintColor = tintColor
//        self.backgroundOpacity = backgroundOpacity
//    }
//    
//    var body: some View {
//        ZStack {
//            // Dimmed blurred background (optimized for performance)
//            VisualEffectBlur(blurStyle: UIDevice.current.userInterfaceIdiom == .pad ? .systemThinMaterialDark : .systemUltraThinMaterialDark)
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack(spacing: 20) {
//                // Animated Circular Loader with Pulsating Effect
//                ZStack {
//                    Circle()
//                        .fill(tintColor.opacity(0.2))
//                        .frame(width: 50, height: 50)
//                        .scaleEffect(pulseScale)
//                        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulseScale)
//                    
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
//                        .scaleEffect(1.8)
//                }
//                
//                // Custom Text
//                Text(message)
//                    .foregroundColor(tintColor)
//                    .font(.system(size: 18, weight: .medium))
//                    .dynamicTypeSize(.large) // Accessibility: Dynamic text sizing
//                    .accessibilityLabel("Loading, \(message)")
//            }
//            .padding(30)
//            .background(
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color.black.opacity(backgroundOpacity))
//                    .blur(radius: 0.3)
//            )
//            .shadow(radius: 10)
//            .transition(.scale.combined(with: .opacity)) // Enhanced transition
//            .onAppear {
//                pulseScale = 1.3 // Start pulsating animation
//            }
//        }
//    }
//}
//
//// MARK: - VisualEffectBlur
//struct VisualEffectBlur: UIViewRepresentable {
//    var blurStyle: UIBlurEffect.Style
//    
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
//    }
//    
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
//}
//
//#Preview {
//    // Multiple previews for testing
//    VStack {
//        CustomLoader(message: "Logging in...", tintColor: .blue, backgroundOpacity: 0.8)
//            .preferredColorScheme(.light)
//        
////        CustomLoader(message: "Please wait...", tintColor: .white, backgroundOpacity: 0.6)
////            .preferredColorScheme(.light)
//    }
//}
