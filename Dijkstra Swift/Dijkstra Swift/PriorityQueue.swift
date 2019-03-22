//
//  PQ.swift
//  Dijkstra Swift
//
//  Created by Yongyang Nie on 3/21/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import Cocoa

public class PriorityQueue: NSObject {
    
    public var count = Int()
    private var heap : Heap
    
    public override init() {
        
        self.heap = Heap()
    }
    
    public init(objects: [Any]) {
        
        self.heap = Heap.init(objects: objects)
    }
    
    public func changePriority(key: String, value: Vertex) {
        self.heap.replace(key: key, value: value)
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
    
    public func print () {
        
    }
 
}
