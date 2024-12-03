//
//  main.swift
//  No rights reserved.
//

import Foundation

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

    let safeReports = reports.filter { isSafe($0) }.count
    
    print(safeReports)
    
    let safeReportsWithExceptions = reports.filter { isSafeWithExceptions($0) }.count
    
    print(safeReportsWithExceptions)
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

func isSafeWithExceptions(_ report: [Int]) -> Bool {
    for i in 0..<report.count {
        var modifiedReport = report
        modifiedReport.remove(at: i)
        if isSafe(modifiedReport) { return true }
    }
    return false
}

func parseLine(_ line: String) -> [Int] {
    line.components(separatedBy: " ").map { Int($0)! }
}

main()
