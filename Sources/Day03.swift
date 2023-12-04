//
//  File.swift
//
//
//  Created by Gruff Johnston on 02/12/2023.
//

import Foundation
import Algorithms

struct Day03: AdventDay {
    
    var data: String
    
    var lines: [[String]] {
        data.split(separator: "\n").map {
            $0.compactMap { String($0) }
        }
    }
    
    func part1() -> Any {
        var total = 0
        for lineIndex in 0...lines.count - 1 {
            let line = lines[lineIndex]
            for index in 0...line.count - 1 {
                if let number = Int(line[index]) {
                    
                    var fullNumber = 0
                    if index == 0 {
                        
                        let number2 = Int(line[index + 1])!
                        if line.count > index + 2 {
                            if let number3 = Int(line[index + 2]) {
                                fullNumber = Int(String("\(number)\(number2)\(number3)"))!
                            }
                            else {
                                fullNumber = Int(String("\(number)\(number2)"))!
                            }
                        } else {
                            fullNumber = Int(String("\(number)\(number2)"))!
                        }
                        let surround = getSurroundingCharactersFor(line: lineIndex, index: index, size: fullNumber.size)
                        
                        if surround.isEmpty == false {
                            total += fullNumber
                        }
                    } else if Int(line[index - 1]) == nil {
                        
                        if let number2 = Int(line[index + 1]) {
                            if line.count > index + 2 {
                                if let number3 = Int(line[index + 2]) {
                                    fullNumber = Int(String("\(number)\(number2)\(number3)"))!
                                }
                                else {
                                    fullNumber = Int(String("\(number)\(number2)"))!
                                }
                            } else {
                                fullNumber = Int(String("\(number)\(number2)"))!
                            }
                        } else {
                            fullNumber = Int(String("\(number)"))!
                        }
                        let surround = getSurroundingCharactersFor(line: lineIndex, index: index, size: fullNumber.size)
                        if surround.isEmpty == false {
                            total += fullNumber
                        }
                    }
                }
            }
        }
        
        return total
    }
    
    func part2() -> Any {
        var total = 0
        
        for lineIndex in 0...lines.count - 1 {
            let line = lines[lineIndex]
        
            for index in 0...line.count - 1 {
            
                if line[index] == "*" {
                    let surround = getSurroundingNumbersForGear(line: lineIndex, index: index)
                
                    if surround.count == 2 {
                        total += (surround[0] * surround[1])
                    }
                }
            }
        }
        
        return total
    }
    
    func getSurroundingCharactersFor(line: Int, index: Int, size: Int) -> [String] {
        var surround: [String] = []
        
        if index > 0 {
            surround.append(lines[line][index - 1])
        }
        if lines[line].count > index {
            surround.append(lines[line][index + 1])
        }
        if lines[line].count > index + 2 && size > 1  {
            surround.append(lines[line][index + 2])
        }
        if lines[line].count > index + 3 && size > 2 {
            surround.append(lines[line][index + 3])
        }
        
        if line > 0 {
            surround.append(lines[line - 1][index])
            if index > 0 {
                surround.append(lines[line - 1][index - 1])
            }
            if lines[line].count > index {
                surround.append(lines[line - 1][index + 1])
            }
            if lines[line].count > index + 2  && size > 1 {
                surround.append(lines[line - 1][index + 2])
            }
            if lines[line].count > index + 3  && size > 2 {
                surround.append(lines[line - 1][index + 3])
            }
        }
        
        if lines.count > line + 1 {
            surround.append(lines[line + 1][index])
            if index > 0 {
                surround.append(lines[line + 1][index - 1])
            }
            if lines[line].count > index {
                surround.append(lines[line + 1][index + 1])
            }
            if lines[line].count > index + 2  && size > 1 {
                surround.append(lines[line + 1][index + 2])
            }
            if lines[line].count > index + 3  && size > 2 {
                surround.append(lines[line + 1][index + 3])
            }
            
        }
        surround = surround.filter { $0 != "." }
        surround = surround.filter { Int($0) == nil }
        
        return surround
    }
    
    func getNumberAtLocation(line: Int, index: Int) -> Int {
        var digits :[Int] = []
        if let originalNumber = Int(lines[line][index]) {
            if let n1 = Int(lines[line][index - 1]) {
                if let n2 = Int(lines[line][index - 2]) {
                    digits.append(n2)
                    digits.append(n1)
                    digits.append(originalNumber)
                } else {
                    digits.append(n1)
                    digits.append(originalNumber)
                    if let p1 = Int(lines[line][index + 1]) {
                        digits.append(p1)
                    }
                }
            } else {
                // nothing to the left, lets try to the right
                if let p1 = Int(lines[line][index + 1]) {
                    if let p2 = Int(lines[line][index + 2]) {

                        digits.append(originalNumber)
                        digits.append(p1)
                        digits.append(p2)

                    } else {

                        digits.append(originalNumber)
                        digits.append(p1)
                    }
                } else {
                    // nothing to the right, just one digit
                    digits.append(originalNumber)
                }
            }
        }
        
        var string = ""
        for digit in digits {
            string.append(String(digit))
        }
        
        return Int(string) ?? 0
    }
    
    func getSurroundingNumbersForGear(line: Int, index: Int) -> [Int] {
        var surround: [Int] = []
        
        if index > 0 {
            surround.append(getNumberAtLocation(line: line, index: index - 1))
        }
        if lines[line].count > index {
            surround.append(getNumberAtLocation(line: line, index: index + 1))
        }
        
        if line > 0 {
            
            surround.append(getNumberAtLocation(line: line - 1, index: index))
            
            if index > 0 {
                surround.append(getNumberAtLocation(line: line - 1, index: index - 1))
            }
            if lines[line].count > index {
                surround.append(getNumberAtLocation(line: line - 1, index: index + 1))
            }
        }
        
        if lines.count > line + 1 {
            
            surround.append(getNumberAtLocation(line: line - 1, index: index))
            
            if index > 0 {
                surround.append(getNumberAtLocation(line: line + 1, index: index - 1))
            }
            if lines[line].count > index {
                surround.append(getNumberAtLocation(line: line + 1, index: index + 1))
            }
        }
        
        return Array(surround.filter { $0 != 0 }.uniqued())
    }
}

extension Int {
    var size : Int {
        String(self).count
    }
}
