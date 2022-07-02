//
//  MusicPlayerViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit
import SnapKit

final class MusicPlayerViewController: UIViewController {
    
    private var viewModel: MusicPlayerViewModel!
    
    // MARK: - UI Components
    
    lazy var musicTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = viewModel.musicTitle
        return lbl
    }()
    
    lazy var singerLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    lazy var albumLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    lazy var albumImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: viewModel.albumImageURL))
        return imgView
    }()
    
    // MARK: - Initializers
    
    convenience init(viewModel: MusicPlayerViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
}

private extension MusicPlayerViewController {
    
    func configureSubviews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(musicTitleLabel)
    }
    
    func setupConstraints() {
        musicTitleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
