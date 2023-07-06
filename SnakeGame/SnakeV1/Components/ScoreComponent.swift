//
//  ScoreComponent.swift
//  SnakeCopilot
//
//  Created by Alvin Yu on 6/27/23.
//

import Foundation
import GameKit

class ScoreComponent: GKComponent {
    
    var score: Int
    
    init(score: Int = 0) {
        self.score = score
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
