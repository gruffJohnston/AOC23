//
//  File.swift
//
//
//  Created by Gruff Johnston on 02/12/2023.
//

import Foundation
import Algorithms

struct Day06: AdventDay {
    var data: String

    var times: [Int] {
        return data.split(separator: "\n").first!.split(separator: ":").last!.split(separator: " ").compactMap { Int($0) }
    }
    
    var distances: [Int] {
        return data.split(separator: "\n").last!.split(separator: ":").last!.split(separator: " ").compactMap { Int($0) }
    }
    
    func part1() -> Any {
        var winnerCounts: [Int] = []
        
        for (index, time) in times.enumerated() {
            let distance = distances[index]
            winnerCounts.append(calculateWinning(time: time, distance: distance))
        }

        return winnerCounts.reduce(1, *)
    }

    func calculateWinning(time: Int, distance: Int) -> Int {
        var winners: [Int] = []
       
        for t in 1...time - 1 {
        
            let speed = t
            let remainingTime = time - t
            let movingTotal = speed * remainingTime
            
            if movingTotal > distance {
                winners.append(movingTotal)
            }
        }
        
        return winners.count
    }
    
    func part2() -> Any {
        var targetDestination = 0


        return targetDestination
    }

}
