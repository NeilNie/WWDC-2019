import Foundation
import UIKit
import PlaygroundSupport
//: [Table of Contents](Table%20of%20Contents) | [Find Your Way Around the United States](Find%20Your%20Way%20Around%20the%20United%20States)
/*:
 # About Dijkstra's Algorithm
 
 I always find GPS a fascinating invention. Somehow, it can find the best route between two cities effortlessly, and provide turn by turn directions. Recently, in my computer science class, we studied data structures and algorithms. I was introduced to Dijkstra's algorithm and graphs. I quickly learned that I can construct a graph from a dataset of US cities and geocoordinate, and use the Dijkstra's algorithm to create my own path planner.
 */
let dijkstra = UIImage(named: "Edsger_Dijkstra_1994.jpg")
/*:
 
 ## History
 
 Rumor has it, Edsger Dijkstra invented this famous algorithm while drinking coffee one morning. He quickly jotted down his ideas on a napkin. That idea turned into this very popular pathfinding algorithm.
 
 ## How it works
 
 Dijkstra's algorithm relies on a graph to find the shortest path between nodes. A graph is a data structure that generally has nodes and edges. An edge connects two nodes. A node could have multiple edges. Each node will have a value, generally referred to as a key. An edge will also have a value. In the case of Dijkstra's algorithm, let's refer to it as the cost.
 */
let graph = UIImage(named: "graph_1.png")
/*:
 
 ### Constructing a Graph
 
 In order to create this path planner, we can think of the cities in the United States as nodes on a very large graph. The highways connecting the cities are edges of that graph. Let's assign each node (or city) a key. This key is a unique number. Let's assign the edge a cost value, this cost value will be the Euclidean distance between the two cities.
 */
let graph2 = UIImage(named: "graph_2.png")
/*:
 ### Searching...
 
 Now, each city has a key and each connection between the cities has a weight, we can begin the searching process. The goal of Dijkstra's algorithm is to find the path from A to B while minimizing the cost. The cost between two cities if the sum of all of the edges that connects the two cities. In the example above, the cost of traveling from New York City to Newark, through Boston, is 110. (Currently, it doesn't have a unit, just an arbitrary value. And you shouldn't go through Boston to get to Newark.)
 
 Let's say we want to travel from New York City to New Haven. How would Dijkstra's algorithm calculate the shortest route?
 */
let route1 = UIImage(named: "route_1.png")
//: The cost of route 1 would be 22. 
let route2 = UIImage(named: "route_2.png")
//: The cost of route 2 would be 140
let route3 = UIImage(named: "route_3.png")
/*:
 And finally, the cost of route 3 is 49. Clearly, **route one** is the shortest way to go.
 */
/*:
 # A Quick Example
 
 It's time to put these ideas into action. I created a SpriteKit view to demonstrate a graph and Dijkstra's algorithm. You can add nodes and build edges between them. Using the method `findPath(startIndex, endIndex)`, you can quickly find and visualize the shortest path between two nodes. First, let's create an instance of `GraphView`.
*/
let graphView = GraphView.init(frame: CGRect.init(x: 0, y: 0, width: 500, height: 350))
//: Let's create an array of coordinates. You can also try to add new nodes or remove the existing ones.
var coordinates = [Coordinate]()
coordinates.append(Coordinate(x: -30, y: 4))
coordinates.append(Coordinate(x: 20, y: 100))
coordinates.append(Coordinate(x: -170, y: -19))
coordinates.append(Coordinate(x: 120, y: -20))
coordinates.append(Coordinate(x: 34, y: -100))
//: Let's draw all of the nodes on a graph
graphView.drawGraph(coordinates: coordinates)
//: Now, let's add some edges. You can add or remove edges by commenting out or uncommenting certain lines below.
graphView.drawPath(startVertexIndex: 1, endVertexIndex: 4)
graphView.drawPath(startVertexIndex: 1, endVertexIndex: 3)
// graphView.drawPath(startVertexIndex: 0, endVertexIndex: 1)
graphView.drawPath(startVertexIndex: 4, endVertexIndex: 0)
graphView.drawPath(startVertexIndex: 3, endVertexIndex: 4)
// graphView.drawPath(startVertexIndex: 1, endVertexIndex: 2)
graphView.drawPath(startVertexIndex: 4, endVertexIndex: 2)
graphView.drawPath(startVertexIndex: 2, endVertexIndex: 0)
//: Now, let's use Dijkstra's algorithm to find the shortest path between two nodes. Please change the value of the `startIndex` and `endIndex` to try out different routes. (Please open the Playground Live View)
graphView.findPath(startIndex: 2, endIndex: 3)
PlaygroundPage.current.liveView = graphView
/*:
# Next
 I hope you enjoyed that example.
 Once we are familiar with the principles behind Dijkstra's algorithm, let's try out the interactive demo, and find our ways across the country.
 */
//: [Table of Contents](Table%20of%20Contents) | [Find Your Way Around the United States](Find%20Your%20Way%20Around%20the%20United%20States)
