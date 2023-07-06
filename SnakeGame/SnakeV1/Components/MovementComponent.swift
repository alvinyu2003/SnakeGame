//
//  MovementComponent.swift
//  SnakeCopilot
//
//  Created by Alvin Yu on 6/27/23.
//

import Foundation
import GameplayKit

class MovementComponent: GKComponent {
    var direction: CGVector
//    var speed: CGFloat = 0.1 // If each body segment is 20 points in size, and you're running your game at 60 frames per second, a reasonable speed might be 20.0 / 60.0 = 0.33 points per frame.
//    var duration: TimeInterval
    
    init(duration: TimeInterval = 1.0,
         direction: CGVector = CGVector(dx: 1.0, dy: 0.0),
         directions: [CGVector] = []) {
//        self.duration = duration
        self.direction = direction
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
