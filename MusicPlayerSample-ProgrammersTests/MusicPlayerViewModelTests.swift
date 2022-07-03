//
//  MusicPlayerViewModelTests.swift
//  MusicPlayerSample-ProgrammersTests
//
//  Created by Jaewon on 2022/06/30.
//

import XCTest
@testable import MusicPlayerSample_Programmers

class MusicPlayerViewModelTests: XCTestCase {

    var viewModel: MusicPlayerViewModel!
    
    override func setUpWithError() throws {
        self.viewModel = DefaultMusicPlayerViewModel(musicRepository: <#T##MusicRepository#>, coordinator: <#T##MusicPlayerCoordinator#>)
    }

    override func tearDownWithError() throws {
    }
}
