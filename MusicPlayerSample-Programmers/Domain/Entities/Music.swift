//
//  Music.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/04.
//

import UIKit

struct Music {
    typealias Lyrics = [Date:String]
    
    let title: String
    let singer: String
    let albumTitle: String
    let albumImage: UIImage
    let file: Data
    let lyrics: Lyrics
    let duration: Float
}
