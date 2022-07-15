//
//  PlayTimeConvertToStringTests.swift
//  MusicPlayerSample-ProgrammersTests
//
//  Created by Jaewon on 2022/07/15.
//

import XCTest

class PlayTimeConvertToStringTests: XCTestCase {

    func test_duration에서_분_추출() {
        // given
        let duration: Float = 193
        
        // when
        let minute = Int(duration) / 60
        
        // then
        XCTAssertEqual(minute, 3)
    }
    
    func test_재생시간_String_변환() throws {
        // given
        let duration1: Float = 72
        let duration2: Float = 180
        let duration3: Float = 183
        
        // when
        let durationText1: String = duration1.toTimeString()
        let durationText2: String = duration2.toTimeString()
        let durationText3: String = duration3.toTimeString()
        
        // then
        XCTAssertEqual(durationText1, "1:12")
        XCTAssertEqual(durationText2, "3:00")
        XCTAssertEqual(durationText3, "3:03")
    }
}

extension Float {
    
    func toTimeString() -> String {
        let minute = Int(self) / 60
        let second = Int(self) % 60
        return second < 10 ? "\(minute):0\(second)" : "\(minute):\(second)"
    }
}
