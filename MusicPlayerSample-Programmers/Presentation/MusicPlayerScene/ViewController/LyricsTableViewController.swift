//
//  LyricsTableViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/07.
//

import UIKit

class LyricsTableViewController: UITableViewController {
    
    private let cellID: String = String(describing: LyricsTableViewCell.self)
    
    private var testLyrics: [String] = ["jiejfiseisjeifjsoiefjiosj", "fjeijisjeijeif", "fjeijisjeifjsiejf", "fjeiisjefj"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(LyricsTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - DataSource & Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testLyrics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? LyricsTableViewCell
        else { return UITableViewCell() }
        
        cell.lyricsLabel.text = testLyrics[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
