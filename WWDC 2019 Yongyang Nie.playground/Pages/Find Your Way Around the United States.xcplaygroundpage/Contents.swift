import Foundation
import UIKit
import PlaygroundSupport
//: [About Dijkstra's Algorithm](About%20Dijkstra's%20Algorithm) |  [Under the Hood](Under%20the%20Hood)
/*:
 
 # Find Your Way Around the United States
 
 Let's put Dijkstra's algorithm to use! This is an interactive demo that allows you to travel between cities in the United States.
 
 ## How to use
 
 Please open the live view window. (For a better viewing experience, please fully expand the window and collapse the debug area. The winsow is the size of an iPad) Simply enter the starting city and destination city, and then click the route button, the app will find the shortest route for you and list all the connection cities that you will pass along the way. The clear button will clear and reset the app. 
 
 */
let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 768, height: 1024))
let viewController = MapRouteViewController()
window.rootViewController = viewController
window.makeKeyAndVisible()

PlaygroundPage.current.liveView = window
//: [About Dijkstra's Algorithm](About%20Dijkstra's%20Algorithm) |  [Under the Hood](Under%20the%20Hood)
