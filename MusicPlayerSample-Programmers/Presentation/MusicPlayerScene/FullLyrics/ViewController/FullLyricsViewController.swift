//
//  FullLyricsViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/12.
//

import UIKit
import SnapKit
import Combine

final class FullLyricsViewController: UIViewController {
    
    private var viewModel: MusicPlayerViewModel!
    private var fullLyricsTableViewController: FullLyricsTableViewController!
    private var cancellables: Set<AnyCancellable> = []
    private var timer: Timer?
    
    // MARK: - UI Components
    
    lazy var fullLyricsHeaderView: FullLyricsHeaderView = {
        let header = FullLyricsHeaderView()
        header.musicTitleLabel.text = viewModel.music?.title
        header.musicSingerLabel.text = viewModel.music?.singer
        header.dismissButton.addAction(
            UIAction { _ in
                self.dismiss(animated: true)
            },
            for: .touchUpInside
        )
        return header
    }()
    
    lazy var fullLyricsTableView: UITableView = fullLyricsTableViewController.tableView
    
    lazy var musicPlayerFooterView: MusicPlayerFooterView = {
        let footer = MusicPlayerFooterView()
        footer.seekBar.maximumValue = viewModel.music?.duration ?? 0
        footer.seekBar.isContinuous = false
        footer.seekBar.addAction(
            UIAction { _ in
                self.viewModel.didUpdateSeekBar(value: footer.seekBar.value)
//                self.lyricsTableViewController.scrollLyrics(animated: false)
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
        self.fullLyricsTableViewController = FullLyricsTableViewController(viewModel: self.viewModel)
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.isPlayingPublisher
            .sink { [weak self] isPlaying in
                self?.setButtonImage(isPlaying)
                self?.controlSeekBar(isPlaying)
            }
            .store(in: &cancellables)
        
        viewModel.musicPublisher
            .sink { [weak self] music in
                self?.fullLyricsHeaderView.musicTitleLabel.text = music?.title
                self?.fullLyricsHeaderView.musicSingerLabel.text = music?.singer
                self?.musicPlayerFooterView.seekBar.maximumValue = music?.duration ?? 0
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

private extension FullLyricsViewController {
    
    func configureSubviews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(fullLyricsHeaderView)
        view.addSubview(fullLyricsTableView)
        view.addSubview(musicPlayerFooterView)
    }
    
    func setupConstraints() {
        fullLyricsHeaderView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        fullLyricsTableView.snp.makeConstraints { make in
            make.top.equalTo(fullLyricsHeaderView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40 * 13)
            make.bottom.lessThanOrEqualTo(musicPlayerFooterView.snp.top).offset(-10)
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
            timer = .scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.musicPlayerFooterView.seekBar.value = Float(self.viewModel.currentPlayTime)
            }
            tuneSeekBar()
        } else {
            timer?.invalidate()
        }
    }
    
    func tuneSeekBar() {
        let intervalLimit: Float = 2
        if musicPlayerFooterView.seekBar.value < Float(self.viewModel.currentPlayTime) - intervalLimit {
            musicPlayerFooterView.seekBar.value = Float(self.viewModel.currentPlayTime)
        }
    }
}
