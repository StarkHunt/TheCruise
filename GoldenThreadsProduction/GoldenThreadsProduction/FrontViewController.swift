//
//  FrontViewController.swift
//  GoldenThreadsProduction
//
//  Created by Sugat Nagavkar on 06/10/16.
//  Copyright © 2016 Sugat Nagavkar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//American Meuseum of Natural History: 40.781544, -73.974627 --1
//Brooklyn Bridge: 40.711186, -74.003396 --2
//Bryant Park: 40.753798, -73.983587 --3
//Columbus Circle : 40.768095, -73.981955 done --4
//Empire State Building: 40.748480, -73.985686 --5
//Flatiron Building: 40.741175, -73.989644 --6
//Grand Central Terminal: 40.752621, -73.977157 --7
//Madison Square Garden: 40.749926, -73.993988 --8
//Port Authority Bus Terminal : 40.757229, -73.989800 --9
//Rockefellar Center : 40.758695, -73.978729 --10
//South Ferry: 40.701721, -74.013248 --11
//Times Square : 40.759204, -73.984627 done --12
//The Rokefeller University: 40.763010, -73.955992 --13
//133 E 58, VS : 40.761628, -73.968670 done --14
//WTC: 40.710604, -74.015668 --15

class FrontViewController: UIViewController,UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate {
    // inheritance from other subclasses, like View Controller
    //Search Bar
    //Table View
    // Location Services
    // Map View
    
    @IBOutlet weak var searchCurrentLocation: UISearchBar!
    @IBOutlet weak var more: UIBarButtonItem!
    
    @IBOutlet weak var searchDestinationLocation: UISearchBar!
    @IBOutlet weak var customMap: MKMapView!
    
    @IBOutlet weak var customTable: UITableView!
    
    var forwardgeovariable = CLLocation()
    var newLocation : CLLocationCoordinate2D!
    var locationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D!
    var newCurrentLocation: CLLocationCoordinate2D!
    var newDestinationLocation: CLLocationCoordinate2D!
    
