//
//  FullLyricsHeaderView.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/13.
//

import UIKit
import SnapKit

final class FullLyricsHeaderView: UIView {

    lazy var dismissButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "X"
        config.baseForegroundColor = .black
        return UIButton(configuration: config)
    }()
    
    convenience init() {
        self.init(frame: CGRect())
        configureSubviews()
    }
    
    private func configureSubviews() {
        self.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(dismissButton)
    }
    
    private func setupConstraints() {
        dismissButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
