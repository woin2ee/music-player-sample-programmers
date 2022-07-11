//
//  LyricsTableViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/07.
//

import UIKit
import Combine

class LyricsTableViewController: UITableViewController {
    
    private let cellID: String = String(describing: LyricsTableViewCell.self)
    private var viewModel: MusicPlayerViewModel!
    private var lyrics: Lyrics = [:]
    private var cancellables: Set<AnyCancellable> = []
    
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
    }
    
    private func configureTableView() {
        tableView.register(LyricsTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func bindViewModel() {
        viewModel.musicPublisher
            .sink { [weak self] music in
                self?.lyrics = music?.lyrics ?? [:]
            }
            .store(in: &cancellables)
    }
    
    // MARK: - DataSource & Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyrics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? LyricsTableViewCell
        else { return UITableViewCell() }
        
        cell.lyricsLabel.text = lyrics.sorted { $0.key < $1.key }.map { $0.value }[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
