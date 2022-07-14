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
        var music = Music(
            title: self.title,
            singer: self.singer,
            albumTitle: self.album,
            albumImage: UIImage(), // Set default album image
            file: Data(),
            lyrics: convertLyrics(),
            duration: Float(self.duration)
        )
        
        if let albumImageURL = URL(string: self.image),
           let albumImageData = try? Data(contentsOf: albumImageURL),
           let albumImage = UIImage(data: albumImageData)
        {
            music.albumImage = albumImage
        }
        
        if let musicFileURL = URL(string: self.file),
           let musicFile = try? Data(contentsOf: musicFileURL)
        {
            music.file = musicFile
        }
        
        return music
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
