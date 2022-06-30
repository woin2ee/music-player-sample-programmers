//
//  SplashCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit

final class SplashCoordinator: ChildCoordinator {
    
    var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashVC = SplashViewController()
        navigationController.pushViewController(splashVC, animated: true)
    }
}
