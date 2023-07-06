import GameplayKit
import SpriteKit

// only spawns apples at the moment
class RespawnSystem: GKComponentSystem<RespawnComponent> {
    
    weak var scene: GameScene?
    
    init(scene: GameScene) {
        self.scene = scene
        super.init(componentClass: RespawnComponent.self)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            guard component.needsRespawn,
                  let entity = component.entity,
                  let renderComponent = entity.component(ofType: RenderComponent.self),
                  let node = renderComponent.nodes.first else {
                    continue
            }
            let randomPoint = getRandomPointInScene()
            if canRespawnNode(atPoint: randomPoint, nodeSize: node.frame.size) {
                node.position = randomPoint
                component.needsRespawn = false
            } else {
                print("did NOT respawn because of intersection")
            }
        }
    }

    func canRespawnNode(atPoint point: CGPoint, nodeSize: CGSize) -> Bool {
        guard let scene = scene else { return false }
        let tempNode = SKSpriteNode(color: .clear, size: nodeSize)
        scene.addChild(tempNode)
        let sceneNodes = scene.children // all nodes in the scene
        // Move the new node to the spawn point
        tempNode.position = point
        for node in sceneNodes where node !== tempNode {
            if tempNode.intersects(node) {
                tempNode.removeFromParent()
                return false // can't spawn, there is an intersection
            }
        }
        tempNode.removeFromParent()
        return true // can spawn, no intersections found
    }

    func getRandomPointInScene() -> CGPoint {
        guard let scene = scene else { return CGPoint.zero }
        let point = CGPoint(x: CGFloat.random(in: 0...scene.size.width),
                            y: CGFloat.random(in: 0...scene.size.height))
        return pointToGridPoint(point: point)
    }

    // Converts a point to its corresponding grid point
        func pointToGridPoint(point: CGPoint) -> CGPoint {
            let gridSize = CGSize(width: 20, height: 20.0) // get this from component [ay]
            let x = round(point.x / gridSize.width) * gridSize.width
            let y = round(point.y / gridSize.height) * gridSize.height
            return CGPoint(x: x, y: y)
        }
}
