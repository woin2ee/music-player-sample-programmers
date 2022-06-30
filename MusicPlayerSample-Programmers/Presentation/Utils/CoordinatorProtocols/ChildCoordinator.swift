//
//  ChildCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

protocol ChildCoordinator: Coordinator {
    // must be declared 'weak' for avoid retain cycle
    var parentCoordinator: ParentCoordinator? { get set }
}
