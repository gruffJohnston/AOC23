//
//  File.swift
//
//
//  Created by Gruff Johnston on 02/12/2023.
//

import Foundation
import Algorithms

struct Day05: AdventDay {
    var data: String

    var almanac: Almanac {
        var seeds: [Int] = []
        var maps: [Map] = []

        let paragraphs = data.split(separator: "\n\n")

        for paragraph in paragraphs {
            let lines = paragraph.split(separator: "\n").map(String.init)
            if lines[0].contains("seeds") {
                seeds = lines[0].split(separator: ":").last!.split(separator: " ").compactMap { Int($0) }
            } else if let mapType: MapType = MapType(rawValue: String(lines[0].split(separator: " ").first!)) {
                var mapEntries: [MapEntry] = []
                for line in lines.dropFirst() {
                    let elements = line.split(separator: " ").compactMap { Int($0) }
                    if elements.count == 3 {
                        let entry = MapEntry(destination: elements[0], source: elements[1], range: elements[2])
                        mapEntries.append(entry)
                    }
                }
                let map = Map(mapType: mapType, entries: mapEntries)
                maps.append(map)
            }
        }

        return Almanac(seeds: seeds, maps: maps)
    }

    struct Almanac {
        let seeds: [Int]
        let maps: [Map]
    }

    struct Map {
        let mapType: MapType
        let entries: [MapEntry]
    }
        
    enum MapType: String {
        case seedToSoil = "seed-to-soil"
        case soiToFertilize = "soil-to-fertilizer"
        case fertilizerToWater = "fertilizer-to-water"
        case wateToLight = "water-to-light"
        case lighToTemperature = "light-to-temperature"
        case temperatureToHumidity = "temperature-to-humidity"
        case humiditToLocation = "humidity-to-location"
    }

    struct MapEntry {
        let destination: Int
        let source: Int
        let range: Int
    }

    func part1() -> Any {
        var destinations: [Int] = []
        
        for seed in almanac.seeds {
            var destination = seed
            
            for map in almanac.maps {
                for entry in map.entries {
                    if (entry.source...entry.source + entry.range).contains(destination) {
                        destination = entry.destination + (destination - entry.source)
                        break
                    }
                }
            }
            destinations.append(destination)
        }
        
        return destinations.sorted().first!
    }

    
    func part2() -> Any {
        var targetDestination = 0
        var seedFound = false

        // Store all valid seeds in a set
        var seedsSet = Set<Int>()
        for index in stride(from: 0, to: almanac.seeds.count, by: 2) {
            let seedStart = almanac.seeds[index]
            let seedRange = almanac.seeds[index + 1]
            seedsSet = seedsSet.union(Array(seedStart..<(seedStart + seedRange)))
        }

        while true {
            var currentDestination = targetDestination
            seedFound = false

            for map in almanac.maps.reversed() {
                for entry in map.entries {
                    if (entry.destination...entry.destination + entry.range).contains(currentDestination) {
                        currentDestination = entry.source + (currentDestination - entry.destination)
                        break
                    }
                }
            }

            if seedsSet.contains(currentDestination) {
                seedFound = true
            }

            if seedFound {
                break
            } else {
                targetDestination += 1
                print(targetDestination)
            }
        }

        return targetDestination
    }

}
