import SwiftUI

struct Theme {
    let name: String
    let color: Color
    let emojis: Array<String>
    
    init(name: String, color: Color, emojis: Array<String>) {
        let numOfPairs = Int.random(in: 0..<emojis.count)
        self.init(name: name, color: color, emojis: emojis, numOfPairs: numOfPairs)
    }
    
    init(name: String, color: Color, emojis: Array<String>, numOfPairs: Int) {
        self.name = name
        self.color = color
        self.emojis = Array(emojis.shuffled().prefix(numOfPairs))
    }
}
