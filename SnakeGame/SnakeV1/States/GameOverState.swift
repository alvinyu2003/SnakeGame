import GameplayKit

class GameOverState: GKState {

    weak var scene: GameScene?

    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        guard let scene = scene else { return }
        // Trigger game over screen or reset game
        // Pause gameplay
        // scene.isPaused = true // don't really need this right now [ay]
        
        let label = SKLabelNode(text: "Game Over")
        label.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        scene.addChild(label)
        
        // add score label
        let scoreLabel = SKLabelNode(text: "Score: \(scene.gameScore)")
        scoreLabel.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2 - 25)
        scene.addChild(scoreLabel)

        // Present options to restart
        let restartLabel = ButtonLabelNode(text: "Tap to Restart") { [weak self] in
            self?.scene?.resetGame()
            self?.scene?.stateMachine.enter(GameRunningState.self)
        }
        restartLabel.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2 - 50)
        restartLabel.name = "restart"
        scene.addChild(restartLabel)
    }
}

class ButtonLabelNode: SKLabelNode {
    var action: (() -> Void)?
    
    init(text: String, action: @escaping () -> Void) {
        self.action = action
        super.init()
        self.text = text
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        action?()
    }
}
