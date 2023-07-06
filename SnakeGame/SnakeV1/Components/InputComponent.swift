//
//  InputComponent.swift
//  SnakeCopilot
//
//  Created by Alvin Yu on 6/27/23.
//

import Foundation
import GameplayKit

class InputComponent: GKComponent {
    var direction: CGVector

    init(direction: CGVector = .zero) {
        self.direction = direction
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
