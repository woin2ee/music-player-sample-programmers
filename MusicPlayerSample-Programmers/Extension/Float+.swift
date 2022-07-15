//
//  Float+.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/15.
//

import Foundation

extension Float {
    func toTimeString() -> String {
        let minute = Int(self) / 60
        let second = Int(self) % 60
        return second < 10 ? "\(minute):0\(second)" : "\(minute):\(second)"
    }
}
