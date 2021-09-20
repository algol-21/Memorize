import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var isFaceUp: Bool {
        rotation < 90
    }
    var color: Color
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool, color: Color) {
        rotation = isFaceUp ? 0 : 180
        self.color = color
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(LinearGradient(
                      gradient: .init(colors: [color, Color.white]),
                    startPoint: .init(x: startGradient.x, y: startGradient.y),
                    endPoint: .init(x: endGradient.x, y: endGradient.y)
                    ))
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let startGradient: (x: CGFloat, y: CGFloat) = (x: 0.5, y: 0.0)
    private let endGradient: (x: CGFloat, y: CGFloat) = (x: 0.5, y: 3.0)
}

extension View {
    func cardify(isFaceUp: Bool, color: Color) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
