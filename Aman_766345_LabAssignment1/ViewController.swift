//
//  ViewController.swift
//  Aman_766345_LabAssignment1
//
//  Created by MacStudent on 2020-01-14.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var address = ""
    @IBOutlet weak var RouteBtn: UIButton!
    let LocationManager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D!
    let request = MKDirections.Request()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
    LocationManager.delegate = self
        mapView.delegate = self
    LocationManager.desiredAccuracy = kCLLocationAccuracyBest
    LocationManager.requestWhenInUseAuthorization()
    LocationManager.startUpdatingLocation()
   
    let DoubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        DoubleTap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(DoubleTap)
        
        
        
       
}
    @IBAction func RouteBtn_Action(_ sender: Any) {
       show_Direction(destination: coordinate)
    }
    
   @objc func doubleTapped(gestureRecognizer: UIGestureRecognizer){
    if gestureRecognizer.state == .ended  {
    let t_Point = gestureRecognizer.location(in: mapView)
     coordinate = mapView.convert(t_Point, toCoordinateFrom: mapView)
    let annotation = MKPointAnnotation()
        
       CLGeocoder().reverseGeocodeLocation(CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: 0, timestamp: Date())) { (placemark, error) in
                                 
                        if let error = error{
                        print(error)
                        }else{
                                     
                        if let placemark = placemark?[0]{
                        self.address = ""
                        if placemark.name != nil{
                        self.address = placemark.name!
                                         }
                                     }
                                 }
                             }
                             
                        annotation.title = address
                        annotation.coordinate = coordinate
                        mapView.addAnnotation(annotation)
             
              
          }
        
//        annotation.coordinate = coordinate
//    annotation.title = "you double tapped this place"
//        mapView.addAnnotation(annotation)

    }
    func show_Direction(destination: CLLocationCoordinate2D){
        
    let sourceCoordinate = mapView.annotations[0].coordinate
    let destinationCoordinate = mapView.annotations[1].coordinate
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destinationPlacemark)
        
        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destItem
        request.transportType = .automobile
        
        let direction = MKDirections(request: request)
        direction.calculate {(respons , error) in
            
        guard let respons = respons else {
        if let error = error {
                    
                    print("Something went Wrong")
                }
                return
            }
            
            let route = respons.routes[0]
            print(route)
            self.mapView.addOverlay(route.polyline)
        }
         
       
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
             let rendrer = MKPolylineRenderer(overlay: overlay)
            rendrer.strokeColor = .orange
            rendrer.lineWidth = 5.0
            return rendrer
            }
        
        return MKOverlayRenderer()
    }
    
    
}
