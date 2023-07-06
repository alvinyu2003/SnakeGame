import GameplayKit
import SpriteKit

class GrowthSystem: GKComponentSystem<GrowthComponent> {
        
    weak var scene: GameScene?
    
    init(scene: GameScene) {
        self.scene = scene
        super.init(componentClass: GrowthComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            guard component.growAmount > 0,
                  let entity = component.entity,
                  let renderComponent = entity.component(ofType: RenderComponent.self),
                  let lastNode = renderComponent.nodes.last else {
                    continue
            }
            for _ in 0 ..< component.growAmount {
                // add and set up body node, this part needs improvement [ay]
                let bodyNode = SKSpriteNode(color: .green, size: CGSize(width: 20, height: 20))
                bodyNode.position = lastNode.position
                
                renderComponent.nodes.append(bodyNode)
                scene?.addChild(bodyNode)
                
                entity.setUpPhysicsBody(node: bodyNode, categories: [.snakeBody], contactTestCategories: [.snakeHead])
            }
            component.growAmount = 0
        }
    }
}
