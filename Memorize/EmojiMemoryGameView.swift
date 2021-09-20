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
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                //Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true).padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp, color: theme.color)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
