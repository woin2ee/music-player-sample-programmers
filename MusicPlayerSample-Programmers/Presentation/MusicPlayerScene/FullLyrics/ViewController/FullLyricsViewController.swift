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
    
    lazy var fullLyricsHeaderView: FullLyricsHeaderView = FullLyricsHeaderView()
    
    lazy var fullLyricsTableView: UITableView = fullLyricsTableViewController.tableView
    
    // MARK: - Initializers
    
    convenience init(viewModel: MusicPlayerViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.fullLyricsTableViewController = FullLyricsTableViewController(viewModel: self.viewModel)
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
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
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
    }
}
