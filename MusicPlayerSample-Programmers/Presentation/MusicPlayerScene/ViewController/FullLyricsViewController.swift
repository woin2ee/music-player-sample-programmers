//
//  FullLyricsViewController.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/12.
//

import UIKit
import SnapKit

final class FullLyricsViewController: UIViewController {
    
    private var viewModel: MusicPlayerViewModel!
    
    lazy var dismissButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "X"
        let button = UIButton(
            configuration: config,
            primaryAction: UIAction { _ in
                self.dismiss(animated: true)
            }
        )
        return button
    }()
    
    // MARK: - Initializers
    
    convenience init(viewModel: MusicPlayerViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
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
        view.backgroundColor = .brown
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(dismissButton)
    }
    
    func setupConstraints() {
        dismissButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
