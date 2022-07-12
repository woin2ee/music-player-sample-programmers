//
//  LyricsTableViewTests.swift
//  MusicPlayerSample-ProgrammersTests
//
//  Created by Jaewon on 2022/07/12.
//

import XCTest

class LyricsTableViewTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_currentLyricsIndex1() throws {
        // given
        let playTimeArr: [Float] = [16.2, 18.3, 21.1, 23.6, 26.3, 28.7, 31.4, 33.6, 36.5, 38.9, 41.5, 44.2, 46.6, 49.3, 52.2, 54.5, 57.0, 59.7, 62.1, 64.8, 67.4, 70.0, 72.5, 75.0, 77.7, 80.2, 82.8, 85.3, 89.8, 131.9, 134.0, 136.5, 139.4, 142.0, 144.4, 147.0, 149.6, 152.2, 154.5, 157.2, 160.0, 162.4, 165.0, 167.6, 170.2, 172.6, 175.3, 177.9, 180.5]
        let currentPlayTime: TimeInterval = 17
        
        // when
        let currentLyricsIndex: Int = playTimeArr.lastIndex(where: { $0 < Float(currentPlayTime) }) ?? 0
        
        // then
        XCTAssertEqual(currentLyricsIndex, 0)
        XCTAssertNotEqual(currentLyricsIndex, 1)
    }
    
    func test_currentLyricsIndex2() throws {
        // given
        let playTimeArr: [Float] = [16.2, 18.3, 21.1, 23.6, 26.3, 28.7, 31.4, 33.6, 36.5, 38.9, 41.5, 44.2, 46.6, 49.3, 52.2, 54.5, 57.0, 59.7, 62.1, 64.8, 67.4, 70.0, 72.5, 75.0, 77.7, 80.2, 82.8, 85.3, 89.8, 131.9, 134.0, 136.5, 139.4, 142.0, 144.4, 147.0, 149.6, 152.2, 154.5, 157.2, 160.0, 162.4, 165.0, 167.6, 170.2, 172.6, 175.3, 177.9, 180.5]
        let currentPlayTime: TimeInterval = 22
        
        // when
        let currentLyricsIndex: Int = playTimeArr.lastIndex(where: { $0 < Float(currentPlayTime) }) ?? 0
        
        // then
        XCTAssertNotEqual(currentLyricsIndex, 1)
        XCTAssertEqual(currentLyricsIndex, 2)
        XCTAssertNotEqual(currentLyricsIndex, 3)
    }
    
    func test_currentLyricsIndex3() throws {
        // given
        let playTimeArr: [Float] = [16.2, 18.3, 21.1, 23.6, 26.3, 28.7, 31.4, 33.6, 36.5, 38.9, 41.5, 44.2, 46.6, 49.3, 52.2, 54.5, 57.0, 59.7, 62.1, 64.8, 67.4, 70.0, 72.5, 75.0, 77.7, 80.2, 82.8, 85.3, 89.8, 131.9, 134.0, 136.5, 139.4, 142.0, 144.4, 147.0, 149.6, 152.2, 154.5, 157.2, 160.0, 162.4, 165.0, 167.6, 170.2, 172.6, 175.3, 177.9, 180.5]
        let currentPlayTime: TimeInterval = 0
        
        // when
        let currentLyricsIndex: Int = playTimeArr.lastIndex(where: { $0 < Float(currentPlayTime) }) ?? 0
        
        // then
        XCTAssertEqual(currentLyricsIndex, 0)
        XCTAssertNotEqual(currentLyricsIndex, 1)
    }
}
