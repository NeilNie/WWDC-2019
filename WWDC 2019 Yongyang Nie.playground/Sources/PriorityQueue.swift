//
//  PQ.swift
//  Dijkstra Swift
//
//  Created by Yongyang Nie on 3/20/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//
//  The PQ class is essentially a top-level wrapper for the Heap class

public class PriorityQueue {
    
    public var count = Int()
    private var heap : Heap
    
    public init() {
        
        self.heap = Heap()
    }
    
    public init(objects: [Any]) {
        
        self.heap = Heap.init(objects: objects)
    }
    
    public func size() -> Int {
        return self.heap.count
    }
    
    public func isEmpty() -> Bool {
        return self.heap.isEmpty
    }
    
    public func peek() -> Vertex {
        return self.heap.peek()
    }
    
    public func enqueue(x: Vertex) {
        self.heap.insert(object: x)
    }
    
    public func dequeue() -> Vertex {
        return self.heap.remove()
    }
 
}
