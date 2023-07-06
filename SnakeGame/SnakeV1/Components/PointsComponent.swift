//
//  PointsComponent.swift
//  SnakeCopilot
//
//  Created by Alvin Yu on 6/27/23.
//

import Foundation
import GameplayKit

class PointsComponent: GKComponent {

    var points: Int

    init(points: Int = 0) {
        self.points = points
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
