//
//  MapRouteView.swift
//  Dijkstra Swift iOS
//
//  Created by Yongyang Nie on 3/21/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MapRouteView: UIView {
    
    var startTextField : UITextField!
    var endTextField : UITextField!
    var routeButton : UIButton!
    var clearButton : UIButton!
    var mapScene : SKScene!
    var mapSceneView : SKView!
    var resultsTableView: UITableView!
    
    var viewClear = true
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // SpriteKit
        mapScene = SKScene.init(fileNamed: "GameScene.sks")
        mapScene.backgroundColor = UIColor.white
        let sn = SKSpriteNode.init(imageNamed: "map.png")
        sn.size = CGSize.init(width: 710, height: 380)
        sn.position = CGPoint.init(x: 0, y: 10)
        sn.alpha = 0.75
        mapScene.addChild(sn)
        
        let size = 710
        let screenWidth = self.frame.size.width
        
        mapSceneView = SKView.init(frame: CGRect.init(x: (screenWidth / 2) - CGFloat((size / 2)), y: 125, width: 710, height: 350))
        mapSceneView.presentScene(mapScene)
        mapSceneView.backgroundColor = UIColor.white
        
        mapSceneView.layer.shadowOffset = CGSize.init(width: 10, height: 15)
        mapSceneView.layer.shadowRadius = 5
        mapSceneView.layer.shadowOpacity = 0.1
        
        self.addSubview(mapSceneView)
        
        // Textfield
        startTextField = UITextField.init(frame: CGRect.init(x: 130, y: 20, width: 190, height: 30))
        startTextField.borderStyle = UITextField.BorderStyle.roundedRect
        startTextField.placeholder = "Starting City"
        self.addSubview(startTextField)
        
        endTextField = UITextField.init(frame: CGRect.init(x: self.frame.width - 130 - 190, y: 20, width: 190, height: 30))
        endTextField.borderStyle = UITextField.BorderStyle.roundedRect
        endTextField.placeholder = "Destination City"
        self.addSubview(endTextField)
        
        routeButton = UIButton.init(frame: CGRect.init(x: 200, y: 65, width: 120, height: 33))
        routeButton.setTitle("Make Route", for: UIControl.State.normal)
        routeButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        routeButton.backgroundColor = UIColor.init(red: 137.0 / 255.0, green: 156.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        routeButton.layer.cornerRadius = 3.0
        self.addSubview(routeButton)
        
        clearButton = UIButton.init(frame: CGRect.init(x: self.frame.width - 120 - 200, y: 65, width: 120, height: 33))
        clearButton.setTitle("Clear", for: UIControl.State.normal)
        clearButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        clearButton.backgroundColor = UIColor.init(red: 137.0 / 255.0, green: 207.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        clearButton.layer.cornerRadius = 3.0
        self.addSubview(clearButton)
        
        resultsTableView = UITableView.init(frame: CGRect.init(x: (screenWidth / 2) - CGFloat((size / 2)), y: 500, width: 710, height: 200))
        
        resultsTableView.layer.shadowOffset = CGSize.init(width: 10, height: 15)
        resultsTableView.layer.shadowRadius = 5
        resultsTableView.layer.shadowOpacity = 0.1
        self.addSubview(resultsTableView)
        self.backgroundColor = UIColor.white
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
