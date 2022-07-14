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
    
    func fetchMusic(_ completion: @escaping (Result<Music, NetworkError>) -> Void) {
        return networkService.request(completion)
    }
}
