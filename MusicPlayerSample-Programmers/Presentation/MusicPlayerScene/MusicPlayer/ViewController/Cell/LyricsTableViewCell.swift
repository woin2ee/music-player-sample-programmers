//
//  LyricsTableViewCell.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/07.
//

import UIKit
import SnapKit

final class LyricsTableViewCell: UITableViewCell {
    
    lazy var lyricsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setRegular()
    }
    
    func setBold() {
        lyricsLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    func setRegular() {
        lyricsLabel.font = .systemFont(ofSize: 16, weight: .regular)
    }
}

private extension LyricsTableViewCell {
    
    func configureSubviews() {
        contentView.addSubview(lyricsLabel)
        
        lyricsLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
