//
//  FullLyricsTableViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/12.
//

import UIKit
import Combine

final class FullLyricsTableViewController: UITableViewController {
    
    private let cellID: String = String(describing: FullLyricsTableViewCell.self)
    private var viewModel: MusicPlayerViewModel!
    
    private var lyrics: Lyrics = [:]
    private var lyricsTimetable: [Float] {
        self.lyrics.sorted { $0.key < $1.key }.map { $0.key }
    }
    
    private var cancellables: Set<AnyCancellable> = []
    private var timer: Timer?
    
    // MARK: - Initializers
    
    convenience init(viewModel: MusicPlayerViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.lyrics = self.viewModel.music?.lyrics ?? [:]
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
}

// MARK: - Private

private extension FullLyricsTableViewController {
    
    func configureTableView() {
        tableView.register(FullLyricsTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
    }
    
    func bindViewModel() {
        viewModel.musicPublisher
            .dropFirst()
            .sink { [weak self] music in
                self?.lyrics = music?.lyrics ?? [:]
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func playLyricsChecker() {
        timer = .scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.scrollLyrics(animated: true)
        }
        timer?.tolerance = 0.2
    }
    
    private func stopLyricsChecker() {
        timer?.invalidate()
    }
    
    func scrollLyrics(animated: Bool) {
        guard let currentLyricsIndex = lyricsTimetable.lastIndex(where: { $0 < Float(viewModel.currentPlayTime) }) else { return }
        tableView.selectRow(
            at: .init(row: currentLyricsIndex, section: 0),
            animated: animated,
            scrollPosition: .top
        )
    }
}

// MARK: - DataSource & Delegate

extension FullLyricsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyrics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! FullLyricsTableViewCell
        
        cell.lyricsLabel.text = lyrics.sorted { $0.key < $1.key }.map { $0.value }[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
