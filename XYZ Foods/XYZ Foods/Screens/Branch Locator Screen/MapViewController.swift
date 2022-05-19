//
//  MapViewController.swift
//  XYZ Foods
//
//  Created by Malisha on 12/7/20.
//

import CoreLocation
import UIKit
import MapKit

struct HotelDDes: Decodable {
    let hotels : [HotelD]
    
}

struct HotelD: Decodable {
    let id : String?
    let description : String?
}


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayHotelBranchesInMapKit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        super.viewDidAppear(animated)
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            render(_location: location)
        }
    }
    
    func render(_location : CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude:  _location.coordinate.latitude+2.2, longitude: _location.coordinate.longitude+0.3)
        
        let span = MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    
    func  displayHotelBranchesInMapKit() {
        guard let url = baseUrl else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{

                let jsonResponse = try JSONSerialization.jsonObject(with:
                                       dataResponse, options: [])
            
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                      return
                }
                
                print(jsonArray)
                
                var finalArray:[Any] = []
                
                 for locv in jsonArray {
                    if let dict = locv as? [String : String], let peopleArray = dict["id"] as? [String] {
                        finalArray.append(peopleArray)
                    }
                    
                 }

                // print(finalArray)
           
                guard let title1 = jsonArray[0]["id"] as? String else { return }
                guard let latitude1 = jsonArray[0]["latitude"] as? Double else { return }
                guard let longitude1 = jsonArray[0]["longitude"] as? Double else { return }
                
                guard let title2 = jsonArray[1]["id"] as? String else { return }
                guard let latitude2 = jsonArray[1]["latitude"] as? Double else { return }
                guard let longitude2 = jsonArray[1]["longitude"] as? Double else { return }
                
                guard let title3 = jsonArray[2]["id"] as? String else { return }
                guard let latitude3 = jsonArray[2]["latitude"] as? Double else { return }
                guard let longitude3 = jsonArray[2]["longitude"] as? Double else { return }
            
                guard let title4 = jsonArray[3]["id"] as? String else { return }
                guard let latitude4 = jsonArray[3]["latitude"] as? Double else { return }
                guard let longitude4 = jsonArray[3]["longitude"] as? Double else { return }
                
                guard let title5 = jsonArray[4]["id"] as? String else { return }
                guard let latitude5 = jsonArray[4]["latitude"] as? Double else { return }
                guard let longitude5 = jsonArray[4]["longitude"] as? Double else { return }
                
                guard let title6 = jsonArray[5]["id"] as? String else { return }
                guard let latitude6 = jsonArray[5]["latitude"] as? Double else { return }
                guard let longitude6 = jsonArray[5]["longitude"] as? Double else { return }
                
             
                
               let locations = [["title":title1, "latitude" : latitude1 , "longitude" : longitude1],
                                 ["title":title2, "latitude" : latitude2 , "longitude" : longitude2],
                                 ["title":title3, "latitude" : latitude3 , "longitude" : longitude3],
                                 ["title":title4, "latitude" : latitude4 , "longitude" : longitude4],
                                 ["title":title5, "latitude" : latitude5 , "longitude" : longitude5],
                                 ["title":title6, "latitude" : latitude6 , "longitude" : longitude6],
                                 
               ]
                
                for location in locations {
                    
                    let anotation  = MKPointAnnotation()
                    
                    anotation.title = location["title"] as? String
         
                    let loc = CLLocationCoordinate2D(latitude : location["latitude"] as! Double, longitude : location["longitude"] as! Double )
                     
                    anotation.coordinate = loc
                    self.mapView.addAnnotation(anotation)
                    
                }
                
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        
    
    }
    
    

}
