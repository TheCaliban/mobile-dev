import SwiftUI

struct BackgroundView: View {
    var body: some View {
        // Background gradient
        LinearGradient(gradient: Gradient(colors: [Color("GradientBG1"), Color("GradientBG2")]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        // Background Circles
        VStack {
            Capsule()
                .fill(Color.OrangeColor)
                .frame(width: 200, height: 200)
                .offset(x: 150, y: 55)
            Spacer()
            Capsule()
                .fill(Color.OrangeColor)
                .frame(width: 200, height: 200)
                .offset(x: 150, y: 105)
        }
    }
}
