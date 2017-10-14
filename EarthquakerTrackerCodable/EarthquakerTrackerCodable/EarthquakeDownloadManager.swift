//
//  EarthquakeDownloadManager.swift
//  EarthquakerTrackerCodable
//
//  Created by Jon Olivet on 8/30/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import Foundation

struct DownloadManager {
  private init(){}
  
  static let url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson"
  
  static func getEarthquakes (completion: @escaping ([WebsiteData.Features]?) -> ()) {
    var earthquakeArray:[WebsiteData.Features] = []
    
    let request = URLRequest(url: URL(string: url)!)
    
    URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
      guard error == nil else {
        print(error!.localizedDescription); return }
      guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        print("statusCode mishap: \(String(describing: (response as? HTTPURLResponse)?.statusCode))"); return }
      guard let data = data else { print("data mishap"); return }
      
      do {
        let websiteInformation = try JSONDecoder().decode(WebsiteData.self, from: data)
        earthquakeArray = websiteInformation.features
      } catch {
        print(error.localizedDescription)
      }
      DispatchQueue.main.async {
        completion(earthquakeArray)
      }
    }.resume()
  }
  
}
