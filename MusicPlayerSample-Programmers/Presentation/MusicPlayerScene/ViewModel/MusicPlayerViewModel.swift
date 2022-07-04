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
    var music: Music { get }
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
    
    var music: Music {
        musicRepository.fetchMusic()
    }
}
