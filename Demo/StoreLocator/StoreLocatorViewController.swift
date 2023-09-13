//
//  StoreLocatorViewController.swift
//  Demo
//
//  Created by Neosoft on 13/09/23.
//

import UIKit
import MapKit

class StoreLocatorViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            tableView.register(UINib(nibName: "StoreLocatorTableViewCell", bundle: nil), forCellReuseIdentifier: "StoreLocatorTableViewCell")
        }
    }
    var storeArray = [
      "Shop No 6 , Crowford Market, Mumbai, India","Phoenix Marketcity, Bengaluru, India","Orion Mall, Bangalore, India","DLF Mall of India, Uttar Pradesh, India"]
    var locArr = [ (CLLocationCoordinate2D(latitude: 18.948366 , longitude: 72.825935)), (CLLocationCoordinate2D(latitude: 12.995854, longitude: 77.696350)), (CLLocationCoordinate2D(latitude: 13.011053, longitude: 77.554939)), (CLLocationCoordinate2D(latitude: 28.567190, longitude: 77.320892)) ]

    override func viewDidLoad() {
        super.viewDidLoad()
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629)
        mapView.addAnnotation(annotation)
        
//        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//        mapView.setRegion(region, animated: true)
        //18.948366    72.825935
        //12.995854, 77.696350.
        //13.011053, 77.554939.
        //28.567190, 77.320892.
    }
   
}
extension StoreLocatorViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreLocatorTableViewCell", for: indexPath) as! StoreLocatorTableViewCell
        cell.name.text = storeArray[indexPath.row]
//        LocationManger.sharedLocationManager.findLocations(with: storeArray, coordinates: locArr) { location in
//                self.locationArray = location
//                print("the current location is(location)")
//            }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
