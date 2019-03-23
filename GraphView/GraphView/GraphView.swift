//
//  GraphSceneView.swift
//  GraphView
//
//  Created by Yongyang Nie on 3/23/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit
import SpriteKit

class GraphView: UIView {
    
    var graphScene : SKScene!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.graphScene = SKScene.init(fileNamed: "GraphViewScene.sks")
        self.graphScene.backgroundColor = UIColor.init(red: 245.0 / 255, green: 245.0 / 255, blue: 245.0 / 255, alpha: 1.0)
    }
    
    public func drawGraph() {
        
        let circleNode1 = SKShapeNode.init(circleOfRadius: 10)
        circleNode1.fillColor = UIColor.clear
        circleNode1.lineWidth = 3.0
        circleNode1.strokeColor = UIColor.black
        circleNode1.position = CGPoint.init(x: 20, y: 20)
        self.graphScene.addChild(circleNode1)
        
        let circleNode2 = SKShapeNode.init(circleOfRadius: 10)
        circleNode2.fillColor = UIColor.clear
        circleNode2.lineWidth = 3.0
        circleNode2.strokeColor = UIColor.black
        circleNode2.position = CGPoint.init(x: 20, y: 20)
        self.graphScene.addChild(circleNode2)
        
        let circleNode3 = SKShapeNode.init(circleOfRadius: 10)
        circleNode3.fillColor = UIColor.clear
        circleNode3.lineWidth = 3.0
        circleNode3.strokeColor = UIColor.black
        circleNode3.position = CGPoint.init(x: 20, y: 20)
        self.graphScene.addChild(circleNode3)
        
        let circleNode4 = SKShapeNode.init(circleOfRadius: 10)
        circleNode4.fillColor = UIColor.clear
        circleNode4.lineWidth = 3.0
        circleNode4.strokeColor = UIColor.black
        circleNode4.position = CGPoint.init(x: 20, y: 20)
        self.graphScene.addChild(circleNode4)
        
        let circleNode1 = SKShapeNode.init(circleOfRadius: 10)
        circleNode1.fillColor = UIColor.clear
        circleNode1.lineWidth = 3.0
        circleNode1.strokeColor = UIColor.black
        circleNode1.position = CGPoint.init(x: 20, y: 20)
        self.graphScene.addChild(circleNode1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
