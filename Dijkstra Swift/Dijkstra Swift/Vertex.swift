//
//  Vertex.swift
//  Dijkstra Swift
//
//  Created by Yongyang Nie on 3/21/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import Cocoa

public struct Coordinate{
    var x = Double()
    var y = Double()
}

public class Vertex: NSObject {
    
    public var connections = NSMutableDictionary()
    public var coordinate = Coordinate()
    public var key = String()
    public var previous: Vertex?
    public var cost : Double
    public var cityName = String()
    public var cityState = String()
    
    public override init() {
        
        self.previous = nil
        self.cost = Double(Int.max)
    }
    
    public init(key: String, cost: Double, coordinate: Coordinate, cityName: String, cityState: String) {
        
        self.key = key
        self.cost = cost
        self.coordinate = coordinate
        self.cityName = cityName
        self.cityState = cityState
        self.previous = nil
    }
    
    public func makeCoordinate(x: Double, y: Double) -> Coordinate {
        
        return Coordinate(x: x, y: y)
    }
    
}
