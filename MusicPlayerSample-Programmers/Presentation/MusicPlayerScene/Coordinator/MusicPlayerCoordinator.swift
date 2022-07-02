//
//  MusicPlayerCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/01.
//

import UIKit

final class MusicPlayerCoordinator: ChildCoordinator {
    
    var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController
    
    init(
        parentCoordinator: ParentCoordinator,
        navigationController: UINavigationController
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let musicPlayerVC = MusicPlayerViewController(viewModel: DefaultMusicPlayerViewModel())
        navigationController.pushViewController(musicPlayerVC, animated: false)
    }
}
