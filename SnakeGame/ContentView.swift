//
//  ContentView.swift
//  SnakeGame
//
//  Created by Alvin Yu on 7/6/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var scene = GameScene(size: CGSize(width: 320, height: 320))

    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: scene.size.width, height: scene.size.height)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
