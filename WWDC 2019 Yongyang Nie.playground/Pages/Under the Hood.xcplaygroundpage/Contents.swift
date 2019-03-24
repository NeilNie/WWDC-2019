//: [Find Your Way Around the United States](Find%20Your%20Way%20Around%20the%20United%20States) | [Table of Contents](Table%20of%20Contents)
/*:
 
 # Under the Hood
 
 I hope you enjoyed that demo. Now please allow me to briefly describe my code.
 
 # Organization
 
 I declared three data structures for this project: `Graph`, `Heap`, and `PriorityQueue`. A heap is essentially a wrapper for the priority queue. I declared a `Vertex` class, which is the building block for the graph. (A node is also known as a vertex in a graph.)
 
 The main view controller is called `MapRouteViewController`. The `MapRouteViewController` has a `MapRouteView` as its subview. `MapRouteView` has a top-level wrapper method for the `dijkstra` function (declared in `Graph`). After executing the algorithm, MapRouteView draws the path in red. When entering a city, a `SearchViewController` will be presented. The `SearchViewController` has a `SearchView` as its subview.
 
 `GraphView` was used in the first demo. It's an `UIView` containing a `SKView`. `GraphView` has instance methods that allow you to add nodes and edges to the graph, and render the visualization after compilation. Similar to `MapRouteView`, `GraphView` also has a top-level wrapper method for the `dijkstra` method. After executing the algorithm, GraphView draws the path in red.
 # Frameworks and Tools
 
 I created all of the data structures and UI elements myself. I mainly relied on two frameworks, UIKit and SpriteKit. I rendered the map view with SpriteKit.
 
 # Finally... 😀
 
 I hope you have joyed this playground. I look forward to a wonderful WWDC this year!
 */
//: [Find Your Way Around the United States](Find%20Your%20Way%20Around%20the%20United%20States) | [Table of Contents](Table%20of%20Contents)
