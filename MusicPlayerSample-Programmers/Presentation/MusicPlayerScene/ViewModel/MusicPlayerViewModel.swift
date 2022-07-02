//
//  MusicPlayerViewModel.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/02.
//

import Foundation

protocol MusicPlayerViewModelInput {
}

protocol MusicPlayerViewModelOutput {
    var musicTitle: String { get }
    var musicSinger: String { get }
    var musicAlbumTitle: String { get }
    var albumImageURL: String { get }
}

protocol MusicPlayerViewModel: MusicPlayerViewModelInput, MusicPlayerViewModelOutput {}

final class DefaultMusicPlayerViewModel {
    
    private var coordinator: MusicPlayerCoordinator?
    
    init(coordinator: MusicPlayerCoordinator) {
        self.coordinator = coordinator
    }
}

extension DefaultMusicPlayerViewModel: MusicPlayerViewModel {
    
    // MARK: - Output
    
    var musicTitle: String {
        "MusicTItle"
    }
    
    var musicSinger: String {
        "MusicSinger"
    }
    
    var musicAlbumTitle: String {
        "MusicAlbumTitle"
    }
    
    var albumImageURL: String {
        "albumImageURL"
    }
}
