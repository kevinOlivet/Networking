//
//  EarthquakeDownloadManager.swift
//  EarthquakeTracker
//
//  Created by Jon Olivet on 8/30/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import Foundation

struct DownloadManager {
  private init(){}
  static let url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson"
  
  static func getEarthquakes (completion: @escaping ([Earthquake]?) -> ()) {
    var earthquakeArray:[Earthquake] = []
    
    let request = URLRequest(url: URL(string: url)!)
    
    URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
      guard error == nil else {
        print(error!.localizedDescription); return }
      guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        print("statusCode mishap: \(String(describing: (response as? HTTPURLResponse)?.statusCode))"); return }
      guard let data = data else { print("data mishap"); return }
      
      do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
          print("json mishap"); return }
        guard let features = json["features"] as? [[String:Any]] else {
          print("features mishap"); return }
        
        for feature in features {
          guard let id = feature["id"] as? String else {
            print("id mishap"); return }
          
          guard let properties = feature["properties"] as? [String:Any] else {
            print("properties mishap"); return }
          
          guard let mag = properties["mag"] as? Double else {
            print("mag mishap"); return }
          
          guard let geometries = feature["geometry"] as? [String:Any] else {
            print("geometries mishap"); return }
          
          guard let coordinates = geometries["coordinates"] as? [Any] else {
            print("coordinates mishap"); return }
          
          guard let longitude = coordinates[0] as? Double else {
            print("longitude mishap"); return }
          
          guard let latitude = coordinates[1] as? Double else {
            print("latitude mishap"); return }
          
          let earthquakeObject = Earthquake(id: id, magnitude: mag, longitude: longitude, latitude: latitude)
          earthquakeArray.append(earthquakeObject)
        }
      }catch {
        print(error.localizedDescription)
      }
      DispatchQueue.main.async {
        completion(earthquakeArray)
      }
    }.resume()
  }
  
}
