//
//  GameScene.swift
//  scene
//
//  Created by Yongyang Nie on 3/21/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import SpriteKit
import GameplayKit

class MapScene: SKScene {
    
    override func didMove(to view: SKView) {
    
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func sceneDidLoad() {
        
        let sn = SKSpriteNode.init(imageNamed: "map.png")
        sn.position = CGPoint.init(x: self.frame.midX, y: self.frame.midY)
        self.addChild(sn)
        
        self.backgroundColor = UIColor.white
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
