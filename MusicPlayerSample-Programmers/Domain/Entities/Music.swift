//
//  Music.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/04.
//

import UIKit

typealias Lyrics = [Float:String]

struct Music {
    let title: String
    let singer: String
    let albumTitle: String
    var albumImage: UIImage
    var file: Data
    let lyrics: Lyrics
    let duration: Float
}
