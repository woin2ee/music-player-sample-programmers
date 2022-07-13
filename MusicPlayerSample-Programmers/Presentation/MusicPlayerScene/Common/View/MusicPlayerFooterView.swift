//
//  MusicPlayerFooterView.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/13.
//

import UIKit
import SnapKit

final class MusicPlayerFooterView: UIView {
    
    lazy var seekBar: UISlider = {
        let bar = UISlider()
        bar.minimumValue = 0
        bar.maximumValue = 1
        bar.minimumTrackTintColor = .systemBlue
        bar.maximumTrackTintColor = .systemGray4
        return bar
    }()
    
    lazy var playAndPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        return button
    }()
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(frame: CGRect())
        configureSubviews()
    }
}

// MARK: - Private

private extension MusicPlayerFooterView {
    
    func configureSubviews() {
        self.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        self.addSubview(seekBar)
        self.addSubview(playAndPauseButton)
    }
    
    func setupConstraints() {
        seekBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(playAndPauseButton.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        playAndPauseButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
