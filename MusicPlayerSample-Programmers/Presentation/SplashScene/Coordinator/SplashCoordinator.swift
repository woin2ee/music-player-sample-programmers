//
//  SplashCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit

final class SplashCoordinator: ParentCoordinator, ChildCoordinator {
    
    weak var parentCoordinator: ParentCoordinator?
    var childCoordinators: [ChildCoordinator] = []
    var navigationController: UINavigationController
    
    init(
        parentCoordinator: ParentCoordinator,
        navigationController: UINavigationController
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let splashVC = SplashViewController(coordinatingDelegate: self)
        navigationController.pushViewController(splashVC, animated: true)
    }
}

extension SplashCoordinator: SplashViewCoordinatingDelegate {
    
    func pushToMusicPlayerView() {
        let musicPlayerCoordinator = MusicPlayerCoordinator(
            parentCoordinator: self,
            navigationController: self.navigationController
        )
        childCoordinators.append(musicPlayerCoordinator)
        musicPlayerCoordinator.start()
    }
}
