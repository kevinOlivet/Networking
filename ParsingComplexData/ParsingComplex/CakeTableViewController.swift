//
//  CakeTableViewController.swift
//  ParsingComplex
//
//  Created by Jon Olivet on 10/12/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

class CakeTableViewController: UITableViewController {
  
  var cakeInfo: WebsiteData!
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    getCakeInfo()
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return cakeInfo.items.item.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cakeInfo.items.item[section].batters.batter.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let cake = cakeInfo.items.item[indexPath.section].batters.batter[indexPath.row]
    cell.textLabel?.text = "Type: \(cake.type)"
    cell.detailTextLabel?.text = "Id: \(cake.id)"
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return cakeInfo.items.item[section].name
  }
  
  // MARK: - Actions
  func getCakeInfo(){
    guard let path = Bundle.main.path(forResource: "ComplexJSON", ofType: "txt") else { print("Error"); return }
    let url = URL(fileURLWithPath: path)
    
    do {
      let data = try Data(contentsOf: url)
      // Old way to do parse data
      //      let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
      //      print(json)
      
      // New way to parse data
      cakeInfo = try JSONDecoder().decode(WebsiteData.self, from: data)
      
      for parsedData in cakeInfo.items.item {
        for batter in parsedData.batters.batter {
          print("Batter: \(batter.type), Id: \(batter.id)")
        }
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
}
