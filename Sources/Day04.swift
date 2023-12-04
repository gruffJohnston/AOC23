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
        var total = 0
        return total
    }
}
