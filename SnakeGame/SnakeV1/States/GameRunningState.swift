import GameplayKit

class GameRunningState: GKState {

    weak var scene: GameScene?
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }

    override func update(deltaTime seconds: TimeInterval) {
        guard let scene = scene else { return }
        for system in scene.componentSystems {
            system.update(deltaTime: seconds)
        }
    }
}