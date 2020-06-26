//
//  GameScene.swift
//  Road Adventure
//
//  Created by Mert Pişmişoğlu on 26.06.2020.
//  Copyright © 2020 Mert Pişmişoğlu. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var bg = SKSpriteNode()
    var bg2 = SKSpriteNode()
    var bg3 = SKSpriteNode()

    var parallax = SKAction()
    
   
    
  
    override func didMove(to view: SKView) {
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
        
        
    }
    
    
    
   
   
   
    
    
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
               
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
