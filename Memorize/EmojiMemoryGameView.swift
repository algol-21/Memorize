import SwiftUI


struct EmojiMemoryGameView: View {
    @ObservedObject
    var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            Text(viewModel.theme.name)
            Text("Score: \(viewModel.score)")
            PlayField(viewModel: viewModel)
            Button("New Game") {
                viewModel.newGame()
            }
        }
        .padding()
        .foregroundColor(viewModel.theme.color)
    }
}

struct PlayField: View {
    @ObservedObject
    var viewModel: EmojiMemoryGame
    var body: some View {
        Grid (viewModel.cards) { card in
            CardView(theme: viewModel.theme, card: card).onTapGesture{
                self.viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()
    }
}

struct CardView: View {
    var theme: Theme
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(LinearGradient(
                              gradient: .init(colors: [theme.color, Color.white]),
                            startPoint: .init(x: startGradient.x, y: startGradient.y),
                            endPoint: .init(x: endGradient.x, y: endGradient.y)
                            ))
                }
            }
        }
        //.aspectRatio(aspectRatio, contentMode: .fit)
        .font(Font.system(size: fontSize(for: size)))
    }
    
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let aspectRatio: CGFloat = 2.0 / 3.0
    let startGradient: (x: CGFloat, y: CGFloat) = (x: 0.5, y: 0.0)
    let endGradient: (x: CGFloat, y: CGFloat) = (x: 0.5, y: 3.0)
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
