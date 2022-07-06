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

final class DefaultSplashViewModel: SplashViewModel {
    
    private let coordinator: SplashCoordinator
    
    init(coordinator: SplashCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Input
    
    func showMusicPlayerView() {
        coordinator.showMusicPlayerView()
    }
}
