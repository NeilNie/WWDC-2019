//
//  Heap.swift
//  Dijkstra Swift
//
//  Created by Yongyang Nie on 3/21/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

public class Heap {

    public var count = Int()
    public var isEmpty : Bool {
        get {
            return self.array.count == 0
        }
    }
    
    private var array : Array<Any>
    
    // MARK: Constructor
    
    public init() {
        
        self.array = Array()
    }
    
    public init(objects: [Any]) {
        
        self.array = Array.init(arrayLiteral: objects)
        
        for i in 0..<(objects.count / 2) {
            self.heapify(index: i, size: self.array.count)
        }
    }
    
    // MARK: Instance Methods
    
    /**
     * Takes a child node and looks at its parents; if a parent is not larger
     * (max-heap) or not smaller (min-heap) than the child, we exchange them.
     **/
    public func shiftUp(n: Int) {
        
        var childIndex = n
        let child = self.array[childIndex] as! Vertex
        
        var parentIndex = self.parentIndex(i: childIndex) //calculate the parent index
        
        while (childIndex > 0 && child.cost < (self.array[parentIndex] as! Vertex).cost) {
            
            //replace item at childIndex with item at parent index.
            self.array[childIndex] = self.array[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(i: childIndex)
        }
        self.array[childIndex] = child
    }
    
    //If the element is smaller (max-heap) or greater (min-heap) than its children, it needs to move down the tree. This operation is also called "heapify".
    public func heapify(index: Int, size: Int) {
        
        var parentIndex = index;
        
        while (true) {
            
            let leftChildIndex = self.leftChildIndex(i: parentIndex)
            let rightChildIndex = leftChildIndex + 1
            
            // Figure out which comes first if we order them by the sort function: the parent, the left child, or the right child.
            // If the parent comes first, we're done. If not, that element is out-of-place and we make it "float down" the tree until the heap property is restored.
            var first = parentIndex;
            if (leftChildIndex < self.array.count && ((self.array[leftChildIndex] as! Vertex).cost < (self.array[first] as! Vertex).cost)){
                first = leftChildIndex
            }
            if (rightChildIndex < self.array.count && ((self.array[rightChildIndex] as! Vertex).cost < (self.array[first] as! Vertex).cost)){
                first = rightChildIndex;
            }
            if (first == parentIndex){
                return
            }
            self.array.swapAt(parentIndex, first)
            parentIndex = first
        }
    }
    
    public func heapify() {
        
        self.heapify(index: 0, size: self.array.count)
    }
    
    //Adds the new element to the end of the heap and then uses shiftUp() to fix the heap.
    public func insert(object: Vertex) {
        
        self.array.append(object)
        self.shiftUp(n: self.array.count - 1)
    }
    
    //Removes and returns the maximum value (max-heap) or the minimum value (min-heap). To fill up the hole that's left by removing the element, the very last element is moved to the root position and then shiftDown() fixes up the heap. (This is sometimes called "extract min" or "extract max".)
    public func remove() -> Vertex! {
        
        if (self.array.count == 0){
            return nil
        }else if (self.array.count == 1){
            let v = self.array.last
            self.array.removeLast()
            return v as? Vertex
        }
        else {
            let v = self.array[0]
            self.array[0] = self.array[self.array.count - 1]
            self.array.removeLast()
            self.heapify()
            return v as? Vertex
        }
    }
    
    //Just like remove() except it lets you remove any item from the heap, not just the root. This calls both shiftDown(), in case the new element is out-of-order with its children, and shiftUp(), in case the element is out-of-order with its parents.
    public func removeAt(index: Int) -> Vertex! {
        
        if (index > self.array.count - 1){
            return nil
        }
        
        let size = self.array.count - 1;
        
        if (index != size) {
            self.array.swapAt(size, index)
            self.heapify(index: index, size: size)
            self.shiftUp(n: index)
        }
        
        let n = self.array.last
        self.array.removeLast()
        return n as? Vertex
    }
    
    //Heaps aren't built for efficient searches but the replace() and removeAtIndex() operations require the array index of the node, so you need to find that index somehow. Time: O(n).
//    public func search(key: String) -> Vertex {
//        return self.nodes[key] as! Vertex
//    }
    
    public func peek() -> Vertex {
        return self.array.first as! Vertex
    }
    
    // private helpers
    
    public func parentIndex(i: Int) -> Int{
        return (i - 1) / 2;
    }
    
    /**
     * Note that this index can be greater than the heap size, in which case there is no left child.
     */
    public func leftChildIndex(i: Int) -> Int{
        return 2 * i + 1;
    }
    
    /**
     * Note that this index can be greater than the heap size, in which case there is no right child.
     */
    public func rightChildIndex(i: Int) -> Int{
        return 2 * i + 2;
    }
    
    public func print () {
        
    }

}
