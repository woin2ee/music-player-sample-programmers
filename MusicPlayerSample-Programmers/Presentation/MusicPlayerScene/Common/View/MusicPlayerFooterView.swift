//
//  MusicPlayerFooterView.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/13.
//

import UIKit
import SnapKit

final class MusicPlayerFooterView: UIView {
    
    lazy var seekBar: SeekBar = {
        let bar = SeekBar()
        bar.minimumValue = 0
        bar.maximumValue = 1
        bar.minimumTrackTintColor = .systemPurple
        bar.maximumTrackTintColor = .systemGray4
        bar.thumbTintColor = .clear
        return bar
    }()
    
    lazy var playAndPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        return button
    }()
    
    lazy var currentPlayTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0:00"
        lbl.font = .systemFont(ofSize: 12, weight: .semibold)
        lbl.textColor = .systemPurple
        return lbl
    }()
    
    lazy var finishTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0:00"
        lbl.font = .systemFont(ofSize: 12, weight: .semibold)
        lbl.textColor = .darkGray
        return lbl
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
        self.addSubview(currentPlayTimeLabel)
        self.addSubview(finishTimeLabel)
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
        
        currentPlayTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(seekBar.snp.bottom)
            make.left.equalToSuperview().offset(2)
        }
        
        finishTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(seekBar.snp.bottom)
            make.right.equalToSuperview().offset(-2)
        }
    }
}
