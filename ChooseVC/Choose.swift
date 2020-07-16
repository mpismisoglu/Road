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
    var redOwned = false
    var blueOwned = false
    var yellowOwned = true
    var greenOwned = false
    var carOwned = false
    var buy = SKSpriteNode()
    var buy2 = SKSpriteNode()
    var buyLabel = SKLabelNode()
    var buyLabel2 = SKLabelNode()
    var notEnough = SKLabelNode()
    var okay = SKSpriteNode()
    var currentCoin = 0
    var buyAlertOnScreen = false
    var coinICon = SKSpriteNode()
    var coinNumber = SKLabelNode()
    var back = SKSpriteNode()
    

    
    
    override func didMove(to view: SKView) {
        
        back = SKSpriteNode(imageNamed: "BackBut")
        back.position = CGPoint(x: 125, y: self.frame.height - 100)
        back.size = CGSize(width: 250, height: 200)
        back.zPosition = 12
        
        addChild(back)
        
        coinICon = SKSpriteNode(imageNamed: "coin")
                 coinICon.position = CGPoint(x: self.frame.width - 200, y: self.frame.height - 100)
           coinICon.size = CGSize(width: 85, height: 85)
           coinICon.zPosition = 10
           addChild(coinICon)
           
          
           coinNumber.fontSize = 82
           
           
           coinNumber.fontName = "ChalkboardSE-Bold"
           coinNumber.fontColor = UIColor.systemYellow
           coinNumber.zPosition = 10
        let coinNum = defaults.integer(forKey: "coin")
        
        if coinNum >= 999 {
              coinNumber.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 125)
            coinNumber.fontSize = 65

          }
          if coinNum < 10 {
              coinNumber.position = CGPoint(x: self.frame.width - 130, y: self.frame.height - 125)

                 }
          if coinNum >= 10 && coinNum < 100 {
            coinNumber.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 125)

                 }
          if coinNum >= 100 && coinNum < 999 {
              coinNumber.position = CGPoint(x: self.frame.width - 70, y: self.frame.height - 125)

          }
        
          
        
           coinNumber.text = "\(coinNum)"
           addChild(coinNumber)
       
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
    func moneyAlert() {
     buy2 = SKSpriteNode(imageNamed: "buy")
            buy2.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
             buy2.size = CGSize(width: 500, height: 400)
             buy2.setScale(0)
             buy2.zPosition = 30
        
        notEnough = SKLabelNode()
        notEnough.fontName = "ChalkboardSE-Bold"
        notEnough.text = "You don't have enough coins"
        notEnough.fontSize = 22
        notEnough.zPosition = 32
        notEnough.setScale(0)
        notEnough.position = CGPoint(x: buy2.frame.width/2, y: buy2.frame.height/2 + 100)
        
 okay = SKSpriteNode(imageNamed: "okay")
  okay.position = CGPoint(x: buy2.frame.width/2, y: buy2.frame.height/2 - 100)
  okay.size = CGSize(width: 100, height: 50)
  okay.setScale(0)
  okay.zPosition = 32
       
        
        addChild(buy2)
        buy2.addChild(notEnough)
        buy2.addChild(okay)
        
        buy2.run(SKAction.scale(to: 1.5, duration: 0.3))
        okay.run(SKAction.scale(to: 1.5, duration: 0.3))
        notEnough.run(SKAction.scale(to: 1.5, duration: 0.3))


    }
    func buyAlert() {
        
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
        
        buy = SKSpriteNode(imageNamed: "buy")
        buy.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
         buy.size = CGSize(width: 500, height: 400)
         buy.setScale(0)
         buy.zPosition = 30
        
        buyLabel = SKLabelNode()
        buyLabel.text = "Do you want to buy this"
        buyLabel.fontName = "ChalkboardSE-Bold"
        buyLabel.fontSize = 25
        buyLabel.zPosition = 30
        buyLabel.setScale(0)
        buyLabel.position = CGPoint(x: buy.frame.width/2, y: buy.frame.height/2 + 120)
        
        buyLabel2 = SKLabelNode()
        buyLabel2.text = "car for 200 coins?"
        buyLabel2.fontName = "ChalkboardSE-Bold"
        buyLabel2.fontSize = 25
        buyLabel2.zPosition = 30
        buyLabel2.setScale(0)
        buyLabel2.position = CGPoint(x: buy.frame.width/2, y: buy.frame.height/2 + 60)
        
        
        addChild(buy)
        buy.addChild(buyLabel2)
                 buy.addChild(no)
                 buy.addChild(yes)
                 buy.addChild(buyLabel)
                 buy.run(SKAction.scale(to: 1.5, duration: 0.3))

                        yes.run(SKAction.scale(to: 1.5, duration: 0.3))
                        no.run(SKAction.scale(to: 1.5, duration: 0.3))
                 buyLabel.run(SKAction.scale(to: 1.5, duration: 0.3))
        buyLabel2.run(SKAction.scale(to: 1.5, duration: 0.3))
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        redOwned = defaults.bool(forKey: "redOwned")
        blueOwned = defaults.bool(forKey: "blueOwned")
        yellowOwned = defaults.bool(forKey: "yellowOwned")
        greenOwned = defaults.bool(forKey: "greenOwned")
        
        currentCoin = defaults.integer(forKey: "coin")
        
        
        

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
                                    if sprite == back {
                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toHomeVC") as NSNotification.Name, object: nil)
                                        
                                    }
                                  if sprite == red
                                  {
                                    if redOwned == false {
                                        
                                       buyAlert()
                                         buyAlertOnScreen = true
                                    }
                                    
                                    if redOwned == true {
                                            showAlert()
                                        
                                    }
                                
                                    
                                    i = 1
                                    alertShowed = true
                                  }
                               
                                if sprite == blue
                                {
                                    if blueOwned == false {
                                         
                                         buyAlert()
                                         buyAlertOnScreen = true
                                     }
                                     
                                     if blueOwned == true {
                                             showAlert()
                                         
                                     }
                                   
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
                                if greenOwned == false {
                                     
                                     buyAlert()
                                    buyAlertOnScreen = true
                                 }
                                 
                                 if greenOwned == true {
                                         showAlert()
                                     
                                 }
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
                                                if buyAlertOnScreen == true {
                                                if currentCoin < 200 {
                                                moneyAlert()
                                                                                      
                                                }
                                                                                      
                                                if currentCoin >= 200 {
                                                    currentCoin -= 200
                                                    let coinNum = defaults.integer(forKey: "coin")

                                                       coinNumber.text = "\(coinNum)"

                                                    defaults.set(currentCoin, forKey: "coin")
                                                    defaults.set("red", forKey: "carString")
                                                    defaults.set(true, forKey: "redOwned")
                                                    
                                                }
                                                }
                                                
                                                else {
                                                    defaults.set("red", forKey: "carString")
                                                    defaults.set(true, forKey: "redOwned")
                                                }
                                                
                                                
                                               
                                            }
                                            if i == 2 {
                                                
                                           if buyAlertOnScreen == true {
                                           if currentCoin < 200 {
                                           moneyAlert()
                                                                                 
                                           }
                                                                                 
                                           if currentCoin >= 200 {
                                               currentCoin -= 200
                                               let coinNum = defaults.integer(forKey: "coin")

                                                  coinNumber.text = "\(coinNum)"

                                               defaults.set(currentCoin, forKey: "coin")
                                               defaults.set("blue", forKey: "carString")
                                               defaults.set(true, forKey: "blueOwned")
                                               
                                           }
                                           }
                                           
                                           else {
                                               defaults.set("blue", forKey: "carString")
                                               defaults.set(true, forKey: "blueOwned")
                                           }
                                               

                                            }
                                            if i == 3 {
                                                
                                               
                                               
                                               
                                                   defaults.set("yellow", forKey: "carString")
                                                   defaults.set(true, forKey: "yellowOwned")
                                               

                                            }
                                           
                                            if i == 4 {
                                                
                                               if buyAlertOnScreen == true {
                                               if currentCoin < 200 {
                                               moneyAlert()
                                                                                     
                                               }
                                                                                     
                                               if currentCoin >= 200 {
                                                   currentCoin -= 200
                                                   let coinNum = defaults.integer(forKey: "coin")

                                                      coinNumber.text = "\(coinNum)"

                                                   defaults.set(currentCoin, forKey: "coin")
                                                   defaults.set("green", forKey: "carString")
                                                   defaults.set(true, forKey: "greenOwned")
                                                   
                                               }
                                               }
                                               
                                               else {
                                                   defaults.set("green", forKey: "carString")
                                                   defaults.set(true, forKey: "greenOwned")
                                               }
                                                

                                            }
                                            
                                            carUse.run(SKAction.scale(to: 0, duration: 0.3))
                                                   yes.run(SKAction.scale(to: 0, duration: 0.3))
                                                   no.run(SKAction.scale(to: 0, duration: 0.3))
                                            buyLabel.run(SKAction.scale(to: 0, duration: 0.3))
                                            buyLabel2.run(SKAction.scale(to: 0, duration: 0.3))

                                            buy.run(SKAction.scale(to: 0, duration: 0.3))
                                            


                                            
                                            alertShowed = false
                                             buyAlertOnScreen = false
                                            
                                            
                                            
                                        }
                                        if sprite == no {
                                            carUse.run(SKAction.scale(to: 0, duration: 0.3))
                                            yes.run(SKAction.scale(to: 0, duration: 0.3))
                                            no.run(SKAction.scale(to: 0, duration: 0.3))
                                            buyLabel.run(SKAction.scale(to: 0, duration: 0.3))
                                            buy.run(SKAction.scale(to: 0, duration: 0.3))
                                            buyLabel2.run(SKAction.scale(to: 0, duration: 0.3))
                                             buyAlertOnScreen = false



                                            
                                            alertShowed = false

                                            
                                        }
                                        
                                         if sprite == okay {
                                            
                                            buy2.run(SKAction.scale(to: 0, duration: 0.3))
                                            okay.run(SKAction.scale(to: 0, duration: 0.3))
                                            notEnough.run(SKAction.scale(to: 0, duration: 0.3))
                                            
                                            alertShowed = false
                                             buyAlertOnScreen = false
                                            
                                        }
                                            
                                        
                                        
                                      
                                        
                                    }
                                    
                                   
                                    
                                }
                                
                            
                            
        }
        
                                        
        
        
    }
    
    
    
}
