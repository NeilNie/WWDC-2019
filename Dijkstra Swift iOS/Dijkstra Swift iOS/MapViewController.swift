//
//  MapViewController.swift
//  Dijkstra Swift iOS
//
//  Created by Yongyang Nie on 3/21/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit
import SpriteKit

class MapViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var graph = Graph()
    
    var mapView : MapRouteView!
    var cities = [String]()
    var routeResult = [String]()
    
    let xScaleFactor = 750*0.73 + 0
    let yScaleFactor = 590*0.70 + 0
    
    // MARK: Import Map Data

    public func importData() {

        let url2 = Bundle.main.url(forResource: "name", withExtension: "csv")
        let cityNameContent = try! String.init(contentsOf: url2!, encoding: String.Encoding.utf8)
        var cityNames = cityNameContent.components(separatedBy: CharacterSet.newlines) as [String]
        var cityDictionary = Dictionary<String, String>()
        
        for i in 0..<cityNames.count {
            
            let cityNameStr = cityNames[i]
            var cityNameData = cityNameStr.components(separatedBy: ",")
            
            cityDictionary[cityNameData[0]] = cityNameData[1] + ", " + cityNameData[2]
        }
        
        let url = Bundle.main.url(forResource: "city", withExtension: "csv")
        let cityWholeContent = try! String.init(contentsOf: url!, encoding: String.Encoding.utf8)
        var cityArray = cityWholeContent.components(separatedBy: CharacterSet.newlines) as [String]
        
        for i in 0..<cityArray.count {
            
            let cityStr = cityArray[i]
            var cityData = cityStr.components(separatedBy: ",")
            
            let coordinate = Coordinate.init(x: Double(cityData[1])!, y: Double(cityData[2])!)
            
            let oneCity : Vertex
            if cityDictionary.keys.contains(cityData[0]){
                oneCity = Vertex.init(key: cityData[0], cost: Double(Int.max), coordinate: coordinate, cityName: cityDictionary[cityData[0]]!, cityState: cityDictionary[cityData[0]]!)
                self.cities.append(cityDictionary[cityData[0]]!)
            }else{
                oneCity = Vertex.init(key: cityData[0], cost: Double(Int.max), coordinate: coordinate, cityName: nil, cityState: nil)
            }
            
            self.graph.addVertex(vertex: oneCity)
        }
        
        //import connection file
        let url3 = Bundle.main.url(forResource: "connection", withExtension: "csv")
        
        let connectionContent = try! String.init(contentsOf: url3!, encoding: String.Encoding.utf8)
        var connections = connectionContent.components(separatedBy: CharacterSet.newlines)
        print("total connections \(connections.count)")
        
        for i in 0..<connections.count{
            
            var connectionRow = connections[i].components(separatedBy: ",")
            
            let s = self.graph.vertextForKey(key: connectionRow[0]).coordinate
            let e = self.graph.vertextForKey(key: connectionRow[1]).coordinate
            self.graph.addEdge(from: connectionRow[0], to: connectionRow[1], weight: self.distance(x1: s.x, y1: s.y, x2: e.x, y2: e.y))

        }
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.routeResult[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routeResult.count
    }
    
    @objc
    // MARK: - IBAction
    public func makeRoute() {
        
        if self.mapView.viewClear == true {
            let startKey = self.getKeyWithCityName(name: self.mapView.startTextField.text!)
            let endKey = self.getKeyWithCityName(name: self.mapView.endTextField.text!)
            
            self.calculatePath(start: startKey!, end: endKey!)
        }else {
            
            let alert = UIAlertController(title: "Oops", message: "Please clear the current path", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    alert.dismiss(animated: true, completion: nil)
                case .cancel:
                    alert.dismiss(animated: true, completion: nil)
                    
                case .destructive:
                    alert.dismiss(animated: true, completion: nil)
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc
    // MARK: - IBAction
    public func ClearRoute() {
        
        
    }
    
    // MARK: - Private Helper Methods
    
    func calculatePath(start: String, end: String) {
    
        let methodStart = Date.init()
        
        self.graph.dijkstra(source: start, destination: end)
    
        var d = 0.0
        
        var result = [String]()
    
        var vt = self.graph.vertextForKey(key: end)

        while vt.previous != nil {
            
            if vt.cityName != nil{
                result.append(vt.cityName)
            }
            
            let path = CGMutablePath()
            path.move(to: CGPoint.init(x: vt.coordinate.x * xScaleFactor - 3, y: vt.coordinate.y * yScaleFactor))
            path.addLine(to: CGPoint.init(x: (vt.previous?.coordinate.x)! * xScaleFactor - 3, y: (vt.previous?.coordinate.y)! * yScaleFactor))
            
            let line = SKShapeNode.init(path: path as CGPath)
            line.name = vt.key
            line.lineWidth = 2.25
            line.strokeColor = UIColor.red
            line.fillColor = UIColor.red
            self.mapView.mapScene.addChild(line)
            
//            d = d + self.distance(x1: vt.coordinate.x, y1: vt.coordinate.y, x2: (vt.previous?.coordinate.x)!, y2: (vt.previous?.coordinate.y)!)

            vt = vt.previous!
        }
        
        self.routeResult = result.reversed()
    
        let methodFinish = Date.init();
        let executionTime = methodFinish.timeIntervalSince(methodStart);
        print(executionTime)
        
        let alert = UIAlertController(title: "Routing Completed", message: "It took \(round(1000*executionTime)/1000) seconds to plan this route. The path crosses \(result.count) cities.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Great!", style: .default, handler: { action in
            switch action.style{
            case .default:
                alert.dismiss(animated: true, completion: nil)
            case .cancel:
                alert.dismiss(animated: true, completion: nil)
                
            case .destructive:
                alert.dismiss(animated: true, completion: nil)
            }}))
        self.present(alert, animated: true, completion: nil)
        
        self.mapView.resultsTableView.reloadData()
        
    }
    
    
    func drawCities(c: Coordinate, key: String){
    
        let circle = SKShapeNode.init(circleOfRadius: 2.00)
        circle.name = key
        circle.strokeColor = UIColor.blue
        circle.fillColor = UIColor.blue
        circle.position = CGPoint.init(x: c.x * xScaleFactor - 3 , y: c.y * yScaleFactor) // - 400.0 - 175.0
        circle.alpha = 0.50
        self.mapView.mapScene.addChild(circle)
    }
    
    func drawAllCities() {
    
        var i = 0;
        for keyString in self.graph.adjacencyList.keys {
            
            let v = self.graph.vertextForKey(key: keyString);
            if i % 100 == 0 {
                self.drawCities(c: v.coordinate, key: keyString)
            }
            i = i + 1;
        }
    }
    
    func distance(x1: Double, y1: Double, x2: Double, y2: Double) -> Double{
        let dx = (x1 - x2);
        let dy = (y1 - y2);
        let dist = sqrt(dx*dx + dy*dy)
        return dist;
    }
    
    func getKeyWithCityName(name: String) -> String! {
        
        for key in self.graph.adjacencyList.keys {
            let vertex = self.graph.vertextForKey(key: key)
            if vertex.cityName == name {
                return vertex.key
            }
        }
        return "Not Found"
    }
    
    // MARK: - UITextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let searchViewController = SearchViewController()
        searchViewController.data = self.cities
        searchViewController.sender = textField
        
        self.present(searchViewController, animated: true, completion: nil)
    }
    
    // MARK: - Load View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        
        self.mapView = MapRouteView.init(frame: CGRect.init(x: 35, y: 50, width: 750, height: 750))
        self.view.addSubview(self.mapView)
        
        self.mapView.endTextField.delegate = self
        self.mapView.startTextField.delegate = self
        self.mapView.resultsTableView.delegate = self
        self.mapView.resultsTableView.dataSource = self
        self.mapView.resultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        self.mapView.clearButton.addTarget(self, action: #selector(ClearRoute), for: UIControl.Event.touchUpInside)
        self.mapView.routeButton.addTarget(self, action: #selector(makeRoute), for: UIControl.Event.touchUpInside)
        
        self.graph = Graph()
        self.importData()
        
        drawAllCities()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
