//
//  MapViewController.swift
//  EarthquakeTracker
//
//  Created by Jon Olivet on 8/30/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
  
  var earthquakeObject: Earthquake!
  var earthquakeArray: [Earthquake]!
  
  @IBOutlet weak var mapView: MKMapView!
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    setAnnotations()
  }
  
  // MARK: - Actions
  func setAnnotations() {
    let location = CLLocationCoordinate2DMake(earthquakeObject.latitude, earthquakeObject.longitude)
    let span = MKCoordinateSpanMake(20.0, 20.0)
    let region = MKCoordinateRegionMake(location, span)
    mapView.region = region
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = location
    annotation.title = "ID: \(earthquakeObject.id)"
    annotation.subtitle = "Magnitude \(earthquakeObject.magnitude)"
    mapView.addAnnotation(annotation)
    mapView.selectAnnotation(annotation, animated: true)
    
    for earthquake in earthquakeArray {
      let location = CLLocationCoordinate2DMake(earthquake.latitude, earthquake.longitude)
      let annotation = MKPointAnnotation()
      annotation.coordinate = location
      annotation.title = "ID: \(earthquake.id)"
      annotation.subtitle = "Magnitude \(earthquake.magnitude)"
      mapView.addAnnotation(annotation)
    }
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PinAnnotation")
    pinAnnotation.animatesDrop = true
    pinAnnotation.canShowCallout = true
    pinAnnotation.pinTintColor = .blue
  
    return pinAnnotation
  }
  
}
