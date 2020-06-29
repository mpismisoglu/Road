import SpriteKit
import GameplayKit


class Choose: SKScene, SKPhysicsContactDelegate{
    
    var red = SKSpriteNode()
    var yellow = SKSpriteNode()
    var green = SKSpriteNode()
    var blue = SKSpriteNode()


    
    
    override func didMove(to view: SKView) {
        
        green = SKSpriteNode(imageNamed: "green")
        green.position = CGPoint(x: self.frame.width/1.3, y: self.frame.height/1.5)
        green.size = CGSize(width: 190, height: 380)
        green.zPosition = 1
        addChild(green)
        
        yellow = SKSpriteNode(imageNamed: "yellow")
        yellow.position = CGPoint(x: self.frame.width/4, y: self.frame.height/1.5)
        yellow.size = CGSize(width: 190, height: 380)
        yellow.zPosition = 1
        addChild(yellow)
        
        blue = SKSpriteNode(imageNamed: "blue")
        blue.position = CGPoint(x: self.frame.width/4, y: self.frame.height/3.7)
        blue.size = CGSize(width: 190, height: 380)
        blue.zPosition = 1
        addChild(blue)
        
        red = SKSpriteNode(imageNamed: "red")
        red.position = CGPoint(x: self.frame.width/1.3, y: self.frame.height/3.7)
        red.size = CGSize(width: 190, height: 380)
        red.zPosition = 1
        addChild(red)
    }
    
    
    
}
