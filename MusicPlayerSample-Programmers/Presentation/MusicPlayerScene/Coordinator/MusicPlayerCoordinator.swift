//
//  MusicPlayerCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/01.
//

import UIKit

final class MusicPlayerCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let musicPlayerVM = DefaultMusicPlayerViewModel(coordinator: self)
        let musicPlayerVC = MusicPlayerViewController(viewModel: musicPlayerVM)
        navigationController?.pushViewController(musicPlayerVC, animated: false)
    }
}
