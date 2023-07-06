import GameplayKit
import SpriteKit

class CollisionSystem: GKComponentSystem<CollisionComponent>, SKPhysicsContactDelegate {
    
    weak var scene: GameScene?
    
    init(scene: GameScene) {
        self.scene = scene
        super.init(componentClass: CollisionComponent.self)
        scene.physicsWorld.contactDelegate = self // using SpriteKit for collision and contact detection instead of overriding func update(deltaTime seconds: TimeInterval) [ay]
    }
    
    // MARK: - SKPhysicsContactDelegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let entityA = nodeA.entity,
              let nodeB = contact.bodyB.node, let entityB = nodeB.entity,
              let componentA = entityA.component(ofType: CollisionComponent.self),
              let componentB = entityB.component(ofType: CollisionComponent.self) else {
                return
        }
        
//        print("Collision between collisionComponentA: \(componentA.categories) and collisionComponentB: \(componentB.categories)")
        print("collision between \(entityA) and \(entityB)")
        print("categoryA: \(componentA.categories) and categoryB: \(componentB.categories)")

        var apple: CollisionComponent?

        if componentA.categories == .apple {
            apple = componentA
        } else if componentB.categories == .apple {
            apple = componentB
        }

        var snake: CollisionComponent? // this is not working correctly because the snake entity has multiple `CollisionComponent`s

        if componentA.categories == .snakeHead {
            snake = componentA
        } else if componentB.categories == .snakeHead {
            snake = componentB
        }

        if let appleEntity = apple?.entity,
           let snakeEntity = snake?.entity {
                if let scoreComponent = snakeEntity.component(ofType: ScoreComponent.self),
                   let pointsComponent = appleEntity.component(ofType: PointsComponent.self) {
                    scoreComponent.score += pointsComponent.points
                }
                if let respawnComponent = appleEntity.component(ofType: RespawnComponent.self) {
                    respawnComponent.needsRespawn = true
                }
                if let growComponent = snakeEntity.component(ofType: GrowthComponent.self) {
                    growComponent.growAmount = 1
                }
        } else {
            scene?.transitionToGameOver()
        }

    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        // Handle end of collision if necessary
    }
}
