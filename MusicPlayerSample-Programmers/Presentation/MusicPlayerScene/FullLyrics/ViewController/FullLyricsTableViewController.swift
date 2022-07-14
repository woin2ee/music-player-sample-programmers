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
    private var currentLyricsIndex: Array<Float>.Index? {
        lyricsTimetable.lastIndex(where: { $0 <= Float(viewModel.currentPlayTime) })
    }
    
    private var cancellables: Set<AnyCancellable> = []
    private var timer: Timer?
    var isSelectableLyrics: Bool = false
    
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
        playLyricsChecker()
    }
    
    deinit {
        stopLyricsChecker()
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
    
    func playLyricsChecker() {
        timer = .scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] _ in
            self?.setHighlightLyrics()
        }
        timer?.tolerance = 0.1
    }
    
    func stopLyricsChecker() {
        timer?.invalidate()
    }
}

// MARK: - Internal

extension FullLyricsTableViewController {
    
    func setRegularAllCell() {
        tableView.visibleCells.compactMap { $0 as? FullLyricsTableViewCell }.forEach {
            $0.setRegular()
        }
    }
    
    func setHighlightLyrics() {
        guard let currentLyricsIndex = currentLyricsIndex else { return }
        let currentCell = tableView.cellForRow(at: .init(row: currentLyricsIndex, section: 0)) as? FullLyricsTableViewCell
        let prevCell = tableView.cellForRow(at: .init(row: currentLyricsIndex - 1, section: 0)) as? FullLyricsTableViewCell
        currentCell?.setBold()
        prevCell?.setRegular()
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FullLyricsTableViewCell else { return }
        if indexPath.row == currentLyricsIndex {
            cell.setBold()
        } else {
            cell.setRegular()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard isSelectableLyrics else { return }
        setRegularAllCell()
        viewModel.setCurrentPlayTime(value: Double(lyricsTimetable[indexPath.row]))
        viewModel.didTapLyricsAtFullLyricsView()
    }
}
