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
    func didTapPlayAndPauseButton()
}

protocol MusicPlayerViewModelOutput {
    var music: Music? { get }
    var isPlaying: Bool { get }
    
    var musicPublisher: AnyPublisher<Music?, Never> { get }
    var isPlayingPublisher: AnyPublisher<Bool, Never> { get }
    
    var currentPlayTime: TimeInterval { get }
}

protocol MusicPlayerViewModel: MusicPlayerViewModelInput, MusicPlayerViewModelOutput {}

final class DefaultMusicPlayerViewModel: MusicPlayerViewModel {
    
    private let musicRepository: MusicRepository
    private let coordinator: MusicPlayerCoordinator
    
    private var audioPlayer: AVAudioPlayer?
    
    // MARK: - Output
    
    @Published private(set) var music: Music? {
        didSet { updateMusicInAudioPlayer() }
    }
    @Published private(set) var isPlaying: Bool = false
    
    var musicPublisher: AnyPublisher<Music?, Never> { $music.eraseToAnyPublisher() }
    var isPlayingPublisher: AnyPublisher<Bool, Never> { $isPlaying.eraseToAnyPublisher() }
    
    var currentPlayTime: TimeInterval { audioPlayer?.currentTime ?? 0 }
    
    // MARK: - Initializers
    
    init(
        musicRepository: MusicRepository,
        coordinator: MusicPlayerCoordinator
    ) {
        self.musicRepository = musicRepository
        self.coordinator = coordinator
    }
    
    func didLoad() {
        self.musicRepository.fetchMusic { music in
            self.music = music
        }
    }
    
    // MARK: - Input
    
    func didUpdateSeekBar(value: Float) {
        audioPlayer?.currentTime = Double(value)
    }
    
    func didTapPlayAndPauseButton() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }
}

// MARK: - Private Method

private extension DefaultMusicPlayerViewModel {
    
    func updateMusicInAudioPlayer() {
        do {
            audioPlayer = try .init(data: music?.file ?? Data())
            audioPlayer?.prepareToPlay()
        } catch {
            // FIXME: 에러 처리 필요
            debugPrint("잘못된 음악 파일입니다.")
        }
    }
}
