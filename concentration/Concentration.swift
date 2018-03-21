//
//  Concentration.swift
//  concentration
//
//  Created by Ying Liu on 3/12/18.
//  Copyright © 2018 Ying Liu. All rights reserved.
//

import Foundation
struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
//            let faceUpCardIndices = cards.indices.filter{cards[$0].isFaceUp}
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
//            var  foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index:Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index)): chosen index not in the cards")
           if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,  matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)):you must have at least one")
        for _ in 1...numberOfPairsOfCards {
             let card = Card()
             cards += [card, card]
        }
         // Shuffle the cards
        for index in 0..<numberOfPairsOfCards {
            let temp = cards[index]
            let randomIndex = Int(arc4random_uniform(UInt32(numberOfPairsOfCards - index))) + index
            cards[index] = cards[randomIndex]
            cards[randomIndex] = temp
        }
        
    }
    
}
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
