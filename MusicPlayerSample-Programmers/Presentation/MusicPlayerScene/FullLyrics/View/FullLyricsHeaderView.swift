//
//  FullLyricsHeaderView.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/13.
//

import UIKit
import SnapKit
import MarqueeLabel

final class FullLyricsHeaderView: UIView {

    lazy var musicTitleLabel: MarqueeLabel = {
        let lbl = MarqueeLabel()
        lbl.text = "Music Title Label"
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.textAlignment = .left
        lbl.speed = .duration(10.0)
        lbl.fadeLength = 10.0
        lbl.trailingBuffer = 40
        return lbl
    }()
    
    lazy var musicSingerLabel: MarqueeLabel = {
        let lbl = MarqueeLabel()
        lbl.text = "Singer Label"
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.textAlignment = .left
        lbl.speed = .duration(10.0)
        lbl.fadeLength = 10.0
        lbl.trailingBuffer = 20
        return lbl
    }()
    
    lazy var dismissButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "X"
        config.baseForegroundColor = .black
        return UIButton(configuration: config)
    }()
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(frame: CGRect())
        configureSubviews()
    }
}

// MARK: - Private

private extension FullLyricsHeaderView {
    
    func configureSubviews() {
        self.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        self.addSubview(musicTitleLabel)
        self.addSubview(musicSingerLabel)
        self.addSubview(dismissButton)
    }
    
    func setupConstraints() {
        musicTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        musicSingerLabel.snp.makeConstraints { make in
            make.top.equalTo(musicTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        dismissButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
    }
}
