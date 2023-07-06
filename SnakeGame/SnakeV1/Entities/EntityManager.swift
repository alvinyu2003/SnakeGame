import Foundation
import GameplayKit

final class EntityManager {
    
    var entities: [GKEntity] = []
    unowned var scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    func clearEntities() {
        entities.removeAll()
    }
    
    func setUpEntities() {
        // Create entities
        let midPoint = CGPoint(x: scene.size.width * 0.5,
                               y: scene.size.height * 0.5)
        let snakeEntity = SnakeEntity(position: midPoint)
        entities.append(snakeEntity)
        
        let wallEntity = WallEntity(sceneSize: scene.size)
        entities.append(wallEntity)
        
        let randomPosition = CGPoint(x: CGFloat.random(in: 0...scene.size.width),
                                     y: CGFloat.random(in: 0...scene.size.height))
        let appleEntity = AppleEntity(position: randomPosition)
        entities.append(appleEntity)
        
        // Add entities to scene
        for entity in entities {
            if let renderComponent = entity.component(ofType: RenderComponent.self) {
                for node in renderComponent.nodes {
                    scene.addChild(node)
                }
            }
        }
    }
}


// possibly add more set up code here [ay]
extension EntityManager {

    //

}
