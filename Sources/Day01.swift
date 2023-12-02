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
    
    var lines: [String] {
        data.split(separator: "\n").map {
            String($0)
        }
    }

    var numbers: [String] {
        ["NULL", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    } 
    
    var digits: [String] {
        ["NULL", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
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
        var total = 0
        for line in lines {
            var lowestRange = 1000
            var highestRange = 0
            var lowest = ""
            var highest = ""
            
            for number in numbers {
                if line.contains(number) {
                    let ranges = line.ranges(of: number)
                    
                    for range in ranges {
                        
                        let index = line.distance(from: line.startIndex, to: range.lowerBound)
                        
                        if lowestRange >= index {
                            lowestRange = index
                            lowest = (String(numbers.firstIndex(of: number)!))
                        }
                        if highestRange <= index {
                            highestRange = index
                            highest = (String(numbers.firstIndex(of: number)!))
                        }
                    }
                }
            }
            
            for digit in digits {
                if line.contains(digit) {
                    let ranges = line.ranges(of: digit)
             
                    for range in ranges {
                        let index = line.distance(from: line.startIndex, to: range.lowerBound)
                    
                        if lowestRange >= index {
                            lowestRange = index
                            lowest = digit
                        }
                        if highestRange <= index {
                            highestRange = index
                            highest = digit
                        }
                    }
                }
            }

            if let number = Int(String("\(lowest)\(highest)")) {
                total += number
            }
        }
        
        return total
    }
}
