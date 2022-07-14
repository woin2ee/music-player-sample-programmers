//
//  MusicPlayerViewModel.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/02.
//

import Foundation
import Combine
import AVFAudio

protocol MusicPlayerViewModelInput {
    func didLoad()
    func didUpdateSeekBar(value: Float)
    func setCurrentPlayTime(value: Double)
    func didTapLyricsAtFullLyricsView()
    func didTapPlayAndPauseButton()
    func didTapLyrics()
}

protocol MusicPlayerViewModelOutput {
    var music: Music? { get }
    var isPlaying: Bool { get }
    
    var musicPublisher: AnyPublisher<Music?, Never> { get }
    var isPlayingPublisher: AnyPublisher<Bool, Never> { get }
    
    var currentPlayTime: TimeInterval { get }
    var currentPlayTimeSubject: PassthroughSubject<TimeInterval, Never> { get }
    
    var fullLyricsViewDismissRequest: PassthroughSubject<Void, Never> { get }
    var showErrorAlertRequest: PassthroughSubject<String, Never> { get }
    var playRepeatRequest: PassthroughSubject<Void, Never> { get }
}

protocol MusicPlayerViewModel: MusicPlayerViewModelInput, MusicPlayerViewModelOutput {}

final class DefaultMusicPlayerViewModel: NSObject, MusicPlayerViewModel {
    
    private let musicRepository: MusicRepository
    private let coordinator: MusicPlayerCoordinator
    
    private var audioPlayer: AVAudioPlayer? {
        didSet { audioPlayer?.delegate = self }
    }
    
    // MARK: - Output
    
    @Published private(set) var music: Music? {
        didSet { updateMusicInAudioPlayer() }
    }
    @Published private(set) var isPlaying: Bool = false
    private var isRepeat: Bool = true
    
    var musicPublisher: AnyPublisher<Music?, Never> { $music.eraseToAnyPublisher() }
    var isPlayingPublisher: AnyPublisher<Bool, Never> { $isPlaying.eraseToAnyPublisher() }
    
    var currentPlayTime: TimeInterval { audioPlayer?.currentTime ?? 0 }
    var currentPlayTimeSubject: PassthroughSubject<TimeInterval, Never> = .init()
    
    var fullLyricsViewDismissRequest: PassthroughSubject<Void, Never> = .init()
    var showErrorAlertRequest: PassthroughSubject<String, Never> = .init()
    var playRepeatRequest: PassthroughSubject<Void, Never> = .init()
    
    // MARK: - Initializers
    
    init(
        musicRepository: MusicRepository,
        coordinator: MusicPlayerCoordinator
    ) {
        self.musicRepository = musicRepository
        self.coordinator = coordinator
    }
    
    func didLoad() {
        self.musicRepository.fetchMusic { result in
            switch result {
            case .success(let music):
                self.music = music
            case .failure(.invalidURL(let errorMessage)), .failure(.failDecoding(let errorMessage)):
                self.showErrorAlertRequest.send(errorMessage)
            }
        }
    }
    
    // MARK: - Input
    
    func didUpdateSeekBar(value: Float) {
        self.setCurrentPlayTime(value: Double(value))
    }
    
    func setCurrentPlayTime(value: Double) {
        audioPlayer?.currentTime = value
    }
    
    func didTapLyricsAtFullLyricsView() {
        guard let audioPlayer = audioPlayer else {
            return
        }
        
        currentPlayTimeSubject.send(audioPlayer.currentTime)
    }
    
    func didTapPlayAndPauseButton() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }
    
    func didTapLyrics() {
        coordinator.presentFullLyricsView(with: self)
    }
}

// MARK: - Private Method

private extension DefaultMusicPlayerViewModel {
    
    func updateMusicInAudioPlayer() {
        do {
            audioPlayer = try .init(data: music?.file ?? Data())
            audioPlayer?.prepareToPlay()
        } catch {
            let errorMessage = "잘못된 음악 파일입니다."
            self.showErrorAlertRequest.send(errorMessage)
        }
    }
}

extension DefaultMusicPlayerViewModel: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        if isRepeat { playRepeatRequest.send() }
    }
}
