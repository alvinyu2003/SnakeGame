import GameplayKit
import SpriteKit

class MovementSystem: GKComponentSystem<MovementComponent> {

    let moveInterval: TimeInterval = 0.2
    var accumulatedTime: TimeInterval = 0

    override init() {
        super.init(componentClass: MovementComponent.self)
    }

    override func update(deltaTime seconds: TimeInterval) {
        // Accumulate the elapsed time
        accumulatedTime += seconds // this should happen per component [ay]
        
        // Only move the snake if enough time has passed
        if accumulatedTime >= moveInterval {
            updateSnakePosition()
            accumulatedTime -= moveInterval
        }
    }
    
    func updateSnakePosition() {
        for component in components {
            guard let entity = component.entity,
                  let renderComponent = entity.component(ofType: RenderComponent.self),
                  let input = entity.component(ofType: InputComponent.self) else {
                continue
            }
            
            // Loop over all segments of the snake in reverse order
            for i in (0..<renderComponent.nodes.count).reversed() {
                // Each segment takes the position of the one ahead
                if i != 0 {
                    let previousSegment = renderComponent.nodes[i - 1]
                    let currentSegment = renderComponent.nodes[i]
                    move(node: currentSegment, to: previousSegment.position)
                }
            }
            
            component.direction = input.direction
            
            // Move the head based on the direction
            if let head = renderComponent.nodes.first {
                let headSize = head.frame.size
                let dx = headSize.width * component.direction.dx
                let dy = headSize.height * component.direction.dy
                let position = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
                move(node: head, to: position)
            }
        }
    }
    
    func move(node: SKNode, to position: CGPoint, animated: Bool = false) {
        // FIXME: animation is causing collisions, also kind of jumpy [ay]
        if animated {
            node.removeAction(forKey: "move")
            let move = SKAction.move(to: position, duration: moveInterval)
            node.run(move, withKey: "move")
        } else {
            node.position = position
        }
    }

}
