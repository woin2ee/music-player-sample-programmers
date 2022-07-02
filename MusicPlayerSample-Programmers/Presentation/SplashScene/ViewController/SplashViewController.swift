//
//  SplashViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    private var viewModel: SplashViewModel?
    
    private lazy var splashImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "flo_splash"))
        return imgView
    }()
    
    // MARK: - Initializers
    
    convenience init(viewModel: SplashViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(2)
        viewModel?.showMusicPlayerView()
    }
}

// MARK: - Private

private extension SplashViewController {
    
    private func configureSubviews() {
        view.addSubview(splashImageView)
        splashImageView.snp.makeConstraints {
            $0.top.centerX.centerY.equalToSuperview()
        }
    }
}
