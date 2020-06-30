import SpriteKit
import GameplayKit


class Choose: SKScene, SKPhysicsContactDelegate{
    let defaults = UserDefaults()
    var red = SKSpriteNode()
    var yellow = SKSpriteNode()
    var green = SKSpriteNode()
    var blue = SKSpriteNode()
    var bg = SKSpriteNode()
    var carString = String()
    var carUse = SKSpriteNode()
    var yes = SKSpriteNode()
    var no = SKSpriteNode()
    var alertShowed = false
    var i = 0


    
    
    override func didMove(to view: SKView) {
        defaults.set("yellow", forKey: "carString")
       
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
    
    func showAlert() {
        
        carUse = SKSpriteNode(imageNamed: "carUse")
        carUse.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        carUse.size = CGSize(width: 500, height: 400)
        carUse.setScale(0)
        carUse.zPosition = 30
        
        yes = SKSpriteNode(imageNamed: "yes")
        yes.position = CGPoint(x: carUse.frame.width/2 + 150 , y: carUse.frame.height/2 - 60)
        yes.size = CGSize(width: 100, height: 50)
        yes.setScale(0)
        yes.zPosition = 32
        
        no = SKSpriteNode(imageNamed: "no")
        no.position = CGPoint(x: carUse.frame.width/2 - 150  , y: carUse.frame.height/2 - 60)
        no.size = CGSize(width: 100, height: 50)
        no.setScale(0)
        no.zPosition = 32
        
        
        addChild(carUse)
        carUse.addChild(no)
        carUse.addChild(yes)
        
        carUse.run(SKAction.scale(to: 1.5, duration: 0.3))
        yes.run(SKAction.scale(to: 1.5, duration: 0.3))
        no.run(SKAction.scale(to: 1.5, duration: 0.3))
        
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
                                
                                if alertShowed == false {
                                  if sprite == red
                                  {
                                    
                                    showAlert()
                                    
                                    i = 1
                                    alertShowed = true
                                  }
                               
                                if sprite == blue
                                {
                                    showAlert()
                                   
alertShowed = true
                                  
                                    i = 2
                                }
                                if sprite == yellow
                                {
                                 showAlert()
                                    
alertShowed = true
                                    i = 3
                                }
                                if sprite == green
                                {
                                showAlert()
                                   alertShowed = true

                                    i = 4
                                }
                                }
                                
                              
                          }
                      }
                    }
                  }
        
        
        
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
                            let touchNodes = nodes(at: touchLocation)
                            
                            if touchNodes.isEmpty == false
                            {
                                for node in touchNodes
                                {
                                    if let sprite = node as? SKSpriteNode
                                    {
                                        
                                   
                                            
                                        if sprite == yes {
                                            
                                            if i == 1 {
                                                defaults.set("red", forKey: "carString")
                                            }
                                            if i == 2 {
                                                defaults.set("blue", forKey: "carString")
                                            }
                                            if i == 3 {
                                                defaults.set("yellow", forKey: "carString")
                                            }
                                            if i == 4 {
                                                defaults.set("green", forKey: "carString")
                                            }
                                            
                                            carUse.run(SKAction.scale(to: 0, duration: 0.3))
                                                   yes.run(SKAction.scale(to: 0, duration: 0.3))
                                                   no.run(SKAction.scale(to: 0, duration: 0.3))
                                            
                                            
                                            
                                        }
                                        if sprite == no {
                                            carUse.run(SKAction.scale(to: 0, duration: 0.3))
                                            yes.run(SKAction.scale(to: 0, duration: 0.3))
                                            no.run(SKAction.scale(to: 0, duration: 0.3))
                                            
                                        }
                                            
                                        
                                        
                                      
                                        
                                    }
                                    
                                }
                                
                            
                            
        }
                                        
                                        
        
        
    }
    
    
    
}
