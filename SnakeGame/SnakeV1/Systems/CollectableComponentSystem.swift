import GameplayKit
import SpriteKit

// defining this protocol to be able to store heterogenous GKComponentSystem types in a collection [ay]
protocol CollectableComponentSystem {
    var componentClass: AnyClass { get }
    init(componentClass cls: AnyClass)
    func addComponent(foundIn entity: GKEntity)
    func removeComponent(foundIn entity: GKEntity)
    func update(deltaTime seconds: TimeInterval)
    func classForGenericArgument(at index: Int) -> AnyClass
}

extension GKComponentSystem: CollectableComponentSystem { }