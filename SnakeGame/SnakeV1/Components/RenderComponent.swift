//
//  RenderComponent.swift
//  SnakeCopilot
//
//  Created by Alvin Yu on 6/27/23.
//

import Foundation
import GameplayKit

class RenderComponent: GKComponent {
    var nodes: [SKSpriteNode]
    
    init(nodes: [SKSpriteNode]) {
        self.nodes = nodes
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

