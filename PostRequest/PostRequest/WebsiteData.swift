//
//  WebsiteData.swift
//  PostRequest
//
//  Created by Jon Olivet on 10/13/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import Foundation

struct WebsiteData: Codable {
  let id: Int
  let name: String
  let username: String
  let email: String
  let address: Address
  struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    struct Geo: Codable {
      let lat: String
      let lng: String
    }
  }
  let phone: String
  let website: String
  let company: Company
  struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
  }
}
