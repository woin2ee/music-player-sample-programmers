//
//  DefaultMusicRepository.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/03.
//

import Foundation
import UIKit
import Combine

final class DefaultMusicRepository: MusicRepository {
    
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchMusic(_ completion: @escaping (Music) -> Void) {
        let url = URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json")!
        return networkService.request(url: url, completion)
    }
}
