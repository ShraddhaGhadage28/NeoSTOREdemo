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
   
    let stores = [
        Store(title:"GrandHighStreet Mall" , subTitle: "Shop No 6 , Crowford Market, Mumbai, India", coordinate: CLLocationCoordinate2D(latitude: 18.948366, longitude: 72.825935)),
        Store(title:"Phoenix Store", subTitle: "Phoenix Marketcity, Bengaluru, India", coordinate: CLLocationCoordinate2D(latitude: 12.995854, longitude: 77.696350)),
        Store(title:"Sigma Park" , subTitle: "Orion Mall, Bangalore, India", coordinate: CLLocationCoordinate2D(latitude: 13.011053, longitude: 77.554939)),
        Store(title:"UP Store" , subTitle: "DLF Mall of India, Uttar Pradesh, India", coordinate: CLLocationCoordinate2D(latitude: 28.567190, longitude: 77.320892))
    ]
    var annotation : MKPointAnnotation?
    override func viewDidLoad() {
        super.viewDidLoad()
        annotation = MKPointAnnotation()
//        annotation?.coordinate = CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629)
//        annotation?.coordinate = CLLocationCoordinate2D(latitude: 18.948366, longitude: 72.825935)
//        annotation?.coordinate = CLLocationCoordinate2D(latitude: 12.995854, longitude: 77.696350)
//        annotation?.coordinate = CLLocationCoordinate2D(latitude: 13.011053, longitude: 77.554939)
//        annotation?.coordinate = CLLocationCoordinate2D(latitude: 28.567190, longitude: 77.320892)
        for location in stores {
                mapView.addAnnotation(location)
            }
        
       // mapView.addAnnotation(annotation!)
        
//        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//        mapView.setRegion(region, animated: true)
        //18.948366    72.825935
        //12.995854, 77.696350.
        //13.011053, 77.554939.
        //28.567190, 77.320892.
    }
   
}
class Store: NSObject, MKAnnotation {
    let title: String?
    let subTitle: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String,subTitle:String,coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subTitle = subTitle
        self.coordinate = coordinate
        super.init()
    }
}
extension StoreLocatorViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreLocatorTableViewCell", for: indexPath) as! StoreLocatorTableViewCell
        cell.name.text = stores[indexPath.row].title
        cell.subname.text = stores[indexPath.row].subTitle
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        annotation?.coordinate = stores[indexPath.row].coordinate
        mapView.addAnnotation(annotation!)
        
    }
}
