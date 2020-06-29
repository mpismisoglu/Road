
import SpriteKit
import GameplayKit

struct Physics {
    static let car : UInt32 = 0x1 << 1
    static let coin : UInt32 = 0x1 << 4
    static let roadCar : UInt32 = 0x1 << 3
    

}

class GameScene: SKScene, SKPhysicsContactDelegate{
    let defaults = UserDefaults()
    var bg = SKSpriteNode()
    var bg2 = SKSpriteNode()
    var bg3 = SKSpriteNode()
    let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)

    var car = SKSpriteNode()
    var coin = SKSpriteNode()
    var roadCar = SKSpriteNode()
    var originalPosition = CGPoint(x: 0, y: 0)
    var parallax = SKAction()
    var i = 0
    var score = 0
    var highscore = 0
    var scoreLabel = SKLabelNode()
    var deadScoreLabel = SKLabelNode()
    var highscoreLabel = SKLabelNode()
    var gameStarted = false
    var died = false
    var RestartBtn = SKSpriteNode()
    var timer = Timer()
    var timer2 = Timer()
    var timer3 = Timer()
    var timer4 = Timer()
    var interval = 2.0
    var duration = Double()
    
    
    
   
    
  
    override func didMove(to view: SKView) {
       createScene()
        
    }
    
    func restartScene() {
        self.removeAllActions()
        self.removeAllChildren()
        gameStarted = false
        died = false
        i = 0
        interval = 2.0
        score = 0
        createScene()
    }
    func createScene() {
        
        self.physicsWorld.contactDelegate = self
              bg = SKSpriteNode(imageNamed: "road")
               bg.position = CGPoint(x: self.frame.width/2, y:0)
              bg.zPosition = 3
               bg.size = CGSize(width: self.frame.width, height: self.frame.height*1.1)
               bg.name = "bg"
               
               
              bg2 = SKSpriteNode(imageNamed: "road-1")
               bg2.position = CGPoint(x: self.frame.size.width/2, y:self.frame.height)
              bg2.zPosition = 3
               bg2.size = CGSize(width: self.frame.size.width, height: self.frame.height*1.1)
               bg2.name = "bg2"
               
               
              bg3 = SKSpriteNode(imageNamed: "road-2")
               bg3.position = CGPoint(x: self.frame.size.width/2, y:self.frame.height + bg2.position.y)
              bg3.zPosition = 3
               bg3.size = CGSize(width: self.frame.size.width, height: self.frame.height*1.1)
               bg3.name = "bg3"

              self.addChild(bg)
              self.addChild(bg2)
              self.addChild(bg3)
               
               
               car = SKSpriteNode(imageNamed: "blue")
               car.position = CGPoint(x: self.frame.width/2, y: self.frame.height/7 )
               car.zPosition = 5
               car.size = CGSize(width: 125, height: 250)
               let carTex = SKTexture(imageNamed: "blue")
               car.physicsBody = SKPhysicsBody(texture: carTex, size: car.size)
               car.physicsBody?.isDynamic = true
               car.physicsBody?.affectedByGravity = false
               
               car.physicsBody?.categoryBitMask = Physics.car
        car.physicsBody?.collisionBitMask =  Physics.roadCar
        car.physicsBody?.contactTestBitMask = Physics.roadCar | Physics.coin
               addChild(car)
        
        scoreLabel.text = "\(score)m"
        scoreLabel.fontSize = 92
        scoreLabel.fontName = "ChalkboardSE-Bold"
        scoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height/1.2)
        scoreLabel.zPosition = 10
        addChild(scoreLabel)
               
               
    }
    func createButton() {
        
        RestartBtn = SKSpriteNode(imageNamed: "RestartBtn")
        RestartBtn.position = CGPoint(x: self.frame.width/2, y: self.frame.height/1.4)
        RestartBtn.size = CGSize(width: 500, height: 400)
       RestartBtn.setScale(0)
        
        
        RestartBtn.zPosition = 11
        
        deadScoreLabel.text  = "Score: \(score)m"
        deadScoreLabel.fontSize = 45
        deadScoreLabel.fontName = "ChalkboardSE-Bold"
        deadScoreLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/1.4)
        deadScoreLabel.zPosition = 30
        deadScoreLabel.setScale(0)
        deadScoreLabel.fontColor = UIColor.black
        
        highscoreLabel.text = "Highscore: \(highscore)m"
       highscoreLabel.fontSize = 45
        highscoreLabel.fontName = "ChalkboardSE-Bold"
        highscoreLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/1.6)
       highscoreLabel.zPosition = 30
        highscoreLabel.setScale(0)
        highscoreLabel.fontColor = UIColor.black
        
       
        
        addChild(RestartBtn)
        addChild(deadScoreLabel)
        addChild(highscoreLabel)
        
        RestartBtn.run(SKAction.scale(to: 1.5, duration: 0.15))
        deadScoreLabel.run(SKAction.scale(to: 1.5, duration: 0.15))
        highscoreLabel.run(SKAction.scale(to: 1.5, duration: 0.15))

    }
    
    @objc func spawn() {
        dispatchQueue.async(qos: .userInitiated) {
            self.coin = SKSpriteNode(imageNamed: "coin")
        let coinTex = SKTexture(imageNamed: "coin")
            self.coin.zPosition = 4
            self.coin.size = CGSize(width: 75, height: 75)
            
              let randomPosition = CGFloat.random(in: 50 ... 700)
            self.coin.position = CGPoint(x: randomPosition, y: self.frame.height)
            self.coin.physicsBody = SKPhysicsBody(texture: coinTex, size: self.coin.size)
            self.coin.physicsBody?.affectedByGravity = false
            self.coin.physicsBody?.isDynamic = false
            self.coin.physicsBody?.categoryBitMask = Physics.coin
            self.coin.physicsBody?.collisionBitMask = 0
            self.coin.physicsBody?.contactTestBitMask = Physics.car
            self.coin.name = "coin"
            
            
        
            let move = SKAction.move(by: CGVector(dx: 0, dy: -self.frame.size.height-50), duration: 1.4)
        let remove = SKAction.removeFromParent()
        
        let moveAndRemove = SKAction.sequence([move,remove])
       
         DispatchQueue.main.async{
            self.addChild(self.coin)
            self.coin.run(moveAndRemove)
            }
        }
        
    }
    
    @objc func spawnCar() {
        
        dispatchQueue.async(qos: .userInitiated) {
            
            
            
        
            
              let randomColor = Int.random(in: 1 ... 4)
            if randomColor == 1 {
                 
                self.roadCar = SKSpriteNode(imageNamed: "roadCarBlue")
                
            }
            
            if randomColor == 2 {
                 
                self.roadCar = SKSpriteNode(imageNamed: "roadCarRed")
                
            }
            
            if randomColor == 3 {
                 
                self.roadCar = SKSpriteNode(imageNamed: "roadCarYellow")
                
            }
            if randomColor == 4 {
                 
                self.roadCar = SKSpriteNode(imageNamed: "roadCarGreen")
                
            }
            let roadCarTex = SKTexture(imageNamed: "roadCarBlue")
            self.roadCar.zPosition = 5
            self.roadCar.size = CGSize(width: 125, height: 250)
            self.roadCar.name = "roadCar"
          
            
            let randomPosition = Int.random(in: 1 ... 3)
            if randomPosition == 1 {
                
                self.roadCar.position = CGPoint(x: self.frame.width/1.20, y: self.frame.height + 150)

            }
            
            if randomPosition == 2 {
                           
                           self.roadCar.position = CGPoint(x: self.frame.width/2, y: self.frame.height + 150)

                       }
            
            if randomPosition == 3 {
                           
                self.roadCar.position = CGPoint(x: self.frame.width/5.3, y: self.frame.height + 150)

                       }
            
            
            
            
            self.roadCar.physicsBody = SKPhysicsBody(texture: roadCarTex, size: self.roadCar.size)
            self.roadCar.physicsBody?.affectedByGravity = false
            self.roadCar.physicsBody?.isDynamic = true
            self.roadCar.physicsBody?.categoryBitMask = Physics.roadCar
            self.roadCar.physicsBody?.collisionBitMask = Physics.car
            self.roadCar.physicsBody?.contactTestBitMask = Physics.car
            
            
            if self.score < 100 {
                           
                self.duration = 1.1
                       }
            
            if self.score >= 100 && self.score < 200 {
                           
                self.duration = 1.05
                       }
            if self.score >= 200 && self.score < 300 {
                
                self.duration = 1.0
            }
            
            if self.score >= 300 && self.score < 400 {
                
                self.duration = 0.95
            }
            if self.score >= 400 && self.score < 500 {
                           
                self.duration = 0.90
                       }
            if self.score >= 500 && self.score < 600 {
                
                self.duration = 0.85
            }
            
            if self.score >= 600 && self.score < 700 {
                           
                self.duration = 0.80
                       }
            if self.score >= 700 && self.score < 800 {
                
                self.duration = 0.75
            }
            if self.score >= 800 && self.score < 900 {
                           
                self.duration = 0.70
                       }
            if self.score >= 900 && self.score < 1000  {
                           
                self.duration = 0.65
                       }
            if self.score >= 1000  {
                
                self.duration = 0.60
            }
           
            
            let move = SKAction.move(by: CGVector(dx: 0, dy: -self.frame.size.height-300), duration: self.duration)
                  let remove = SKAction.removeFromParent()
                  
                  let moveAndRemove = SKAction.sequence([move,remove])
            
            DispatchQueue.main.async{
            self.addChild(self.roadCar)
            self.roadCar.run(moveAndRemove)
            }

        }
    }
    
    
      func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == Physics.car && secondBody.categoryBitMask == Physics.coin {
            
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.categoryBitMask == Physics.coin && secondBody.categoryBitMask == Physics.car {
            
            firstBody.node?.removeFromParent()

            
              }
        
        if firstBody.categoryBitMask == Physics.car && secondBody.categoryBitMask == Physics.roadCar {
            self.timer.invalidate()
            self.timer2.invalidate()
            self.timer3.invalidate()
            
            enumerateChildNodes(withName: "bg", using: ({
                                      (node, error) in
                      node.speed = 0
                          self.bg.removeAllActions()
                self.highscore = self.defaults.integer(forKey: "hs")

                if self.score > self.highscore
                {
                    self.highscore = self.score
                    
                    self.defaults.set(self.highscore, forKey: "hs")
                }
                      
                      
                      
                     }))
                      
                      enumerateChildNodes(withName: "bg2", using: ({
                                                 (node, error) in
                                 node.speed = 0
                          self.bg2.removeAllActions()
                                 
                                 
                                 
                                }))
                      
                      enumerateChildNodes(withName: "bg3", using: ({
                                                 (node, error) in
                                 node.speed = 0
                          self.bg3.removeAllActions()
                                 
                                 
                                 
                                }))
                      
                      enumerateChildNodes(withName: "roadCar", using: ({
                                                                            (node, error) in
                                                            node.speed = 0
                                                     self.roadCar.removeAllActions()
                                                            
                                                            
                                                            
                                                           }))
                               
                               enumerateChildNodes(withName: "coin", using: ({
                                                                            (node, error) in
                                                            node.speed = 0
                                                     self.coin.removeAllActions()
                                                            
                                                            
                                                            
                                                           }))

            
            
                   
                   
                   if died == false{
                         
                         
                                    died = true
                         self.removeAllActions()


                                    createButton()
                                }
           
            
      

        
          }
        
        if firstBody.categoryBitMask == Physics.roadCar && secondBody.categoryBitMask == Physics.car {
        
            self.timer.invalidate()
            self.timer2.invalidate()
            self.timer3.invalidate()
            
            enumerateChildNodes(withName: "bg", using: ({
                                      (node, error) in
                      node.speed = 0
                          self.bg.removeAllActions()
                self.highscore = self.defaults.integer(forKey: "hs")

                               if self.score > self.highscore
                               {
                                   self.highscore = self.score
                                   
                                   self.defaults.set(self.highscore, forKey: "hs")
                               }
                      
                      
                      
                     }))
                      
                      enumerateChildNodes(withName: "bg2", using: ({
                                                 (node, error) in
                                 node.speed = 0
                          self.bg2.removeAllActions()
                                 
                                 
                                 
                                }))
                      
                      enumerateChildNodes(withName: "bg3", using: ({
                                                 (node, error) in
                                 node.speed = 0
                          self.bg3.removeAllActions()
                                 
                                 
                                 
                                }))
                      
                      enumerateChildNodes(withName: "roadCar", using: ({
                                                                            (node, error) in
                                                            node.speed = 0
                                                     self.roadCar.removeAllActions()
                                                            
                                                            
                                                            
                                                           }))
                               
                               enumerateChildNodes(withName: "coin", using: ({
                                                                            (node, error) in
                                                            node.speed = 0
                                                     self.coin.removeAllActions()
                                                            
                                                            
                                                            
                                                           }))
           
            
            if died == false{
                  
                  
                             died = true
                  self.removeAllActions()


                             createButton()
                         }
        
          }
        
        
        
        
        
    }
  
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchedPosition = touch?.location(in: self)
        originalPosition = touchedPosition!
        
        if gameStarted == false {
            parallax = SKAction.repeatForever(SKAction.move(by: CGVector(dx:0, dy: -self.frame.size.height - 50), duration:1.4))

            bg.run(parallax)
                         bg2.run(parallax)
                         bg3.run(parallax)
      
            timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(spawn), userInfo: nil, repeats: true)
            timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(spawnCar), userInfo: nil, repeats: true)
            timer3 = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(Score), userInfo: nil, repeats: true)
            
          

            gameStarted = true
        }
        
        if died == true {
            
            restartScene()
        }
        
    }
    
    
    @objc func Score() {
        
        score += 1
        scoreLabel.text = "\(score)m"
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let finalTouch = touch?.location(in: self)
        
        let toLeft = SKAction.moveBy(x: -self.frame.width/3, y: 0, duration: 0.2)
         let toRight = SKAction.moveBy(x: self.frame.width/3, y: 0, duration: 0.2)
       
        
        if originalPosition.x - finalTouch!.x > 0 {
            if i != -1 {
            car.run(toLeft)
            i -= 1
            }
        }
           
        
        
        if originalPosition.x - finalTouch!.x < 0
        {
            if i != 1 {
           
            
                car.run(toRight)
                i += 1
            }
        }
    
    
    }
    
   
    
    
    override func update(_ currentTime: TimeInterval) {
        
        parallax.duration = interval
        
        if bg.position.y <= -self.frame.size.height {
               bg.position.y = self.frame.size.height * 2
               
           }
        if bg2.position.y <= -self.frame.size.height {
               bg2.position.y = self.frame.size.height * 2
              
           }
        if bg3.position.y <= -self.frame.size.height {
               bg3.position.y = self.frame.size.height * 2
            
           }
       
    }
}
