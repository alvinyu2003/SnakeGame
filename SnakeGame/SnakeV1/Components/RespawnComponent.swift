//
//  RespawnComponent.swift
//  SnakeCopilot
//
//  Created by Alvin Yu on 6/27/23.
//

import Foundation
import GameplayKit

class RespawnComponent: GKComponent {
    
    var needsRespawn: Bool
    
    init(needsRespawn: Bool = true) {
        self.needsRespawn = needsRespawn
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
