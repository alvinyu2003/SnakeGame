import SpriteKit
import GameplayKit

final class GameScene: SKScene {
    
    private var lastUpdateTimeInterval = CACurrentMediaTime()

    lazy var entityManager = { EntityManager(scene: self) }()

    private(set) var componentSystems: [CollectableComponentSystem] = []
    
    lazy var stateMachine: GKStateMachine = {
        let runningState = GameRunningState(scene: self)
        let gameOverState = GameOverState(scene: self)
        return GKStateMachine(states: [runningState, gameOverState])
    }()

    override func didMove(to view: SKView) {
        backgroundColor = .black
        physicsWorld.gravity = CGVector(dx: 0, dy: 0) // disable gravity [ay]
        resetGame()
        stateMachine.enter(GameRunningState.self)
    }

    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        stateMachine.update(deltaTime: deltaTime)
    }
    
    func resetGame() {
        // Clear the scene
        removeAllChildren()
        removeAllActions()
       
        entityManager.clearEntities()
        entityManager.setUpEntities()

        clearComponentSystems()
        setUpComponentSystems()
    }
    
    func transitionToGameOver() {
        stateMachine.enter(GameOverState.self)
    }
    
    func clearComponentSystems() {
        for entity in entityManager.entities {
            for system in componentSystems {
                system.removeComponent(foundIn: entity)
            }
        }
    }
    
    func setUpComponentSystems() {
        componentSystems = [InputSystem(scene: self),
                            MovementSystem(),
                            CollisionSystem(scene: self),
                            RespawnSystem(scene: self),
                            GrowthSystem(scene: self)]
        
        for entity in entityManager.entities {
            for system in componentSystems {
                system.addComponent(foundIn: entity)
            }
        }
    }
    
}

extension GameScene {
    
    var gameScore: Int {
        // get snake score of the snake entity's score component
        guard let snake = entityManager.entities.first(where: { $0 is SnakeEntity }) as? SnakeEntity,
              let scoreComponent = snake.component(ofType: ScoreComponent.self) else {
                return 0
        }
        return scoreComponent.score
    }
    
}