    //array of Location Coordinates
    var allAgentLocations : [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 40.781544, longitude: -73.974627),
        CLLocationCoordinate2D(latitude: 40.711186, longitude: -74.003396),
    CLLocationCoordinate2D(latitude: 40.753798, longitude: -73.983587),
    CLLocationCoordinate2D(latitude: 40.768095, longitude: -73.981955),
    CLLocationCoordinate2D(latitude: 40.748480, longitude: -73.985686),
    CLLocationCoordinate2D(latitude: 40.741175, longitude: -73.989644),
    CLLocationCoordinate2D(latitude: 40.752621, longitude: -73.977157),
    CLLocationCoordinate2D(latitude: 40.749926, longitude: -73.993988),
    CLLocationCoordinate2D(latitude: 40.757229, longitude: -73.989800),
    CLLocationCoordinate2D(latitude: 40.758695, longitude: -73.978729),
    CLLocationCoordinate2D(latitude: 40.701721, longitude: -74.013248),
    CLLocationCoordinate2D(latitude: 40.759204, longitude: -73.984627),
    CLLocationCoordinate2D(latitude: 40.763010,  longitude: -73.955992),
    CLLocationCoordinate2D(latitude: 40.761628,  longitude: -73.968670),
    CLLocationCoordinate2D(latitude: 40.710604,  longitude: -74.015668)]
    
    //array of Location Names
    var allAgentNames = ["American Meuseum of Natural History", "Brooklyn Bridge", "Bryant Park", "Columbus Circle", "Empire State Building", "Flatiron Building", "Grand Central Terminal", "Madison Square Garden", "Port Authority Bus Terminal", "Rockefellar Center", "South Ferry", "Times Square", "The Rokefeller University", "Victoria Secret Store", "World Trade Center"]
    
    //Array of Location Subtitles
    var allAgentSubtitles = ["History Comes to Life", "Connecting Manhatten and Brooklyn", "Winter Village", "Captain Columbus", "Crown Jewel of Manhatten", "The Famous", "Transporting People", "For the Oraters and Sports People", "Way to go to Jersey", "The Christmas Tree", "To the South", "Energetic Place", "Student Section", "Girls Store", "Standing High"]
    
    var setCurrentLocationCoordinates = CLLocationCoordinate2D()
    var setDestinationLocationCoordinates = CLLocationCoordinate2D()
    
    @IBOutlet weak var busTimings: UITextView!
    
    
    var searchActive : Bool = false
    var filteredArrayList = [String]()
    //arrays for bus timings

    //Array of Bus timings
    let B1AmericanToWTC = [6.00, 7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00]
    let B1RWTCToAmerican = [7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00,18.00, 20.00, 21.00, 22.00, 23.00]
    let B2AmericanToFlatiron = [6.00, 7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00,18.00, 20.00, 21.00, 22.00]
    let B1RFlatironToAmerican = [7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00, 23.00]
    let B3AmericanToMadison = [6.00, 7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00]
    let B3RMadisonToAmerican = [7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00, 23.00]
    let B4AmericanGCT = [6.00, 7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00]
    let B4RGCTAmerican = [7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00, 23.00]
    let B5SouthFerryToTS = [6.00, 7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00]
    let B5RTSToSouthFerry = [7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00, 23.00]
    let B6ColumbusToTRU = [6.00, 7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00]
    let B6RTRUToColumbus = [7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00, 23.00]
    let B7ESBToTRU = [6.00, 7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00]
    let B7RTRUToESB = [7.00, 8.00, 9.00, 10.00, 11.00, 12.00, 13.00, 14.00, 15.00, 16.00, 17.00, 18.00, 20.00, 21.00, 22.00, 23.00]
    
    var newDistance = String()
    var newTime = String()
 
    override func viewDidLoad() {
        
        self.title = "The Cruise"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 18)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        //tell table view that we are using data from this controller
        self.customTable.delegate = self
        self.customTable.dataSource = self
        
        //tell search bar that we are using data from this controller
        self.searchCurrentLocation.delegate = self
        self.searchDestinationLocation.delegate = self
        
        //Text View hidden when the view appears at first.
        self.busTimings.isHidden = true
        
        //slide bar menu
        more.target = self.revealViewController()
        more.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //table view is hidden when the view appears
        self.customTable.isHidden = true
        
        //tell map we are using data from this controller
        customMap.delegate = self
        locationManager.delegate = self
        
        //mapView.mapType = MKMapType.standard
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //show users current location
        customMap.showsUserLocation = true
        
        //annotations created by using this code
        var annotation = MKPointAnnotation()
        
        for i in 0..<allAgentNames.count {
            let annotation = MKPointAnnotation()
            annotation.title = allAgentNames[i]
            annotation.subtitle = allAgentSubtitles[i]
                annotation.coordinate = CLLocationCoordinate2D(latitude: allAgentLocations[i].latitude, longitude: allAgentLocations[i].longitude)
            customMap.addAnnotation(annotation)
        }
        
        //add annotations to the map.
        customMap.addAnnotation(annotation)
        
    }//end of viewDidLoad()
    
    override func viewDidAppear(_ animated: Bool) {
        
        let nav = navigationController?.navigationBar
        nav?.barTintColor = UIColor.gray
        
    }
    
    //MARK : - Location Delegate Methods
    
    @IBAction func searchButton(_ sender: AnyObject) {
        
        //remove all overlaying route lines
        let overlays = customMap.overlays
        customMap.removeOverlays(overlays)
        
        let currentText = searchCurrentLocation.text!
        let currentNumber = allAgentNames.index(of: currentText)
        setCurrentLocationCoordinates = allAgentLocations[currentNumber!]
        
        let destinationText = searchDestinationLocation.text!
        let destinationNumber = allAgentNames.index(of: destinationText)
        setDestinationLocationCoordinates = allAgentLocations[destinationNumber!]
        
        let request = MKDirectionsRequest()
        //select source location
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: setCurrentLocationCoordinates, addressDictionary: nil))
        
        //select desination location
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: setDestinationLocationCoordinates, addressDictionary: nil))
        //for selecting alternate routes
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate{(response:
            MKDirectionsResponse?, error: Error?) in
            if error != nil {
                print("Error getting directions")
            } else {
                self.showRoute(response!)
                let distance = response?.routes.first?.distance
                if distance != nil{
                    print("Distance not nil")
                }
                let time = response?.routes.first?.expectedTravelTime
                self.newTime = String(describing: time)
                print("Distance for required guy: \(distance!)")
                print("Time for required guy: \(time)")
            }
        }
        
        //code to get the current time
        let date = NSDate()
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        print("Hour: \(hour) and Minute: \(minutes)")
        
        self.busTimings.isHidden = false
        
        if (searchCurrentLocation.text! == "American Meuseum of Natural History" && searchDestinationLocation.text! == "World Trade Center"){
            let hourNumber = B1AmericanToWTC.index(of: Double(hour))
            var appendText = String()

            for i in hourNumber!..<B1AmericanToWTC.count{
                    appendText.append(String(B1AmericanToWTC[i]) + "0, ")
                
            }
            
            busTimings.text = ("B1 Bus Timings: \(appendText). Distance: 6.1 miles. Time: 30 mins")
        }else if(searchCurrentLocation.text! == "World Trade Center" && searchDestinationLocation.text! == "American Meuseum of Natural History"){
            let hourNumber = B1RWTCToAmerican.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B1RWTCToAmerican.count{
                appendText.append(String(B1AmericanToWTC[i] + 0.45) + ", ")
                
            }
            busTimings.text = ("B1 Bus Timings: \(appendText). Distance: 6.1 miles. Time: 30 mins")
        }else if(searchCurrentLocation.text! == "American Meuseum of Natural History" && searchDestinationLocation.text! == "Flatiron Building"){
            let hourNumber = B2AmericanToFlatiron.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B2AmericanToFlatiron.count{
                appendText.append(String(B2AmericanToFlatiron[i]) + ", ")
                
            }
            busTimings.text = ("B2 Bus Timings: \(appendText). Distance: 4.8 miles. Time: 28 mins")
        }else if(searchCurrentLocation.text! == "Flatiron Building" && searchDestinationLocation.text! == "American Meuseum of Natural History"){
            let hourNumber = B1RFlatironToAmerican.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B1RFlatironToAmerican.count{
                appendText.append(String(B1RFlatironToAmerican[i] + 0.20) + "0, ")
                
            }
            busTimings.text = ("B2 Bus Timings: \(appendText). Distance: 6.1 miles. Time: 28 mins")
        }else if(searchCurrentLocation.text! == "American Meuseum of Natural History" && searchDestinationLocation.text! == "Madison Square Garden"){
            let hourNumber = B3AmericanToMadison.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B3AmericanToMadison.count{
                appendText.append(String(B3AmericanToMadison[i]) + "0, ")
                
            }
            busTimings.text = ("B3 Bus Timings: \(appendText). Distance: 4.2 miles. Time: 24 mins")
        }else if(searchCurrentLocation.text! == "Madison Square Garden" && searchDestinationLocation.text! == "American Meuseum of Natural History"){
            let hourNumber = B3RMadisonToAmerican.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B3RMadisonToAmerican.count{
                appendText.append(String(B3RMadisonToAmerican[i] + 0.30) + "0, ")
                
            }
            busTimings.text = ("B3 Bus Timings: \(appendText). Distance: 4.2 miles. Time: 24 mins")
        }else if(searchCurrentLocation.text! == "American Meuseum of Natural History" && searchDestinationLocation.text! == "Grant Central Terminal"){
            let hourNumber = B4AmericanGCT.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B4AmericanGCT.count{
                appendText.append(String(B4AmericanGCT[i]) + "0, ")
                
            }
            busTimings.text = ("B4 Bus Timings: \(appendText). Distance: 2.6 miles. Time: 28 mins")
            
        }else if(searchCurrentLocation.text! == "Grant Central Terminal" && searchDestinationLocation.text! == "American Meuseum of Natural History"){
            let hourNumber = B4RGCTAmerican.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B4RGCTAmerican.count{
                appendText.append(String(B4RGCTAmerican[i] + 0.35) + ", ")
                
            }
            busTimings.text = ("B4 Bus Timings: \(appendText). Distance: 4.2 miles. Time: 24 mins")
        }else if(searchCurrentLocation.text! == "South Ferry" && searchDestinationLocation.text! == "Times Square"){
            let hourNumber = B5SouthFerryToTS.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B5SouthFerryToTS.count{
                appendText.append(String(B5SouthFerryToTS[i]) + ", ")
                
            }
            busTimings.text = ("B5 Bus Timings: \(appendText). Distance: 5.8 miles. Time: 23 mins")
        }else if(searchCurrentLocation.text! == "Times Square" && searchDestinationLocation.text! == "South Ferry"){
            let hourNumber = B5RTSToSouthFerry.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B5RTSToSouthFerry.count{
                appendText.append(String(B5RTSToSouthFerry[i] + 0.3) + "0, ")
                
            }
            busTimings.text = ("B5 Bus Timings: \(appendText). Distance: 5.8 miles. Time: 23 mins")
        }else if(searchCurrentLocation.text! == "Columbus Circle" && searchDestinationLocation.text! == "The Rokefeller University"){
            let hourNumber = B6ColumbusToTRU.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B6ColumbusToTRU.count{
                appendText.append(String(B6ColumbusToTRU[i]) + ", ")
                
            }
            busTimings.text = ("B6 Bus Timings: \(appendText). Distance: 1.8 miles. Time: 24 mins")
        }else if(searchCurrentLocation.text! == "The Rokefeller University" && searchDestinationLocation.text! == "Columbus Circle"){
            let hourNumber = B6RTRUToColumbus.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B6RTRUToColumbus.count{
                appendText.append(String(B6RTRUToColumbus[i] + 0.15) + ", ")
                
            }
            busTimings.text = ("B6 Bus Timings: \(appendText). Distance: 1.8 miles. Time: 24 mins")
        }else if(searchCurrentLocation.text! == "Empire State Building" && searchDestinationLocation.text! == "The Rokefeller University"){
            let hourNumber = B7ESBToTRU.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B7ESBToTRU.count{
                appendText.append(String(B7ESBToTRU[i] + 0.15) + ", ")
                
            }
            busTimings.text = ("B7 Bus Timings: \(appendText). Distance: 2.6 miles. Time: 22 mins")
        }else if(searchCurrentLocation.text! == "The Rokefeller University" && searchDestinationLocation.text! == "Empire State Building"){
            let hourNumber = B7RTRUToESB.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B7RTRUToESB.count{
                appendText.append(String(B7RTRUToESB[i] + 0.45) + ", ")
                
            }
            busTimings.text = ("B7 Bus Timings: \(appendText). Distance: 2.6 miles. Time: 22 mins")
        }else if(searchCurrentLocation.text! == "Rockefellar Center" && searchDestinationLocation.text! == "Flatiron Building"){
            let hourNumber = B2AmericanToFlatiron.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B2AmericanToFlatiron.count{
                appendText.append(String(B2AmericanToFlatiron[i] + 0.15) + ", ")
                
            }
            busTimings.text = ("B2 Bus Timings: \(appendText). Distance: 1.4 miles. Time: 10 mins")
        }else if(searchCurrentLocation.text! == "Bryant Park" && searchDestinationLocation.text! == "Flatiron Building"){
            let hourNumber = B2AmericanToFlatiron.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B2AmericanToFlatiron.count{
                appendText.append(String(B2AmericanToFlatiron[i] + 0.20) + ", ")
                
            }
            busTimings.text = ("B2 Bus Timings: \(appendText). Distance: 1.0 miles. Time: 7 mins")
        }else if(searchCurrentLocation.text! == "Columbus Circle" && searchDestinationLocation.text! == "Times Square"){
            let hourNumber = B3AmericanToMadison.index(of: Double(hour))
            var appendText = String()
            
            for i in hourNumber!..<B3AmericanToMadison.count{
                appendText.append(String(B3AmericanToMadison[i] + 0.28) + ", ")
                
            }
            busTimings.text = ("B3 Bus Timings: \(appendText). Distance: 0.6 miles. Time: 7 mins")
        }


        
    
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let location = locations.last
        
        let center = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        customMap.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
        
        
        
        
    }
    
    func showRoute(_ response: MKDirectionsResponse) {
        
        for route in response.routes as [MKRoute] {
            
            customMap.add(route.polyline,
                        level: MKOverlayLevel.aboveRoads)
            for step in route.steps {
                print(step.instructions)
            }
        }
        let region = MKCoordinateRegionMakeWithDistance(
            setCurrentLocationCoordinates, 2000, 2000)
        
        customMap.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor
        overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error updating locations " + error.localizedDescription)
    }
    
    //when editing search bar make the table view visible
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        self.customTable.isHidden = false
    }
    
    //when you are done with editing hide the table view
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        self.customTable.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        //self.customTable.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    //function used to put filtered elements into a new array from old array.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredArrayList = allAgentNames.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            
            return range.location != NSNotFound
        })
        if(filteredArrayList.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.customTable.reloadData()
    }
    
    //function for table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //function for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredArrayList.count
        }
        return allAgentNames.count
    }
    
    //function for table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filteredArrayList[indexPath.row]
        } else {
            cell.textLabel?.text = allAgentNames[indexPath.row];
        }
        
        return cell

    }
    //function for table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedRow = String()
        
        if filteredArrayList.isEmpty == true {
            selectedRow = allAgentNames[indexPath.row]
            
                    }else{
                selectedRow = filteredArrayList[indexPath.row] as String
        }
        //select the table view text and put that in the search bar
        if searchCurrentLocation.isFirstResponder == true {
            searchCurrentLocation.text = selectedRow
            
        }else if searchDestinationLocation.isFirstResponder == true {
            searchDestinationLocation.text = selectedRow
            
        }
        
        self.customTable.isHidden = true
        self.searchCurrentLocation.resignFirstResponder()
        self.searchDestinationLocation.resignFirstResponder()
        filteredArrayList = allAgentNames
        
        
        
    }
    
    
}
