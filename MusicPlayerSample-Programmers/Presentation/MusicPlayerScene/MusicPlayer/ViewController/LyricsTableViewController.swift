//
//  LyricsTableViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/07.
//

import UIKit
import Combine

final class LyricsTableViewController: UITableViewController {
    
    private let cellID: String = String(describing: LyricsTableViewCell.self)
    private var viewModel: MusicPlayerViewModel!
    
    private var lyrics: Lyrics = [:]
    private var lyricsTimetable: [Float] {
        self.lyrics.sorted { $0.key < $1.key }.map { $0.key }
    }
    private var currentLyricsIndex: Array<Float>.Index? {
        lyricsTimetable.lastIndex(where: { $0 <= Float(viewModel.currentPlayTime) })
    }

    
    private var cancellables: Set<AnyCancellable> = []
    private var timer: Timer?
    
    // MARK: - Initializers
    
    convenience init(viewModel: MusicPlayerViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
        playLyricsChecker()
    }
    
    deinit {
        stopLyricsChecker()
    }
}

// MARK: - Private

private extension LyricsTableViewController {
    
    func configureTableView() {
        tableView.register(LyricsTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
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
    
    func playLyricsChecker() {
        timer = .scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] _ in
            self?.scrollLyrics(animated: true)
            self?.makeCurrentLyricsBold()
        }
        timer?.tolerance = 0.1
    }
    
    func stopLyricsChecker() {
        timer?.invalidate()
    }
}

// MARK: - Internal

extension LyricsTableViewController {
    
    func scrollLyrics(animated: Bool) {
        let currentLyricsIndex = currentLyricsIndex ?? 0
        tableView.selectRow(
            at: .init(row: currentLyricsIndex, section: 0),
            animated: animated,
            scrollPosition: .top
        )
    }
    
    func makeCurrentLyricsBold() {
        guard
            let _ = currentLyricsIndex,
            let currentCell = tableView.visibleCells[0] as? LyricsTableViewCell,
            let nextCell = tableView.visibleCells[1] as? LyricsTableViewCell
        else { return }
        currentCell.setBold()
        nextCell.setRegular()
    }
}

// MARK: - DataSource & Delegate

extension LyricsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyrics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? LyricsTableViewCell
        else { return UITableViewCell() }
        
        cell.lyricsLabel.text = lyrics.sorted { $0.key < $1.key }.map { $0.value }[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapLyrics()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? LyricsTableViewCell else { return }
        cell.setRegular()
    }
}
