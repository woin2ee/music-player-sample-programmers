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
        var result: Lyrics = [:]
        
        let lyricsArr = self.lyrics.components(separatedBy: "\n")
        lyricsArr.forEach {
            result[$0.duration] = $0.lyrics
        }
        
        return result
    }
}
