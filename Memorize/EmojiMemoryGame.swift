// It's a view-model class

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published
    private var model: MemoryGame<String>
    private var themeIndex: Int
    
    init() {
        themeIndex = Int.random(in: 0..<EmojiMemoryGame.themes.count)
        (theme, model) = EmojiMemoryGame.generateNewGame(themeIndex: themeIndex)
    }
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var theme: Theme
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        // *****
        themeIndex = newRandomThemeIndex()
        // *****
        (theme, model) = EmojiMemoryGame.generateNewGame(themeIndex: themeIndex)
    }
    
    private func newRandomThemeIndex() -> Int {
        var indices: Array<Int> = Array(0..<EmojiMemoryGame.themes.count)
        indices.remove(at: themeIndex)
        return indices.randomElement()!
    }
    
    private static var themes: [Theme]  = [
        Theme(name: "Halloween", color: Color.orange, emojis: ["👻", "🎃", "🕷"], numOfPairs: 3),
        Theme(name: "Animals", color: Color.green, emojis: ["🐼", "🐔", "🦄"], numOfPairs: 3),
        Theme(name: "Sport", color: Color.blue, emojis: ["🏀", "🏈", "⚾️"], numOfPairs: 3),
        Theme(name: "Faces", color: Color.yellow, emojis: ["👧🏼", "👦🏻", "👴🏿"], numOfPairs: 3),
        Theme(name: "Hand signs", color: Color.gray, emojis: ["👍🏿", "🤟🏻", "👌🏽"], numOfPairs: 3),
        Theme(name: "Mystic", color: Color.purple, emojis: ["🧞‍♂️", "🧜‍♀️", "🧚"], numOfPairs: 3)
    ]
    
    private static func generateNewGame(themeIndex: Int) -> (Theme, MemoryGame<String>) {
        let theme = EmojiMemoryGame.themes[themeIndex]
        let emojis = theme.emojis
        let model = MemoryGame<String>(numOfPairsOfCards: emojis.count) {
            pairIndex in emojis[pairIndex]
        }
        return (theme, model)
    }
}
