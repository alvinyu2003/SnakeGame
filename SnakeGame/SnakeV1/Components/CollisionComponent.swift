//
//  CollisionComponent.swift
//  SnakeCopilot
//
//  Created by Alvin Yu on 6/27/23.
//

import Foundation
import GameplayKit

struct PhysicsCategories: OptionSet {
    let rawValue: UInt32
    
    static let snakeHead = PhysicsCategories(rawValue: 1 << 0) // 01
    static let snakeBody = PhysicsCategories(rawValue: 1 << 1) // 10
    static let apple = PhysicsCategories(rawValue: 1 << 2) // 100
    static let wall = PhysicsCategories(rawValue: 1 << 3) // 1000
}

class CollisionComponent: GKComponent {
    
    let categories: PhysicsCategories
    let contactTestCategories: PhysicsCategories
    
    init(categories: PhysicsCategories, contactTestCategories: PhysicsCategories) {
        self.categories = categories
        self.contactTestCategories = contactTestCategories
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
