import UIKit
import SpriteKit
import GameplayKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
               NotificationCenter.default.addObserver(self, selector: #selector(goToGameVC), name: NSNotification.Name(rawValue: "toGameVC") as NSNotification.Name, object: nil)
        
                       NotificationCenter.default.addObserver(self, selector: #selector(goToChooseVC), name: NSNotification.Name(rawValue: "toChooseVC") as NSNotification.Name, object: nil)
        
        
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Home") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
         
            
        }
    }
    @objc func goToGameVC() {

         self.performSegue(withIdentifier: "toGameVC", sender: self)

     }
    
    @objc func goToChooseVC() {

          self.performSegue(withIdentifier: "toChooseVC", sender: self)

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
