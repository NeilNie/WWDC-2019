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
    
    var graphScene : SKView!
    var graph : Graph!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.graphScene = SKView.init()
        self.graphScene.frame = self.frame
        self.graphScene.presentScene(SKScene(fileNamed: "GraphViewScene.sks"))
        self.graphScene.backgroundColor = UIColor.init(red: 245.0 / 255, green: 245.0 / 255, blue: 245.0 / 255, alpha: 1.0)
        self.addSubview(graphScene)
        
        self.graph = Graph()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func drawGraph(coordinates: [Coordinate]) {
        
        for (index, coordinate) in coordinates.enumerated() {
            
            let circleNode = SKShapeNode.init(circleOfRadius: 10)
            circleNode.fillColor = UIColor.clear
            circleNode.lineWidth = 3.0
            circleNode.strokeColor = UIColor.black
            circleNode.position = CGPoint.init(x: coordinate.x, y: coordinate.y)
            circleNode.name = String(index)
            self.graphScene.scene!.addChild(circleNode)
            
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
        
        let label = SKLabelNode(text: "\(weight)")
        label.position = line.position
        self.graphScene.scene!.addChild(label)

    }
    
    public func findPath(startIndex: Int, endIndex: Int) -> Double {
        
        self.graph.dijkstra(source: String(startIndex), destination: String(endIndex))
        
        var result = [String]()
        var vt = self.graph.vertextForKey(key: String(endIndex))
        
        var totalCost = 0.0
        
        // get the path
        while vt.previous != nil {
            
            result.append(vt.key)
            
            let path = CGMutablePath()
            path.move(to: CGPoint.init(x: vt.coordinate.x, y: vt.coordinate.y))
            path.addLine(to: CGPoint.init(x: vt.previous!.coordinate.x, y: vt.previous!.coordinate.y))
            
            let line = SKShapeNode.init(path: path as CGPath)
            line.name = vt.key
            line.lineWidth = 2.25
            line.strokeColor = UIColor.red
            line.fillColor = UIColor.red
            self.graphScene.scene?.addChild(line)
            
            totalCost = totalCost + distance(x1: CGFloat(vt.coordinate.x), y1: CGFloat(vt.coordinate.y), x2: CGFloat((vt.previous?.coordinate.x)!), y2: CGFloat((vt.previous?.coordinate.y)!))
            
            vt = vt.previous!
        }
        return totalCost
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
