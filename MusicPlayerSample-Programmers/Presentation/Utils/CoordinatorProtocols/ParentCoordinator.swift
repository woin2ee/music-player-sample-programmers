//
//  ParentCoordinator.swift
//  MusicPlayerSample-Programmers
//
//  Created by Jaewon on 2022/06/30.
//

protocol ParentCoordinator: Coordinator {
    var childCoordinators: [ChildCoordinator] { get set }
    
    func childDidFinish(_ child: ChildCoordinator?)
    func childDidFinish(_ child: (ParentCoordinator & ChildCoordinator)?)
}

extension ParentCoordinator {
    func childDidFinish(_ child: ChildCoordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func childDidFinish(_ child: (ParentCoordinator & ChildCoordinator)?) {
        guard
            let child = child,
            child.childCoordinators.isEmpty
        else { return }
        
        self.childDidFinish(child as ChildCoordinator)
    }
}
