//
//  Graph.swift
//  Dijkstra Swift
//
//  Created by Yongyang Nie on 3/21/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import Cocoa

public class Graph: NSObject {
    
    public var count = Int()
    public var adjacencyList: NSMutableDictionary
    
    public override init() {
        
        self.adjacencyList = NSMutableDictionary()
    }
    
    //adds an instance of Vertex to the graph.
    public func addVertex(vertex: Vertex) {
        // self.adjacencyList.setValue(vertex, forKey: vertex.key)
        self.adjacencyList.setObject(vertex, forKey: vertex.key as NSCopying)
    }
    //Adds a new, weighted, directed edge to the graph that connects two vertices.
    public func addEdge(from: String, to: String, weight: Double){
        
        let f = self.adjacencyList.object(forKey: from) as? Vertex
        if ((f) != nil) {
            f!.connections.setValue(weight, forKey: to)
        }else{
            f!.connections = NSMutableDictionary()
            f!.connections .setValue(weight, forKey: to)
        }
        
        let t = self.adjacencyList.object(forKey: to) as? Vertex
        if ((t) != nil) {
            f!.connections.setValue(weight, forKey: from)
        }else{
            f!.connections = NSMutableDictionary()
            f!.connections .setValue(weight, forKey: from)
        }
    }
    
    //finds the vertex in the graph named vertKey.
    public func getConnections(key: String) -> NSMutableDictionary {
        return (self.adjacencyList.object(forKey: key) as! Vertex).connections
    }
    
    public func vertextForKey(key: String) -> Vertex {
        return self.adjacencyList.object(forKey: key) as! Vertex
    }
    
    public func dijkstra(source: String, destination: String){
        
        let pq = PriorityQueue()
        
        let s = self.adjacencyList.object(forKey: source) as! Vertex
        s.cost = 0
        
        for key in s.connections.allKeys {
            let v = self.vertextForKey(key: key as! String)
            v.cost = s.connections.object(forKey: key) as! Double
            v.previous = s
            pq.enqueue(x: v)
        }
        
        while (!pq.isEmpty()) {
            
            let v = pq.dequeue()
            for key in v.connections.allKeys {
                let vertex = self.vertextForKey(key: key as! String)
                
                if (vertex.cost >  v.cost + (v.connections.object(forKey: key) as! Double)){
                    
                    vertex.cost = v.cost + (v.connections.object(forKey: key) as! Double)
                    vertex.previous = v
                    pq.enqueue(x: vertex)
                }
            }
        }
    }
    
    public func print() {
        
    }

}
