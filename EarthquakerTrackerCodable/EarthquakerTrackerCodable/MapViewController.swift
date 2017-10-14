//
//  MapViewController.swift
//  EarthquakerTrackerCodable
//
//  Created by Jon Olivet on 8/30/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
  
  var earthquakeObject: WebsiteData.Features!
  var earthquakeArray: [WebsiteData.Features]!
  
  @IBOutlet weak var mapView: MKMapView!
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    setAnnotations()
  }
  
  // MARK: - Actions
  func setAnnotations() {
    let location = CLLocationCoordinate2DMake(earthquakeObject.geometry.coordinates[1], earthquakeObject.geometry.coordinates[0])
    let span = MKCoordinateSpanMake(20.0, 20.0)
    let region = MKCoordinateRegionMake(location, span)
    mapView.region = region
    
    let chosenEarthquakeAnnotation = MKPointAnnotation()
    chosenEarthquakeAnnotation.coordinate = location
    chosenEarthquakeAnnotation.title = earthquakeObject.properties.place
    chosenEarthquakeAnnotation.subtitle = "Magnitude: \(earthquakeObject.properties.mag)"
    mapView.addAnnotation(chosenEarthquakeAnnotation)
    mapView.selectAnnotation(chosenEarthquakeAnnotation, animated: true)
    
    for earthquake in earthquakeArray {
      let location = CLLocationCoordinate2DMake(earthquake.geometry.coordinates[1], earthquake.geometry.coordinates[0])
      let annotation = MKPointAnnotation()
      annotation.coordinate = location
      annotation.title = earthquake.properties.place
      annotation.subtitle = "Magnitude: \(earthquake.properties.mag)"
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
