import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(
                          gradient: .init(colors: [color, Color.white]),
                        startPoint: .init(x: startGradient.x, y: startGradient.y),
                        endPoint: .init(x: endGradient.x, y: endGradient.y)
                        ))
            }
        }
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
