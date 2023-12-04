//
//  File.swift
//
//
//  Created by Gruff Johnston on 02/12/2023.
//

import Foundation
import Algorithms

struct Day04: AdventDay {
    
    var data: String
    
    var lines: [[String]] {
        return data.split(separator: "\n").map {
            $0.split(separator: ":").last!.split(separator: "|").compactMap { String($0) }
        }
    }
    
    var lines2: [Card] {
        return data.split(separator: "\n").map { line in
            let parts = line.split(separator: ":")
            let cardNumber = String(parts.first ?? "").split(separator: " ").last!
            let allNumbers = parts.last!.split(separator: "|").compactMap { String($0) }
            let winners = allNumbers.first!.split(separator: " ").compactMap { Int($0) }
            let numbers = allNumbers.last!.split(separator: " ").compactMap { Int($0) }
            let card = Card(cardNumber: Int(cardNumber)!, winners: winners, numbers: numbers)
            return card
        }
    }
    
    struct Card {
        let cardNumber: Int
        let winners: [Int]
        let numbers: [Int]
        var total: Int = 1
    }
    
    func part1() -> Any {
        var total = 0
        
        for line in lines {
            var winnerCount = 0
            
            let winners = line.first!.split(separator: " ").compactMap { Int($0) }
            let numbers = line.last!.split(separator: " ").compactMap { Int($0) }
            
            for number in numbers {
                if winners.contains(number) {
                    if winnerCount == 0 {
                        winnerCount = 1
                    } else {
                        winnerCount *= 2
                    }
                }
            }
            total += winnerCount
            
        }
        return total
    }
    
    func part2() -> Any {
        var stack: [Card]  = []
        stack.append(contentsOf: lines2)
        
        var index = 0
        while index < stack.count {
            let card = stack[index]
            
            for _ in 1...card.total {
                var winnerCount = 0
                
                for number in card.numbers {
                    if card.winners.contains(number) {
                        winnerCount += 1
                    }
                }
                
                if winnerCount > 0 {
                    for cardIndex in 1...winnerCount {
                        stack[(card.cardNumber - 1) + cardIndex].total += 1
                    }
                }
            }
            
            index += 1
        }
        return stack.reduce(0, {$0 + $1.total})
    }
}
