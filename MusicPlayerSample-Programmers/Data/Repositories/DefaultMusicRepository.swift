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
    
    func fetchMusic() -> Music {
//        let url = URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/cover.jpg")!
//        let request = URLRequest(url: url)
        
        return Music(
            title: "We Wish You A Merry Christmas",
            singer: "챔버오케스트라",
            albumTitle: "캐롤 모음",
            albumImage: UIImage(data: try! Data(contentsOf: URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/cover.jpg")!))!,
            file: try! Data(contentsOf: URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/music.mp3")!),
            lyrics: .init(),
            duration: 198
        )
    }
}
