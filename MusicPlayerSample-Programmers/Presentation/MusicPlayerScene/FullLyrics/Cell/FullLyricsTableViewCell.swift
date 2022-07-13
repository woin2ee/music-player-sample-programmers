//
//  FullLyricsTableViewCell.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/13.
//

import UIKit

final class FullLyricsTableViewCell: UITableViewCell {

    lazy var lyricsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
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
}

private extension FullLyricsTableViewCell {
    
    func configureSubviews() {
        contentView.addSubview(lyricsLabel)
        
        lyricsLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-50)
        }
    }
}

