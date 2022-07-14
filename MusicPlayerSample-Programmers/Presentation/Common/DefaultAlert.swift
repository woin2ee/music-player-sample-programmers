//
//  DefaultAlert.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/07/14.
//

import UIKit

final class DefaultAlert {
    
    static func show(view: UIView, message : String) {
        let width: CGFloat = 300
        let height: CGFloat = 35
        
        let toastLabel: UILabel = {
            let lbl = UILabel(
                frame: CGRect(
                    x: view.frame.size.width / 2 - (width / 2),
                    y: view.frame.size.height - 250,
                    width: width,
                    height: height
                )
            )
            lbl.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            lbl.textColor = UIColor.white
            lbl.font = .systemFont(ofSize: 16, weight: .regular)
            lbl.textAlignment = .center;
            lbl.text = message
            lbl.alpha = 1.0
            lbl.layer.cornerRadius = 10;
            lbl.clipsToBounds = true
            return lbl
        }()
        
        view.addSubview(toastLabel)
        UIView.animate(
            withDuration: 0.5,
            delay: 1.5,
            options: .curveEaseOut,
            animations: {
                toastLabel.alpha = 0.0
            },
            completion: { _ in
                toastLabel.removeFromSuperview()
            }
        )
    }
}
