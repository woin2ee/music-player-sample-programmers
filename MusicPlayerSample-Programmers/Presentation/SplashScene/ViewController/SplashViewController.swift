//
//  SplashViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit
import SnapKit

protocol SplashViewCoordinatingDelegate: AnyObject {
    func pushToMusicPlayerView()
}

final class SplashViewController: UIViewController {
    
    private weak var coordinatingDelegate: SplashViewCoordinatingDelegate?
    
    private lazy var splashImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "flo_splash"))
        return imgView
    }()
    
    convenience init(coordinatingDelegate: SplashViewCoordinatingDelegate) {
        self.init(nibName: nil, bundle: nil)
        self.coordinatingDelegate = coordinatingDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(2)
        coordinatingDelegate?.pushToMusicPlayerView()
    }
    
    private func configureSubviews() {
        view.addSubview(splashImageView)
        splashImageView.snp.makeConstraints {
            $0.top.centerX.centerY.equalToSuperview()
        }
    }
}
