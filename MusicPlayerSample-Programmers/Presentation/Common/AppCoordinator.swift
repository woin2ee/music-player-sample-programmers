//
//  AppCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit

final class AppCoordinator: ParentCoordinator {
    
    var childCoordinators: [ChildCoordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let splashCoordinator = SplashCoordinator(
            parentCoordinator: self,
            navigationController: self.navigationController
        )
        self.childCoordinators.append(splashCoordinator)
        splashCoordinator.start()
    }
}
