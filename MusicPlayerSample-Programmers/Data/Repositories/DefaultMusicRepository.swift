//
//  DefaultMusicRepository.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/03.
//

import Foundation
import Combine

final class DefaultMusicRepository: MusicRepository {
    
    func fetchMusic() {
        guard let url = URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/cover.jpg")
        else { return }
        
        let request = URLRequest(url: url)
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
        
        
    }
}
