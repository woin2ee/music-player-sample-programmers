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
    private var lyricsTableViewController: LyricsTableViewController!
    private var cancellables: Set<AnyCancellable> = []
    private var seekBarControlTimer: Timer?
    private var currentPlayTimeLabelControlTimer: Timer?
    
    // MARK: - UI Components
    
    lazy var musicTitleLabel: MarqueeLabel = {
        let lbl = MarqueeLabel()
        lbl.text = viewModel.music?.title
        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
        lbl.textAlignment = .center
        lbl.speed = .duration(10.0)
        lbl.fadeLength = 10.0
        lbl.trailingBuffer = 40
        return lbl
    }()
    
    lazy var musicSingerLabel: MarqueeLabel = {
        let lbl = MarqueeLabel()
        lbl.text = viewModel.music?.singer
        lbl.font = .systemFont(ofSize: 17, weight: .regular)
        lbl.textAlignment = .center
        lbl.speed = .duration(10.0)
        lbl.fadeLength = 10.0
        lbl.trailingBuffer = 20
        return lbl
    }()
    
    lazy var albumImageView: UIImageView = {
        let imgView = UIImageView(image: viewModel.music?.albumImage)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 16
        return imgView
    }()
    
    lazy var musicAlbumLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = viewModel.music?.albumTitle
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var lyricsTableView: UITableView = lyricsTableViewController.tableView
    
    lazy var musicPlayerFooterView: MusicPlayerFooterView = {
        let footer = MusicPlayerFooterView()
        footer.seekBar.maximumValue = viewModel.music?.duration ?? 0
        footer.seekBar.isContinuous = false
        footer.seekBar.addAction(
            UIAction { _ in
                self.viewModel.didUpdateSeekBar(value: footer.seekBar.value)
                self.lyricsTableViewController.scrollLyrics(animated: false)
                self.lyricsTableViewController.makeCurrentLyricsBold()
                self.updateCurrentPlayTimeLabel()
            },
            for: .valueChanged
        )
        footer.playAndPauseButton.addAction(
            UIAction { _ in
                self.viewModel.didTapPlayAndPauseButton()
            },
            for: .touchUpInside
        )
        return footer
    }()
    
    // MARK: - Initializers
    
    convenience init(viewModel: MusicPlayerViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.lyricsTableViewController = LyricsTableViewController(viewModel: self.viewModel)
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.isPlayingPublisher
            .sink { [weak self] isPlaying in
                self?.setButtonImage(isPlaying)
                self?.controlSeekBar(isPlaying)
                self?.controlCurrentPlayTimeLabel(isPlaying)
            }
            .store(in: &cancellables)
        
        viewModel.musicPublisher
            .dropFirst()
            .sink { [weak self] music in
                self?.musicTitleLabel.text = music?.title
                self?.musicSingerLabel.text = music?.singer
                self?.albumImageView.image = music?.albumImage
                self?.musicAlbumLabel.text = music?.albumTitle
                self?.musicPlayerFooterView.seekBar.maximumValue = music?.duration ?? 0
                self?.musicPlayerFooterView.finishTimeLabel.text = music?.duration.toTimeString()
            }
            .store(in: &cancellables)
        
        viewModel.showErrorAlertRequest
            .sink { [weak self] errorMessage in
                guard let self = self else { return }
                DefaultAlert.show(view: self.view, message: errorMessage)
            }
            .store(in: &cancellables)
        
        viewModel.playRepeatRequest
            .sink { [weak self] _ in
                self?.musicPlayerFooterView.seekBar.value = 0
                self?.lyricsTableViewController.scrollLyrics(animated: false)
                self?.musicPlayerFooterView.playAndPauseButton.sendActions(for: .touchUpInside)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didLoad()
        configureSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        musicPlayerFooterView.seekBar.value = Float(viewModel.currentPlayTime)
    }
    
    deinit {
        debugPrint("deinit : \(Self.description())")
        seekBarControlTimer?.invalidate()
        currentPlayTimeLabelControlTimer?.invalidate()
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
        view.addSubview(lyricsTableView)
        view.addSubview(musicPlayerFooterView)
    }
    
    func setupConstraints() {
        musicTitleLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(2)
            make.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        musicSingerLabel.snp.makeConstraints { make in
            make.top.equalTo(musicTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        
        musicAlbumLabel.snp.makeConstraints { make in
            make.top.equalTo(musicSingerLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview()
        }
        
        albumImageView.snp.makeConstraints { make in
            make.width.equalTo(albumImageView.snp.height).offset(100)
            make.top.equalTo(musicAlbumLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        
        lyricsTableView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(albumImageView.snp.bottom).offset(40)
            make.height.equalTo(60)
            make.bottom.equalTo(musicPlayerFooterView.snp.top).offset(-60)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        musicPlayerFooterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    func setButtonImage(_ isPlaying: Bool) {
        if isPlaying {
            musicPlayerFooterView.playAndPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            musicPlayerFooterView.playAndPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    func controlSeekBar(_ isPlaying: Bool) {
        if isPlaying {
            seekBarControlTimer = .scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                if self.musicPlayerFooterView.seekBar.isTouchInside { return }
                self.musicPlayerFooterView.seekBar.value = Float(self.viewModel.currentPlayTime)
            }
            seekBarControlTimer?.tolerance = 0.1
            tuneSeekBar()
        } else {
            seekBarControlTimer?.invalidate()
        }
    }
    
    func tuneSeekBar() {
        let intervalLimit: Float = 2
        if musicPlayerFooterView.seekBar.value < Float(self.viewModel.currentPlayTime) - intervalLimit {
            musicPlayerFooterView.seekBar.value = Float(self.viewModel.currentPlayTime)
        }
    }
    
    func controlCurrentPlayTimeLabel(_ isPlaying: Bool) {
        if isPlaying {
            currentPlayTimeLabelControlTimer = .scheduledTimer(
                withTimeInterval: 0.5,
                repeats: true
            ) { [weak self] _ in
                self?.updateCurrentPlayTimeLabel()
            }
            currentPlayTimeLabelControlTimer?.tolerance = 0.1
        } else {
            currentPlayTimeLabelControlTimer?.invalidate()
        }
    }
    
    func updateCurrentPlayTimeLabel() {
        self.musicPlayerFooterView.currentPlayTimeLabel.text = Float(self.viewModel.currentPlayTime).toTimeString()
    }
}
