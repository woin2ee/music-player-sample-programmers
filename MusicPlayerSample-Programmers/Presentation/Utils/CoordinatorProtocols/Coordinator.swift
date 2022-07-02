//
//  Coordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    
    func start()
}
