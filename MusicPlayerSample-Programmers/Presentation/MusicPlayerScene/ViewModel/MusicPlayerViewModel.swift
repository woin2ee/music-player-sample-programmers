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
    func didUpdateSeekBar(value: Float)
    func didTapPlayAndPauseButton()
}

protocol MusicPlayerViewModelOutput {
    var music: Music { get }
    
    var isPlaying: Bool { get }
    var isPlayingPublisher: AnyPublisher<Bool, Never> { get }
}

protocol MusicPlayerViewModel: MusicPlayerViewModelInput, MusicPlayerViewModelOutput {}

final class DefaultMusicPlayerViewModel: MusicPlayerViewModel {
    
    private let musicRepository: MusicRepository
    private let coordinator: MusicPlayerCoordinator
    
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    
    // MARK: - Output
    
    var music: Music {
        didSet { updateMusicInAudioPlayer() }
    }
    
    @Published private(set) var isPlaying: Bool = false
    var isPlayingPublisher: AnyPublisher<Bool, Never> { $isPlaying.eraseToAnyPublisher() }
    
    // MARK: - Initializers
    
    init(
        musicRepository: MusicRepository,
        coordinator: MusicPlayerCoordinator
    ) {
        self.musicRepository = musicRepository
        self.coordinator = coordinator
        self.music = self.musicRepository.fetchMusic()
        updateMusicInAudioPlayer()
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
        
        
//        guard let audioPlayer = audioPlayer else { return }
//
//        audioPlayer.prepareToPlay()
//        if audioPlayer.isPlaying {
//            seekBarProgressTimer?.invalidate()
//            audioPlayer.pause()
//            playAndPauseButton.setTitle("재생", for: .normal)
//        } else {
//            seekBarProgressTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//                self.seekBar.value += 1
//            }
//            seekBarProgressTimer?.tolerance = 0.2
//            audioPlayer.play()
//            playAndPauseButton.setTitle("일시정지", for: .normal)
//        }
    }
}

// MARK: - Private Method

private extension DefaultMusicPlayerViewModel {
    
    func updateMusicInAudioPlayer() {
        do {
            audioPlayer = try .init(data: music.file)
            audioPlayer?.prepareToPlay()
        } catch {
            // FIXME: 에러 처리 필요
            debugPrint("잘못된 음악 파일입니다.")
        }
    }
}
