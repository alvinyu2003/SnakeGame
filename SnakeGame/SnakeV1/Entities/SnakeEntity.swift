import Foundation
import GameplayKit

class SnakeEntity: GKEntity {
    
    init(position: CGPoint) {
        super.init()
        
        let head = SKSpriteNode(color: .green, size: CGSize(width: 20, height: 20))
        head.position = position

        // add 2 body nodes
        let body1 = SKSpriteNode(color: .green, size: CGSize(width: 20, height: 20))
        body1.position = CGPoint(x: head.position.x - 20, y: head.position.y)
        
        let body2 = SKSpriteNode(color: .green, size: CGSize(width: 20, height: 20))
        body2.position = CGPoint(x: head.position.x - 40, y: head.position.y)

        let bodyNodes = [body1, body2]

        let renderComponent = RenderComponent(nodes: [head] + bodyNodes)
        addComponent(renderComponent)
        
        let movementComponent = MovementComponent()
        addComponent(movementComponent)
        
        let inputComponent = InputComponent(direction: CGVector(dx: 1, dy: 0))
        addComponent(inputComponent)
        
        let collisionComponent = CollisionComponent(categories: [.snakeHead], contactTestCategories: [.apple, .wall, .snakeBody])
        addComponent(collisionComponent)
        
        setUpPhysicsBody(node: head, categories: collisionComponent.categories, contactTestCategories: collisionComponent.contactTestCategories, padding: 2.0)
        
        // head can collide with body [ay]
        for node in bodyNodes {
            setUpPhysicsBody(node: node, categories: [.snakeBody], contactTestCategories: [.snakeHead], padding: 2.0)
        }
        
        let growthComponent = GrowthComponent()
        addComponent(growthComponent)
        
        let scoreComponent = ScoreComponent()
        addComponent(scoreComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GKEntity {
    
    // we are using SpriteKit's physics for collision detection instead of rolling our own in a system [ay]
    func setUpPhysicsBody(node: SKSpriteNode,
                          categories: PhysicsCategories,
                          contactTestCategories: PhysicsCategories,
                          padding: CGFloat = 0.0) {
        let size = CGSize(width: node.size.width - padding, height: node.size.height - padding)
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody.categoryBitMask = categories.rawValue
        physicsBody.contactTestBitMask = contactTestCategories.rawValue
        physicsBody.collisionBitMask = 0 // Set to 0 if you don't want physics collisions
        node.physicsBody = physicsBody
        node.entity = self
    }
    
}
