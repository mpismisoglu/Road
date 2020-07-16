
import UIKit
import SpriteKit
import GameplayKit

class ChooseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
              NotificationCenter.default.addObserver(self, selector: #selector(toHomeVC), name: NSNotification.Name(rawValue: "toHomeVC") as NSNotification.Name, object: nil)
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Choose") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
         
            
        }
    }
    
    @objc func toHomeVC() {

           self.performSegue(withIdentifier: "toHomeVC", sender: self)

       }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
