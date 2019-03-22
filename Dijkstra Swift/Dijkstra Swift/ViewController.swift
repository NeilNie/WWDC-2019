//
//  ViewController.swift
//  Dijkstra Swift
//
//  Created by Yongyang Nie on 3/21/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    public var g = Graph()
    
//    public func retrieveCoordinates(path: String) -> NSMutableArray{
//
//    }
    
    public func importData(graph: Graph) {
        
        let url = Bundle.main.url(forResource: "name", withExtension: "csv")
        
        let cityWholeContent = try! String.init(contentsOf: url!, encoding: String.Encoding.utf8)

        var cityArray = cityWholeContent.components(separatedBy: CharacterSet.newlines) as [String]

        for i in 0..<cityArray.count {
            
            let cityStr = cityArray[i]
            var cityData = cityStr.components(separatedBy: ",")

            let coordinate = Coordinate.init(x: Double(cityData[4])!, y: Double(cityData[5])!)
            let oneCity = Vertex.init(key: cityData[0], cost: Double(Int.max), coordinate: coordinate, cityName: cityData[1], cityState: cityData[2])

            graph.addVertex(vertex: oneCity)
        }
        
        //import connection file
        let url2 = Bundle.main.url(forResource: "new_connections", withExtension: "csv")
        
        let connectionContent = try! String.init(contentsOf: url2!, encoding: String.Encoding.utf8)
        var connections = connectionContent.components(separatedBy: CharacterSet.newlines)
        print("total connections \(connections.count)")
        var newConnections = [String]()
        
        for i in 0..<connections.count{
            
            var connectionRow = connections[i].components(separatedBy: ",")
            
            let s = graph.vertextForKey(key: connectionRow[0]).coordinate
            let e = graph.vertextForKey(key: connectionRow[1]).coordinate
            graph.addEdge(from: connectionRow[0], to: connectionRow[1], weight: self.distance(x1: s.x, y1: s.y, x2: e.x, y2: e.y))
            
            newConnections.append(connections[i])
        }
    }
    
    public func distance(x1: Double, y1: Double, x2: Double, y2: Double) -> Double{
        let dx = (x1 - x2);
        let dy = (y1 - y2);
        let dist = sqrt(dx*dx + dy*dy);
        return dist;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.g = Graph()
        self.importData(graph: self.g)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

