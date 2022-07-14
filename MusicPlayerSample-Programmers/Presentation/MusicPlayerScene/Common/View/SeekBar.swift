//
//  SeekBar.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/15.
//

import UIKit

final class SeekBar: UISlider {
    
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        return super.thumbRect(
            forBounds: bounds,
            trackRect: rect.inset(by: .init(top: 0, left: -10, bottom: 0, right: -8)),
            value: value
        )
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let width = self.frame.width
        let tapPoint = touch.location(in: self)
        self.value = self.maximumValue * Float(tapPoint.x / width)
        return true
    }
}
