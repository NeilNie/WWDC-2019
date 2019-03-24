import Foundation
import UIKit
import PlaygroundSupport
/*:
 
 # About Dijkstra's Algorithm
 
 I always find GPS a fasnating invention. Somehow, it can find the best route between two cities effortlessly, and provide turn by turn directions. Recently, in my computer science class, we studied data structions and algorithms. I was introduced to the Dijkstra's algorithm and graphs. I quickly learned that I can construct a graph from a dataset of US cities and geocoordinate, and use the Dijkstra's algorithm to create my own path planner.
 */
let dijkstra = UIImage(named: "Edsger_Dijkstra_1994.jpg")
/*:
 
 ## History
 
 Rumor has it, Edsger Dijkstra invented this famous algorithm while drinking coffee one morning. He quickly jotted down his ideas on a napkin. That idea turned into this very popular path finding algorithm.
 
 ## How it works
 
 Dijkstra's algorithm relies on a graph to find the shortest path between nodes. A graph is a data struction that generally has nodes and edges. An edge connects two nodes. A node could have multiple edges. Each node will have a value, generally refered to as a key. An edge will also have a value. In the case of the Dijkstra's algorithm, let's refer to it as the cost.
 */
let graph = UIImage(named: "graph_1.png")
/*:
 
 ### Constructing a Graph
 
 In order to create this path planner, we can think of the cities in the United States as nodes on a very large graph. The highways connecting the cities as the edges of that graph. Let's assign each node (or city) a key. This key is a unique number. Let's assign the edge a cost value, this cost value will be the Euclian distance between the two cities.
 */
let graph2 = UIImage(named: "graph_2.png")
/*:
 ### Searching...
 
 Now, each cities has a key and each connection between the cities has a weight, we can begin the searching process. The goal of the dikjstra's algorithm is to find the path from A to B while minizing the cost. The cost between two cities if the sum of all of the edges that connects the two cities. In the example above, the cost between traveling from New York to Newark, through Jersey City, is 110. (It doesn't have a unit, just an arbitary value.)
 
 Let's say we want to travel from New York City to New Haven. How would dijkstra's algorithm calculate the shortest route?
 */
let route1 = UIImage(named: "route_1.png")
//: The cost of route 1 would be 22. 
let route2 = UIImage(named: "route_2.png")
//: The cost of route 2 would be 140
let route3 = UIImage(named: "route_3.png")
/*:
 And finally, the cost of route 3 is 49. Clearly, route one is the shortest way to go.
 
 # Next
 
 Once we are familar with the principles behind Dijkstra's algoritm, let's tryout the interative demo, and find our ways across the country.
 
 */
let graphView = GraphView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300))

//: Let's create an array of coordinates
var coordinates = [Coordinate]()
coordinates.append(Coordinate(x: -20, y: 4))
coordinates.append(Coordinate(x: 12, y: 60))
coordinates.append(Coordinate(x: -80, y: -19))
coordinates.append(Coordinate(x: 70, y: -6))
coordinates.append(Coordinate(x: 34, y: -60))
//: Let's draw all of the nodes on a graph
graphView.drawGraph(coordinates: coordinates)

//: Now, let's add some edges.
graphView.drawPath(startVertexIndex: 0, endVertexIndex: 1)
graphView.drawPath(startVertexIndex: 4, endVertexIndex: 0)
graphView.drawPath(startVertexIndex: 1, endVertexIndex: 4)
graphView.drawPath(startVertexIndex: 3, endVertexIndex: 4)
PlaygroundPage.current.liveView = graphView

//: [Table of Conetents](@Table%20of%20Conetents) | [Next](@Find%20Your%20Way%20Around%20the%20United%20States)
