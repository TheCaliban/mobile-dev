import SwiftUI

struct Banner: View {
    
    struct BannerDataModel {
        var title:String
        var detail:String
        var type: BannerType
    }
    
    enum BannerType {
        case info
        case warning
        case success
        case error
        
        var tintColor: Color {
            switch self {
            case .info:
                return .blue
            case .success:
                return .green
            case .warning:
                return .yellow
            case .error:
                return .red
            }
        }
        
        var sfSymbol: String {
            switch self {
            case .info:
                return "info.circle"
            case .success:
                return "checkmark.seal"
            case .warning:
                return "exclamationmark.octagon"
            case .error:
                return "xmark.octagon"
            }
        }
    }
    let data: BannerDataModel
    @Binding var show: Bool
    var body: some View {
        VStack {
            HStack {
                Image.init(systemName: data.type.sfSymbol)
                VStack(alignment: .leading, spacing: 2) {
                    Text(data.title)
                        .bold()
                    Text(data.detail)
                        .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                }
                Spacer()
            }
            .foregroundColor(Color.white)
            .padding(12)
            .background(data.type.tintColor)
            .cornerRadius(8)
            Spacer()
        }
        .padding()
        .animation(.easeInOut)
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .onTapGesture {
            // Hide on tap
            withAnimation {
                self.show = false
            }
        }.onAppear(perform: {
            // Automatically hide after a few sec
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.show = false
                }
            }
        })
    }
}

struct Overlay<T: View>: ViewModifier {
    
    @Binding var show: Bool
    let overlayView: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                overlayView
            }
        }
    }
}

// Extend the view with an overlay element
extension View {
    func overlay<T: View>( overlayView: T, show: Binding<Bool>) -> some View {
        self.modifier(Overlay.init(show: show, overlayView: overlayView))
    }
}
