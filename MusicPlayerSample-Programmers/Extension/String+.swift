//
//  String+.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/12.
//

import Foundation

enum LyricsIndex: Int {
    case minuteStart = 1
    case minuteEnd = 2
    case secondStart = 4
    case secondEnd = 5
    case millisecond = 7
    case lyricsStart = 11
}

extension String {
    func slice(from: LyricsIndex, to: LyricsIndex) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from.rawValue)
        let endIndex = self.index(self.startIndex, offsetBy: to.rawValue)
        return String(self[startIndex...endIndex])
    }
    
    func slice(from: LyricsIndex) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from.rawValue)
        let endIndex = self.endIndex
        return String(self[startIndex..<endIndex])
    }
    
    var duration: Float {
        guard
            let minute = Float(self.slice(from: .minuteStart, to: .minuteEnd)),
            let second = Float(self.slice(from: .secondStart, to: .secondEnd)),
            let millisecond = Float(self.slice(from: .millisecond, to: .millisecond))
        else {
            return 0
        }
        
        return (minute * 60) + second + (millisecond / 10)
    }
    
    var lyrics: String {
        self.slice(from: .lyricsStart)
    }
}
