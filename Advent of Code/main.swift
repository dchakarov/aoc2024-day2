//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    
    // Sample algorithm
    var reports = [[Int]]()
    lines.forEach { line in
        reports.append(parseLine(line))
    }

    let safeReports = reports.filter {
        print($0)
        let safe = isSafe($0)
        print(safe)
        return safe
    }.count
    
    print(safeReports)
}

func isSafe(_ report: [Int]) -> Bool {
    var sortedReport = report.sorted()
    let reverseSortedReport = sortedReport.reversed()
    
    guard sortedReport.elementsEqual(report) || reverseSortedReport.elementsEqual(report) else { return false }
    
    var currentNumber = sortedReport.removeFirst()
    for number in sortedReport {
        if number - currentNumber > 3 { return false }
        if number - currentNumber < 1 { return false }
        currentNumber = number
    }
    
    return true
}

func parseLine(_ line: String) -> [Int] {
    line.components(separatedBy: " ").map { Int($0)! }
}

main()
