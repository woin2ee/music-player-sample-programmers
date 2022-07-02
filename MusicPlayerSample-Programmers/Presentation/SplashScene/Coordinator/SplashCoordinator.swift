//
//  SplashCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit

final class SplashCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashVM = DefaultSplashViewModel(coordinator: self)
        let splashVC = SplashViewController(viewModel: splashVM)
        navigationController?.setViewControllers([splashVC], animated: false)
    }
}

extension SplashCoordinator {
    
    func showMusicPlayerView() {
        let musicPlayerCoordinator = MusicPlayerCoordinator(navigationController: navigationController)
        musicPlayerCoordinator.start()
    }
}
