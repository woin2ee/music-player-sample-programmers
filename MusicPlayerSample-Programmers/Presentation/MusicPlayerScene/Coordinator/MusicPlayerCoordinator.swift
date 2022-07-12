//
//  MusicPlayerCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/01.
//

import UIKit
import SnapKit

final class MusicPlayerCoordinator: NSObject, Coordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let musicPlayerVM = DefaultMusicPlayerViewModel(
            musicRepository: DefaultMusicRepository(networkService: DefaultNetworkService()),
            coordinator: self
        )
        let musicPlayerVC = MusicPlayerViewController(viewModel: musicPlayerVM)
        
        navigationController?.delegate = self
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.setViewControllers([musicPlayerVC], animated: false)
    }
}

extension MusicPlayerCoordinator {
    
    func presentFullLyricsView(with viewModel: MusicPlayerViewModel) {
        let fullLyricsVC = FullLyricsViewController(viewModel: viewModel)
        fullLyricsVC.modalTransitionStyle = .crossDissolve
        fullLyricsVC.modalPresentationStyle = .fullScreen
        navigationController?.present(fullLyricsVC, animated: true)
    }
}

extension MusicPlayerCoordinator: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return MyAnimator()
    }
}

final class MyAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        containerView.addSubview(toView)

        toView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        if transitionContext.isAnimated {
        }
        
        transitionContext.completeTransition(true)
    }
}
