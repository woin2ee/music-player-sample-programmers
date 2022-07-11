//
//  MusicResponseDTO.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/11.
//

import UIKit

struct MusicResponseDTO: Codable {
    let singer: String
    let album: String
    let title: String
    let duration: Int
    let image: String
    let file: String
    let lyrics: String
}

extension MusicResponseDTO {
    func toEntity() -> Music {
        return .init(
            title: self.title,
            singer: self.singer,
            albumTitle: self.album,
            albumImage: UIImage(data: try! Data(contentsOf: URL(string: self.image)!))!,
            file: try! Data(contentsOf: URL(string: self.file)!),
            lyrics: convertLyrics(),
            duration: Float(self.duration)
        )
    }
    
    func convertLyrics() -> Lyrics {
        let result: Lyrics = [16.2:"we wish you a merry christmas", 18.3:"we wish you a merry christmas", 21.1:"we wish you a merry christmas", 23.6:"and a happy new year"]
        
        return result
    }
}
