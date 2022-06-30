//
//  SplashViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    private lazy var splashImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "flo_splash"))
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    private func configureSubviews() {
        view.addSubview(splashImageView)
        splashImageView.snp.makeConstraints {
            $0.top.centerX.centerY.equalToSuperview()
        }
    }
}
