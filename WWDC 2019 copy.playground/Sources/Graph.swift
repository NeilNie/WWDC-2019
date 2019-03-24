//
//  Graph.swift
//  Dijkstra Swift
//
//  Created by Yongyang Nie on 3/20/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

public class Graph {
    
    public var count = Int()
    public var adjacencyList: Dictionary<String, Any>
    
    public init() {
        
        self.adjacencyList = Dictionary()
    }
    
    //adds an instance of Vertex to the graph.
    public func addVertex(vertex: Vertex) {
        // self.adjacencyList.setValue(vertex, forKey: vertex.key)
        self.adjacencyList[vertex.key] = vertex
    }
    
    //Adds a new, weighted, directed edge to the graph that connects two vertices.
    public func addEdge(from: String, to: String, weight: Double){
        
        let f = self.adjacencyList[from] as? Vertex
        f!.connections[to] = weight
        
        let t = self.adjacencyList[to] as? Vertex
        t!.connections[from] = weight
    }
    
    //finds the vertex in the graph named vertKey.
    public func getConnections(key: String) -> Dictionary<String, Any> {
        return (self.adjacencyList[key] as! Vertex).connections
    }
    
    public func vertextForKey(key: String) -> Vertex {
        return self.adjacencyList[key] as! Vertex
    }
    
    public func dijkstra(source: String, destination: String){
        
        let pq = PriorityQueue()
        
        let s = self.adjacencyList[source] as! Vertex
        s.cost = 0
        
        for key in s.connections.keys {
            let v = self.vertextForKey(key: key)
            v.cost = s.connections[key] as! Double
            v.previous = s
            pq.enqueue(x: v)
        }
        
        while (!pq.isEmpty()) {
            
            let v = pq.dequeue()
            
            for key in v.connections.keys {
                let vertex = self.vertextForKey(key: key)
                
                if (vertex.cost >  v.cost + (v.connections[key] as! Double)){
                    
                    vertex.cost = v.cost + (v.connections[key] as! Double)
                    vertex.previous = v
                    pq.enqueue(x: vertex)
                }
            }
        }
    }

}
