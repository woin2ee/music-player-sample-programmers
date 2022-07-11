//
//  MusicRepository.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/03.
//

import Foundation

protocol MusicRepository {
    func fetchMusic(_ completion: @escaping (Music) -> Void)
}
