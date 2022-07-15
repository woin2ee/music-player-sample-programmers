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
    private var seekBarControlTimer: Timer?
    private var currentPlayTimeLabelControlTimer: Timer?
    
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
    
    lazy var selectLyricsToggleButton: UIButton = {
        let button = UIButton(primaryAction: UIAction { _ in
            self.toggleSelectable()
        })
        button.setImage(UIImage(systemName: "music.note.list"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    lazy var musicPlayerFooterView: MusicPlayerFooterView = {
        let footer = MusicPlayerFooterView()
        footer.seekBar.maximumValue = viewModel.music?.duration ?? 0
        footer.seekBar.value = Float(viewModel.currentPlayTime)
        footer.seekBar.isContinuous = false
        footer.seekBar.addAction(
            UIAction { _ in
                self.viewModel.didUpdateSeekBar(value: footer.seekBar.value)
                self.fullLyricsTableViewController.setRegularAllCell()
                self.fullLyricsTableViewController.setHighlightLyrics()
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
        footer.currentPlayTimeLabel.text = Float(viewModel.currentPlayTime).toTimeString()
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
                self?.controlCurrentPlayTimeLabel(isPlaying)
            }
            .store(in: &cancellables)
        
        viewModel.musicPublisher
            .sink { [weak self] music in
                self?.fullLyricsHeaderView.musicTitleLabel.text = music?.title
                self?.fullLyricsHeaderView.musicSingerLabel.text = music?.singer
                self?.musicPlayerFooterView.seekBar.maximumValue = music?.duration ?? 0
                self?.musicPlayerFooterView.finishTimeLabel.text = music?.duration.toTimeString()
            }
            .store(in: &cancellables)
        
        viewModel.currentPlayTimeSubject
            .sink { [weak self] currentPlayTime in
                self?.musicPlayerFooterView.seekBar.value = Float(currentPlayTime)
                self?.musicPlayerFooterView.currentPlayTimeLabel.text = Float(currentPlayTime).toTimeString()
            }
            .store(in: &cancellables)
        
        viewModel.fullLyricsViewDismissRequest
            .sink { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    deinit {
        debugPrint("deinit : \(Self.description())")
        seekBarControlTimer?.invalidate()
        currentPlayTimeLabelControlTimer?.invalidate()
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
        view.addSubview(selectLyricsToggleButton)
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
        
        selectLyricsToggleButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
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
                self.musicPlayerFooterView.seekBar.value = Float(self.viewModel.currentPlayTime)
            }
            tuneSeekBar()
            seekBarControlTimer?.tolerance = 0.1
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
                withTimeInterval: 0.2,
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
    
    func toggleSelectable() {
        fullLyricsTableViewController.isSelectableLyrics.toggle()
        if fullLyricsTableViewController.isSelectableLyrics {
            selectLyricsToggleButton.tintColor = .black
            DefaultAlert.show(view: self.view, message: "가사를 터치한 구간부터 재생됩니다.")
        } else {
            selectLyricsToggleButton.tintColor = .systemGray2
        }
    }
}
