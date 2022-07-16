//
//  SeekBar.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/15.
//

import UIKit

final class SeekBar: UISlider {
    
    let animateDuration: TimeInterval = 0.05
    
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        return super.thumbRect(
            forBounds: bounds,
            trackRect: rect.inset(by: .init(top: 0, left: -10, bottom: 0, right: -8)),
            value: value
        )
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        setValueCorrespondingToLocation(of: touch)
        increaseBounds()
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        makeOriginalSize()
    }
    
    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        makeOriginalSize()
    }
    
    private func setValueCorrespondingToLocation(of touch: UITouch) {
        let width = self.frame.width
        let tapPoint = touch.location(in: self)
        self.value = self.maximumValue * Float(tapPoint.x / width)
    }
    
    private func increaseBounds() {
        UIView.animate(withDuration: self.animateDuration) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        }
    }
    
    private func makeOriginalSize() {
        UIView.animate(withDuration: self.animateDuration) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}
