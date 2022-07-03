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
    
    private var musicRepository: MusicRepository
    private var coordinator: MusicPlayerCoordinator
    
    init(
        musicRepository: MusicRepository,
        coordinator: MusicPlayerCoordinator
    ) {
        self.musicRepository = musicRepository
        self.coordinator = coordinator
    }
}

extension DefaultMusicPlayerViewModel: MusicPlayerViewModel {
    
    // MARK: - Output
    
    var musicTitle: String {
        "We Wish You A Merry Christmas"
    }
    
    var musicSinger: String {
        "챔버오케스트라"
    }
    
    var musicAlbumTitle: String {
        "캐롤 모음"
    }
    
    var albumImageURL: String {
        "albumImageURL"
    }
}
