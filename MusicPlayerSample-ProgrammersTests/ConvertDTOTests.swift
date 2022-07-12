//
//  ConvertDTOTests.swift
//  MusicPlayerSample-ProgrammersTests
//
//  Created by Jaewon on 2022/07/12.
//

import XCTest
@testable import MusicPlayerSample_Programmers

class ConvertDTOTests: XCTestCase {

    var musicResponseDTO: MusicResponseDTO!
    
    override func setUpWithError() throws {
        musicResponseDTO = MusicResponseDTO(
            singer: "",
            album: "",
            title: "",
            duration: 0,
            image: "",
            file: "",
            lyrics: "[00:16:200]we wish you a merry christmas\n[00:18:300]we wish you a merry christmas\n[00:21:100]we wish you a merry christmas\n[00:23:600]and a happy new year\n[00:26:300]we wish you a merry christmas\n[00:28:700]we wish you a merry christmas\n[00:31:400]we wish you a merry christmas\n[00:33:600]and a happy new year\n[00:36:500]good tidings we bring\n[00:38:900]to you and your kin\n[00:41:500]good tidings for christmas\n[00:44:200]and a happy new year\n[00:46:600]Oh, bring us some figgy pudding\n[00:49:300]Oh, bring us some figgy pudding\n[00:52:200]Oh, bring us some figgy pudding\n[00:54:500]And bring it right here\n[00:57:000]Good tidings we bring \n[00:59:700]to you and your kin\n[01:02:100]Good tidings for Christmas \n[01:04:800]and a happy new year\n[01:07:400]we wish you a merry christmas\n[01:10:000]we wish you a merry christmas\n[01:12:500]we wish you a merry christmas\n[01:15:000]and a happy new year\n[01:17:700]We won't go until we get some\n[01:20:200]We won't go until we get some\n[01:22:800]We won't go until we get some\n[01:25:300]So bring some out here\n[01:29:800]연주\n[02:11:900]Good tidings we bring \n[02:14:000]to you and your kin\n[02:16:500]good tidings for christmas\n[02:19:400]and a happy new year\n[02:22:000]we wish you a merry christmas\n[02:24:400]we wish you a merry christmas\n[02:27:000]we wish you a merry christmas\n[02:29:600]and a happy new year\n[02:32:200]Good tidings we bring \n[02:34:500]to you and your kin\n[02:37:200]Good tidings for Christmas \n[02:40:000]and a happy new year\n[02:42:400]Oh, bring us some figgy pudding\n[02:45:000]Oh, bring us some figgy pudding\n[02:47:600]Oh, bring us some figgy pudding\n[02:50:200]And bring it right here\n[02:52:600]we wish you a merry christmas\n[02:55:300]we wish you a merry christmas\n[02:57:900]we wish you a merry christmas\n[03:00:500]and a happy new year"
        )
    }

    override func tearDownWithError() throws {
    }

    func test_convertLyrics() throws {
        let lyrics = musicResponseDTO.lyrics
        let lyricsArr = lyrics.components(separatedBy: "\n")
        
        let l = lyricsArr[0]
        
        let minute = l.slice(from: 1, to: 2)
        let second = l.slice(from: 4, to: 5)
        let millisecond = l.slice(from: 7, to: 7)
        
        print("\(minute).\(second).\(millisecond).")
        
        guard
            let m = Float(minute),
            let s = Float(second),
            let ms = Float(millisecond)
        else { return }
        
        let duration: Float = (m * 60) + s + (ms / 10)
        
        XCTAssertEqual(duration, 16.2)
        XCTAssertEqual(l.slice(from: 11), "we wish you a merry christmas")
    }
}

extension String {
    func slice(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
    
    func slice(from: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.endIndex
        return String(self[startIndex..<endIndex])
    }
}
