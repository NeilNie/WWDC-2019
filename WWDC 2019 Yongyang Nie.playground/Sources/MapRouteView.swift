//
//  MapRouteView.swift
//  Dijkstra Swift iOS
//
//  Created by Yongyang Nie on 3/20/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public class MapRouteView: UIView {
    
    var startTextField : UITextField!
    var endTextField : UITextField!
    var routeButton : UIButton!
    var clearButton : UIButton!
    var mapScene : SKScene!
    var mapSceneView : SKView!
    var resultsTableView: UITableView!
    var titleLabel : UILabel!
    
    var viewClear = true
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // SpriteKit
        mapScene = SKScene(fileNamed: "GameScene.sks")
        mapScene.backgroundColor = UIColor(red: 245.0 / 255, green: 245.0 / 255, blue: 245.0 / 255, alpha: 1.0)
        let sn = SKSpriteNode.init(imageNamed: "map.png")
        sn.size = CGSize.init(width: 680, height: 423)
        sn.position = CGPoint.init(x: 0, y: 0)
        sn.xScale = 0.90
        sn.yScale = 0.90
        sn.alpha = 0.75
        mapScene.addChild(sn)
        
        mapSceneView = SKView.init(frame: CGRect.init(x: (self.frame.size.width / 2) - CGFloat((680 / 2)), y: 125, width: 680, height: 350))
        mapSceneView.presentScene(mapScene)
        mapSceneView.backgroundColor = UIColor(red: 245.0 / 255, green: 245.0 / 255, blue: 245.0 / 255, alpha: 1.0)
        mapSceneView.layer.cornerRadius = 10.0
        mapSceneView.clipsToBounds = true
        
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
        
        // route button
        routeButton = UIButton.init(frame: CGRect.init(x: 200, y: 65, width: 120, height: 33))
        routeButton.setTitle("Make Route", for: UIControl.State.normal)
        routeButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        routeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        routeButton.backgroundColor = UIColor(red: 137.0 / 255.0, green: 156.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        routeButton.layer.cornerRadius = 3.0
        self.addSubview(routeButton)
        
        // clear button
        clearButton = UIButton.init(frame: CGRect.init(x: self.frame.width - 120 - 200, y: 65, width: 120, height: 33))
        clearButton.setTitle("Clear", for: UIControl.State.normal)
        clearButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        clearButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        clearButton.backgroundColor = UIColor(red: 137.0 / 255.0, green: 207.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        clearButton.layer.cornerRadius = 3.0
        self.addSubview(clearButton)
        
        // UITable title label
        titleLabel = UILabel.init(frame: CGRect.init(x: 15, y: 490, width: 300, height: 35))
        titleLabel.text = "Major cities and towns on the paths"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.textColor = UIColor(red: 137.0 / 255.0, green: 156.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        titleLabel.alpha = 0.0
        self.addSubview(titleLabel)
        
        // result table
        resultsTableView = UITableView.init(frame: CGRect.init(x: (self.frame.size.width / 2) - CGFloat((680 / 2)), y: 530, width: 680, height: 300))
        resultsTableView.backgroundColor = UIColor(red: 245.0 / 255, green: 245.0 / 255, blue: 245.0 / 255, alpha: 1.0)
        resultsTableView.layer.cornerRadius = 10
        resultsTableView.clipsToBounds = true
        
        resultsTableView.alpha = 0.0
        
        self.addSubview(resultsTableView)
        self.backgroundColor = UIColor.white
        
        self.clipsToBounds = true
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
