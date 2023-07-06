import Foundation
import GameplayKit

class AppleEntity: GKEntity {
   
    init(position: CGPoint) {
        super.init()
       
        let node = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 20))
        node.position = position
        
        let renderComponent = RenderComponent(nodes: [node])
        addComponent(renderComponent)
       
        let collisionComponent = CollisionComponent(categories: [.apple], contactTestCategories: [.snakeHead])
        addComponent(collisionComponent)
        
        setUpPhysicsBody(node: node, categories: collisionComponent.categories, contactTestCategories: collisionComponent.contactTestCategories)
       
       let respawnComponent = RespawnComponent()
        addComponent(respawnComponent)
        
       let pointsComponent = PointsComponent(points: 1)
       addComponent(pointsComponent)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
