//
//  ViewController.swift
//  Aman_766345_LabAssignment1
//
//  Created by MacStudent on 2020-01-14.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var RouteBtn: UIButton!
    let LocationManager = CLLocationManager()
    
    let request = MKDirections.Request()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    LocationManager.delegate = self
    LocationManager.desiredAccuracy = kCLLocationAccuracyBest
    LocationManager.requestWhenInUseAuthorization()
    LocationManager.startUpdatingLocation()
    mapView.showsUserLocation = true
    let DoubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        DoubleTap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(DoubleTap)
       
}
   
   @objc func doubleTapped(gestureRecognizer: UIGestureRecognizer){
    let t_Point = gestureRecognizer.location(in: mapView)
    let coordinate = mapView.convert(t_Point, toCoordinateFrom: mapView)
    let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
    annotation.title = "you double tapped this place"
        mapView.addAnnotation(annotation)
}

}
