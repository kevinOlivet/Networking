//
//  WebsiteData.swift
//  ParsingComplex
//
//  Created by Jon Olivet on 10/12/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import Foundation

struct WebsiteData: Codable {
  let items: Item
  struct Item: Codable {
    let item: [ItemInfo]
    struct ItemInfo: Codable {
      let id: String
      let type: String
      let name: String
      let ppu: Double
      let batters: Batter
      struct Batter: Codable {
        let batter: [BatterInfo]
        struct BatterInfo: Codable {
          let id: String
          let type: String
        }
      }
      let topping: [Topping]
      struct Topping: Codable {
        let id: String
        let type: String
      }
    }
  }
}
