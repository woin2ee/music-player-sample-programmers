//
//  String+.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/12.
//

import Foundation

extension String {
    func slice(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
}
