//
//  GameScene.swift
//  Road Adventure
//
//  Created by Mert Pişmişoğlu on 26.06.2020.
//  Copyright © 2020 Mert Pişmişoğlu. All rights reserved.
//

import SpriteKit
import GameplayKit

struct Physics {
    static let car : UInt32 = 0x1 << 1
    static let coin : UInt32 = 0x1 << 4
    static let roadCar : UInt32 = 0x1 << 3
    

}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var bg = SKSpriteNode()
    var bg2 = SKSpriteNode()
    var bg3 = SKSpriteNode()
    var car = SKSpriteNode()
    var coin = SKSpriteNode()
    var originalPosition = CGPoint(x: 0, y: 0)
    var parallax = SKAction()
    var i = 0
    
   
    
  
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
       bg = SKSpriteNode(imageNamed: "road")
        bg.position = CGPoint(x: self.frame.width/2, y:0)
       bg.zPosition = 3
        bg.size = CGSize(width: self.frame.width, height: self.frame.height*1.1)

        
        
       bg2 = SKSpriteNode(imageNamed: "road")
        bg2.position = CGPoint(x: self.frame.size.width/2, y:self.frame.height)
       bg2.zPosition = 3
        bg2.size = CGSize(width: self.frame.size.width, height: self.frame.height*1.1)
        
        
       bg3 = SKSpriteNode(imageNamed: "road")
        bg3.position = CGPoint(x: self.frame.size.width/2, y:self.frame.height + bg2.position.y)
       bg3.zPosition = 3
        bg3.size = CGSize(width: self.frame.size.width, height: self.frame.height*1.1)

       self.addChild(bg)
       self.addChild(bg2)
       self.addChild(bg3)
        parallax = SKAction.repeatForever(SKAction.move(by: CGVector(dx:0, dy: -self.frame.size.height - 50), duration: 2))

        bg.run(parallax)
        bg2.run(parallax)
        bg3.run(parallax)
        
        car = SKSpriteNode(imageNamed: "blue")
        car.position = CGPoint(x: self.frame.width/2, y: self.frame.height/7 )
        car.zPosition = 5
        car.size = CGSize(width: 125, height: 300)
        let carTex = SKTexture(imageNamed: "car")
        car.physicsBody = SKPhysicsBody(texture: carTex, size: car.size)
        car.physicsBody?.isDynamic = true
        car.physicsBody?.affectedByGravity = false
        
        car.physicsBody?.categoryBitMask = Physics.car
        car.physicsBody?.collisionBitMask =  Physics.roadCar
        car.physicsBody?.contactTestBitMask = Physics.coin | Physics.roadCar
        addChild(car)
        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(spawn), userInfo: nil, repeats: true)
        
        
        
    }
    
    @objc func spawn() {
        let dispatchQueue = DispatchQueue.init(label: "queue", attributes: .concurrent)
        dispatchQueue.async {
            self.coin = SKSpriteNode(imageNamed: "coin")
        let coinTex = SKTexture(imageNamed: "coin")
            self.coin.zPosition = 5
            self.coin.size = CGSize(width: 75, height: 75)
            
              let randomPosition = CGFloat.random(in: 50 ... 700)
            self.coin.position = CGPoint(x: randomPosition, y: self.frame.height)
            self.coin.physicsBody = SKPhysicsBody(texture: coinTex, size: self.coin.size)
            self.coin.physicsBody?.affectedByGravity = false
            self.coin.physicsBody?.isDynamic = false
            self.coin.physicsBody?.categoryBitMask = Physics.coin
            self.coin.physicsBody?.collisionBitMask = 0
            self.coin.physicsBody?.contactTestBitMask = Physics.car
        
        let move = SKAction.move(by: CGVector(dx: 0, dy: -self.frame.size.height-50), duration: 2)
        let remove = SKAction.removeFromParent()
        
        let moveAndRemove = SKAction.sequence([move,remove])
       
        
            self.addChild(self.coin)
            self.coin.run(moveAndRemove)
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
        
        
    }
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchedPosition = touch?.location(in: self)
        originalPosition = touchedPosition!
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let finalTouch = touch?.location(in: self)
        
        let toLeft = SKAction.moveBy(x: -self.frame.width/3, y: 0, duration: 0.3)
         let toRight = SKAction.moveBy(x: self.frame.width/3, y: 0, duration: 0.3)
       
        
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
