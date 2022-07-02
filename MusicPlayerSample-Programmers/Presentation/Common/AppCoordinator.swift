//
//  AppCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashCoordinator = SplashCoordinator(navigationController: navigationController)
        splashCoordinator.start()
    }
}
