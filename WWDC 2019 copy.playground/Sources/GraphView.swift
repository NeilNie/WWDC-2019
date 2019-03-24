//
//  GraphSceneView.swift
//  GraphView
//
//  Created by Yongyang Nie on 3/23/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit
import SpriteKit

public class GraphView: UIView {
    
    public var graphScene : SKView!
    public var graph : Graph!
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.graphScene = SKView.init()
        self.graphScene.frame = self.frame
        self.graphScene.presentScene(SKScene(fileNamed: "GraphViewScene.sks"))
        self.addSubview(graphScene)
        
        self.graph = Graph()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func drawGraph(coordinates: [Coordinate]) {
        
        for (index, coordinate) in coordinates.enumerated() {
            
            let circleNode = SKShapeNode.init(circleOfRadius: 12)
            circleNode.fillColor = UIColor.clear
            circleNode.lineWidth = 3.0
            circleNode.strokeColor = UIColor.white
            circleNode.position = CGPoint.init(x: coordinate.x, y: coordinate.y)
            circleNode.name = String(index)
            self.graphScene.scene!.addChild(circleNode)
            
            let label = SKLabelNode(text: "\(index)")
            label.fontSize = 11
            label.position = CGPoint.init(x: circleNode.position.x, y: circleNode.position.y - 5)
            self.graphScene.scene!.addChild(label)
            
            let vertex = Vertex.init(key: String(index), cost: Double(Int.max), coordinate: coordinate, cityName: "Name", cityState: "State")
            self.graph.addVertex(vertex: vertex)
        }
    }
    
    public func drawPath(startVertexIndex: Int, endVertexIndex: Int){
        
        let startNode = self.graphScene.scene!.childNode(withName: String(startVertexIndex))
        let endNode = self.graphScene.scene!.childNode(withName: String(endVertexIndex))
        
        let weight = distance(x1: (startNode?.position.x)!, y1: startNode!.position.y, x2: endNode!.position.x, y2: endNode!.position.y)
        graph.addEdge(from: String(startVertexIndex), to: String(endVertexIndex), weight: weight)
        
        let path = CGMutablePath()
        path.move(to: CGPoint.init(x: (startNode?.position.x)!, y: startNode!.position.y))
        path.addLine(to: CGPoint.init(x: endNode!.position.x, y: endNode!.position.y))
        
        let line = SKShapeNode.init(path: path as CGPath)
        line.lineWidth = 2.25
        line.strokeColor = UIColor.red
        line.fillColor = UIColor.red
        self.graphScene.scene!.addChild(line)
        
        let label = SKLabelNode(text: "\(round(weight))")
        label.position = line.position
        label.fontSize = 9
        self.graphScene.scene!.addChild(label)
        
    }
    
    func distance(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) -> Double{
        let dx = (x1 - x2);
        let dy = (y1 - y2);
        let dist = sqrt(dx*dx + dy*dy)
        return Double(dist);
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
