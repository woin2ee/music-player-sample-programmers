//
//  MusicPlayerViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit
import SnapKit
import Combine
import MarqueeLabel

final class MusicPlayerViewController: UIViewController {
    
    private var viewModel: MusicPlayerViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    
    lazy var musicTitleLabel: MarqueeLabel = {
        let lbl = MarqueeLabel()
        lbl.text = viewModel.music.title
        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
        lbl.textAlignment = .center
        lbl.speed = .duration(10.0)
        lbl.fadeLength = 10.0
        lbl.trailingBuffer = 40
        return lbl
    }()
    
    lazy var musicSingerLabel: MarqueeLabel = {
        let lbl = MarqueeLabel()
        lbl.text = viewModel.music.singer
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textAlignment = .center
        lbl.speed = .duration(10.0)
        lbl.fadeLength = 10.0
        lbl.trailingBuffer = 20
        return lbl
    }()
    
    lazy var albumImageView: UIImageView = {
        let imgView = UIImageView(image: viewModel.music.albumImage)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 16
        return imgView
    }()
    
    lazy var musicAlbumLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = viewModel.music.albumTitle
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var playAndPauseButton: UIButton = {
        let button = UIButton(primaryAction: UIAction { _ in
            self.viewModel.didTapPlayAndPauseButton()
        })
        button.tintColor = .black
        return button
    }()
    
    lazy var seekBar: UISlider = {
        let bar = UISlider()
        bar.minimumValue = 0
        bar.maximumValue = viewModel.music.duration
        bar.minimumTrackTintColor = .systemBlue
        bar.maximumTrackTintColor = .systemGray4
//        bar.setThumbImage(UIImage(systemName: "star"), for: .normal)
//        bar.thumbTintColor = .clear
        bar.isContinuous = false
        bar.addAction(
            UIAction { _ in
                self.viewModel.didUpdateSeekBar(value: bar.value)
            },
            for: .valueChanged
        )
        return bar
    }()
    
    // MARK: - Initializers
    
    convenience init(viewModel: MusicPlayerViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.bindToViewModel()
    }
    
    private func bindToViewModel() {
        viewModel.isPlayingPublisher
            .sink { [weak self] isPlaying in
                self?.setButtonImage(isPlaying)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
}

// MARK: - Configure UI

private extension MusicPlayerViewController {
    
    func configureSubviews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(musicTitleLabel)
        view.addSubview(musicSingerLabel)
        view.addSubview(albumImageView)
        view.addSubview(musicAlbumLabel)
        view.addSubview(seekBar)
        view.addSubview(playAndPauseButton)
    }
    
    func setupConstraints() {
        navigationController?.navigationBar.backgroundColor = .brown
        
        musicTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        musicSingerLabel.snp.makeConstraints { make in
            make.top.equalTo(musicTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        
        albumImageView.snp.makeConstraints { make in
            make.width.equalTo(albumImageView.snp.height).offset(100)
            make.top.equalTo(musicSingerLabel.snp.bottom).offset(38)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        
        musicAlbumLabel.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        
        
        seekBar.snp.makeConstraints { make in
            make.bottom.equalTo(playAndPauseButton.snp.top)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        playAndPauseButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    func setButtonImage(_ isPlaying: Bool) {
        if isPlaying {
            playAndPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            playAndPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
}
