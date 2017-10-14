//
//  WebsiteData.swift
//  EarthquakerTrackerCodable
//
//  Created by Jon Olivet on 10/12/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import Foundation

struct WebsiteData: Codable {
  let features: [Features]
  struct Features: Codable {
    struct Properties: Codable {
      let mag: Double
      let place: String
    }
    struct Geometry: Codable {
      let coordinates: [Double]
    }
    let properties: Properties
    let geometry: Geometry
    let id: String
  }
}
