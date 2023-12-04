//
//  File.swift
//
//
//  Created by Gruff Johnston on 02/12/2023.
//

import Foundation
import Algorithms

struct Day02: AdventDay {

    var data: String
    
    var games: [[String]] {
        data.split(separator: "\n").map {
            $0.components(separatedBy:CharacterSet.punctuationCharacters).compactMap { String($0) }
        }
    }

    func part1() -> Any {
        var total = 0
        
        for game in games {
            
            let gameNumber = Int((game.first?.components(separatedBy: " ").last!)!)!
            var valid = true
            
            for index in 1...game.count - 1 {
                if valid == true {
                    let split = game[index].components(separatedBy: " ")
                    let colour = Colour(rawValue: split.last!)
                    let count = Int(split[1])
                    valid = validGame(colour: colour!, count: count!)
                }
            }
            
            if valid == true {
                total += gameNumber
            }
        }
        
        return total
    }
    
    func validGame(colour: Colour, count: Int) -> Bool {
        switch colour {
        case .blue:
            return count <= 14
        case .red:
            return count <= 12
        case .green:
            return count <= 13
        }
    }
    
    enum Colour: String {
        case red = "red"
        case blue = "blue"
        case green = "green"
    }
    
    func part2() -> Any {
        
        return "total"
    }
}
