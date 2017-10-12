//
//  ViewController.swift
//  ParsingComplex
//
//  Created by Jon Olivet on 10/10/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let path = Bundle.main.path(forResource: "ComplexJSON", ofType: "txt") else { print("Error"); return }
    let url = URL(fileURLWithPath: path)
    
    do {
      let data = try Data(contentsOf: url)
      // Old way to do parse data
//      let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//      print(json)
      
      // New way to parse data
      let websiteData = try JSONDecoder().decode(WebsiteData.self, from: data)
      
      // Now I've got all the data and can use it any way I want
      print(websiteData.items.item.first?.batters.batter.first?.id ?? "id")
      print(websiteData.items.item.first?.batters.batter.first?.type ?? "type")
    } catch {
      print(error.localizedDescription)
    }
  }


}

