import GameplayKit

class InputSystem: GKComponentSystem<InputComponent> {
    weak var scene: GameScene?
    
    init(scene: GameScene) {
        self.scene = scene
        super.init(componentClass: InputComponent.self)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRight.direction = .right
        scene.view?.addGestureRecognizer(swipeRight)
        
        // Add other gesture recognizers
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeft.direction = .left
        scene.view?.addGestureRecognizer(swipeLeft)

        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeUp.direction = .up
        scene.view?.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        swipeDown.direction = .down
        scene.view?.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipedRight(_ sender: UISwipeGestureRecognizer) {
        for component in components {
            component.direction = CGVector(dx: 1, dy: 0)
        }
    }
    
    // Handle other gestures
    @objc func swipedLeft(_ sender: UISwipeGestureRecognizer) {
        for component in components {
            component.direction = CGVector(dx: -1, dy: 0)
        }
    }

    @objc func swipedUp(_ sender: UISwipeGestureRecognizer) {
        for component in components {
            component.direction = CGVector(dx: 0, dy: 1)
        }
    }

    @objc func swipedDown(_ sender: UISwipeGestureRecognizer) {
        for component in components {
            component.direction = CGVector(dx: 0, dy: -1)
        }
    }
}
