
import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
class GameViewController: UIViewController, GADInterstitialDelegate {
    var interstitial: GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
           interstitial.load(request)
         interstitial = createAndLoadInterstitial()
        NotificationCenter.default.addObserver(self, selector: #selector(goToDifferentView), name: NSNotification.Name(rawValue: "toMainMenu") as NSNotification.Name, object: nil)
        
                NotificationCenter.default.addObserver(self, selector: #selector(showAd), name: NSNotification.Name(rawValue: "showAd") as NSNotification.Name, object: nil)

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
         
            
        }
    }
    func createAndLoadInterstitial() -> GADInterstitial {
      var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
      interstitial.delegate = self
      interstitial.load(GADRequest())
      return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      interstitial = createAndLoadInterstitial()
    }
    
    
    @objc func showAd() {
        if interstitial.isReady {
          interstitial.present(fromRootViewController: self)
        }
        
    }
    
    @objc func goToDifferentView() {

        self.performSegue(withIdentifier: "toMainMenu", sender: self)

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
    
    @objc func perform() {
        
        performSegue(withIdentifier: "toMainMenu", sender: self)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
