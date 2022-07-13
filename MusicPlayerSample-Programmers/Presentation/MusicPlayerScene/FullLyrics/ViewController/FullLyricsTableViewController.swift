//
//  FullLyricsTableViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/12.
//

import UIKit

final class FullLyricsTableViewController: UITableViewController {
    
    private let cellID: String = String(describing: FullLyricsTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(FullLyricsTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .systemGray4
        tableView.separatorStyle = .none
    }
}

// MARK: - DataSource & Delegate

extension FullLyricsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! FullLyricsTableViewCell

        cell.lyricsLabel.text = indexPath.description
        
        return cell
    }
}
