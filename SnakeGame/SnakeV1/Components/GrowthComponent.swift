//
//  GrowthComponent.swift
//  SnakeCopilot
//
//  Created by Alvin Yu on 6/27/23.
//

import Foundation
import GameplayKit

class GrowthComponent: GKComponent {

    var growAmount: Int

    init(growthAmount: Int = 0) {
        self.growAmount = growthAmount
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
