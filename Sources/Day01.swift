//
//  File.swift
//
//
//  Created by Gruff Johnston on 02/12/2023.
//

import Foundation
import Algorithms

struct Day01: AdventDay {

    var data: String
    
    var entities: [[Int]] {
        data.split(separator: "\n").map {
            $0.components(separatedBy:CharacterSet.decimalDigits.inverted).compactMap { Int($0) }
        }
    }

    func part1() -> Any {
        var total = 0
        for line in entities {
            let first = String(line.first!).first
            let last  = String(line.last!).last
            if let number = Int(String("\(first!)\(last!)")) {
                total += number
            }
        }
        return total
    }
    
    func part2() -> Any {
        return ""
    }
}
