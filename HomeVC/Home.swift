import SpriteKit
import GameplayKit

class Home: SKScene, SKPhysicsContactDelegate{

    var play = SKSpriteNode()
    var shop = SKSpriteNode()
    override func didMove(to view: SKView) {
        play = SKSpriteNode(imageNamed: "PlayBut")
        play.position = CGPoint(x: self.frame.width - 200, y: self.frame.height/2.25)
        play.size = CGSize(width: 400, height: 250)
        play.zPosition = 5
        
        shop = SKSpriteNode(imageNamed: "ShopBut")
        shop.position = CGPoint(x: 200, y: self.frame.height/3.75)
        shop.size = CGSize(width: 400, height: 250)
        shop.zPosition = 5
        
        addChild(play)
        addChild(shop)
        
        
       
     
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first
        {
            let touchLocation = touch.location(in: self)
            let touchNodes = nodes(at: touchLocation)
            
            if touchNodes.isEmpty == false
            {
                for node in touchNodes
                {
                    if let sprite = node as? SKSpriteNode
                    {
                        if sprite == play {
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toGameVC") as NSNotification.Name, object: nil)

                        }
                        if sprite == shop {
                             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toChooseVC") as NSNotification.Name, object: nil)
                            
                        }
                    }
                }
            }
        }
        
    }
    
}
