//
//  MapViewController.swift
//  Dijkstra Swift iOS
//
//  Created by Yongyang Nie on 3/20/19.
//  Copyright © 2019 Yongyang Nie. All rights reserved.
//

import UIKit
import SpriteKit

public class MapRouteViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var graph = Graph()
    
    var mapView : MapRouteView!
    var cities = [String]()
    var routeResult = [String]()
    
    let xScaleFactor = 750*0.64
    let yScaleFactor = 590*0.67
    
    // MARK: - UITableView Delegate
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.routeResult[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routeResult.count
    }
    
    // MARK: - IBAction
    
    @objc
    public func makeRoute() {
        
        if (self.mapView.endTextField.text!.count == 0 && self.mapView.startTextField.text!.count == 0) {
            self.showPleaseEnterAlert()
            return
        }
        
        if self.mapView.viewClear == true{
            
            let startKey = self.getKeyWithCityName(name: self.mapView.startTextField.text!)
            let endKey = self.getKeyWithCityName(name: self.mapView.endTextField.text!)
            
            self.calculatePath(start: startKey!, end: endKey!)
            
            self.mapView.clearButton.isEnabled = true
            self.mapView.viewClear = false
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
    public func clearRoute() {
        
        self.hideViews()
        self.mapView.mapScene.removeAllChildren()
        
        let sn = SKSpriteNode.init(imageNamed: "map.png")
        sn.size = CGSize.init(width: 680, height: 423)
        sn.position = CGPoint.init(x: 0, y: 0)
        sn.xScale = 0.90
        sn.yScale = 0.90
        sn.alpha = 0.75
        self.mapView.mapScene.addChild(sn)
        
        self.drawAllCities()
        self.mapView.startTextField.text = ""
        self.mapView.endTextField.text = ""
        self.mapView.startTextField.placeholder = "Starting City"
        self.mapView.endTextField.placeholder = "Destination City"
        self.mapView.viewClear = true
        
        self.routeResult = [String]()

    }
    
    // MARK: - Private Helper Methods
    
    public func clearScene() {
        
        self.hideViews()
        self.mapView.mapScene.removeAllChildren()
        
        let sn = SKSpriteNode.init(imageNamed: "map.png")
        sn.size = CGSize.init(width: 680, height: 423)
        sn.position = CGPoint.init(x: 0, y: 0)
        sn.xScale = 0.90
        sn.yScale = 0.90
        sn.alpha = 0.75
        self.mapView.mapScene.addChild(sn)
        
        self.drawAllCities()
        
        self.routeResult = [String]()
    }
    
    func calculatePath(start: String, end: String) {
    
        let methodStart = Date.init()
        
        // run dijkstra's algorithm
        self.graph.dijkstra(source: start, destination: end)
        
        var result = [String]()
        var vt = self.graph.vertextForKey(key: end)
        
        // get the path
        while vt.previous != nil {
            
            if vt.cityName != nil{
                result.append(vt.cityName)
            }
            
            let path = CGMutablePath()
            path.move(to: CGPoint.init(x: vt.coordinate.x * xScaleFactor - 2, y: vt.coordinate.y * yScaleFactor - 3))
            path.addLine(to: CGPoint.init(x: (vt.previous?.coordinate.x)! * xScaleFactor - 2, y: (vt.previous?.coordinate.y)! * yScaleFactor - 3))
            
            let line = SKShapeNode.init(path: path as CGPath)
            line.name = vt.key
            line.lineWidth = 2.25
            line.strokeColor = UIColor.red
            line.fillColor = UIColor.red
            self.mapView.mapScene.addChild(line)
            
            vt = vt.previous!
        }
        
        if result.count > 0{
            self.routeResult.append(self.graph.vertextForKey(key: start).cityName)
            self.routeResult = result.reversed()
            
            // calculate execution time
            let methodFinish = Date.init();
            let executionTime = methodFinish.timeIntervalSince(methodStart);
            
            // update views
            self.mapView.resultsTableView.reloadData()
            self.showHiddenViewsWithAlert(executionTime: executionTime, resultCount: result.count)
        }else{
            self.showNotFountAlert()
        }
    }

    func showNotFountAlert() {
        
        let alert = UIAlertController(title: "Oops", message: "No path found... Please try a different city.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
    
    func showPleaseEnterAlert() {
        
        let alert = UIAlertController(title: "Oops", message: "Please enter two cities. Simply click the text field, and then, type or select the cities. ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
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
    
    func showHiddenViewsWithAlert(executionTime: Double, resultCount: Int) {
        
        UIView.animate(withDuration: 0.35, animations: {
            self.mapView.resultsTableView.alpha = 1.0
            self.mapView.titleLabel.alpha = 1.0
        }) { (finished) in
            
            let alert = UIAlertController(title: "Routing Completed", message: "It took \(round(1000*executionTime)/1000) seconds to plan this route. The path crosses \(resultCount) cities.", preferredStyle: .alert)
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
        }
    }
    
    func hideViews() {
        
        UIView.animate(withDuration: 0.35) {
            self.mapView.resultsTableView.alpha = 0.0
            self.mapView.titleLabel.alpha = 0.0
        }
    }
    
    
    func drawCities(c: Coordinate, key: String){
    
        let circle = SKShapeNode.init(circleOfRadius: 1.75)
        circle.name = key
        circle.strokeColor = UIColor.blue
        circle.fillColor = UIColor.blue
        circle.position = CGPoint.init(x: c.x * xScaleFactor - 2 , y: c.y * yScaleFactor - 4.5) // - 400.0 - 175.0
        circle.alpha = 0.50
        self.mapView.mapScene.addChild(circle)
    }
    
    // for a better viewing experience, I only draw one city for every one hundred data point.
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
        
        for i in 0..<connections.count{
            
            var connectionRow = connections[i].components(separatedBy: ",")
            
            let s = self.graph.vertextForKey(key: connectionRow[0]).coordinate
            let e = self.graph.vertextForKey(key: connectionRow[1]).coordinate
            self.graph.addEdge(from: connectionRow[0], to: connectionRow[1], weight: self.distance(x1: s.x, y1: s.y, x2: e.x, y2: e.y))
            
        }
    }
    
    // MARK: - UITextField Delegate

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // clear any existing paths
        clearScene()
        
        // initialize the SearchViewControllers
        let searchViewController = SearchViewController()
        searchViewController.data = self.cities
        searchViewController.sender = textField
        searchViewController.preferredContentSize = CGSize(width: 700, height: 760)

        // present searchViewController
        self.present(searchViewController, animated: true, completion: nil)
    }
    
    // MARK: - Load View
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.mapView = MapRouteView.init(frame: CGRect.init(x: (768 / 2) - CGFloat((700 / 2)), y: 50, width: 700, height: 900))
        self.view.addSubview(self.mapView)
        
        // self.mapView assign delegates
        self.mapView.endTextField.delegate = self
        self.mapView.startTextField.delegate = self
        self.mapView.resultsTableView.delegate = self
        self.mapView.resultsTableView.dataSource = self
        
        self.mapView.resultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        self.mapView.resultsTableView.alpha = 0.0
        self.mapView.clearButton.isEnabled = false
        
        // add actions to self.mapView buttons
        self.mapView.clearButton.addTarget(self, action: #selector(clearRoute), for: UIControl.Event.touchUpInside)
        self.mapView.routeButton.addTarget(self, action: #selector(makeRoute), for: UIControl.Event.touchUpInside)
        
        self.graph = Graph()
        self.importData()
        
        drawAllCities()
        // Do any additional setup after loading the view.
    }
}
