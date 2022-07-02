//
//  SplashViewModel.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/02.
//

import Foundation

protocol SplashViewModelInput {
    func showMusicPlayerView()
}

protocol SplashViewModel: SplashViewModelInput {}

final class DefaultSplashViewModel {
    
    private var coordinator: SplashCoordinator
    
    init(coordinator: SplashCoordinator) {
        self.coordinator = coordinator
    }
}

extension DefaultSplashViewModel: SplashViewModel {
    
    func showMusicPlayerView() {
        coordinator.showMusicPlayerView()
    }
}
