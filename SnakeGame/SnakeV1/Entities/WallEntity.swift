import Foundation
import GameplayKit

class WallEntity: GKEntity {

    init(sceneSize: CGSize) {
        super.init()

        let nodes: [SKSpriteNode] = {
            // let size = CGSize(width: 20, height: 20)
            let hSize = CGSize(width: sceneSize.width, height: 20)
            let vSize = CGSize(width: 20, height: sceneSize.height)
            let color = UIColor.gray
            
            let topWall = SKSpriteNode(color: color, size: hSize)
            topWall.position = CGPoint(x: sceneSize.width / 2.0, y: sceneSize.height - hSize.height / 2.0)
            
            let bottomWall = SKSpriteNode(color: color, size: hSize)
            bottomWall.position = CGPoint(x: sceneSize.width / 2.0, y: hSize.height / 2.0)
            
            let leftWall = SKSpriteNode(color: color, size: vSize)
            leftWall.position = CGPoint(x: vSize.width / 2.0, y: sceneSize.height / 2.0)
            
            let rightWall = SKSpriteNode(color: color, size: vSize)
            rightWall.position = CGPoint(x: sceneSize.width - vSize.width / 2.0, y: sceneSize.height / 2.0)
            return [topWall, bottomWall, leftWall, rightWall]
        }()
        
        let renderComponent = RenderComponent(nodes: nodes)
        addComponent(renderComponent)
        
        let collisionComponent = CollisionComponent(categories: [.wall], contactTestCategories: [.snakeHead])
        addComponent(collisionComponent)
        
        for node in nodes {
            setUpPhysicsBody(node: node, categories: collisionComponent.categories, contactTestCategories: collisionComponent.contactTestCategories)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
