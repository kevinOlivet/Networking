//
//  EarthquakeTableViewController.swift
//  EarthquakerTrackerCodable
//
//  Created by Jon Olivet on 8/30/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

class EarthquakeTableViewController: UITableViewController {
  
  fileprivate var earthquakeData = [WebsiteData.Features]()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = editButtonItem
    refreshControl?.addTarget(self, action: #selector(EarthquakeTableViewController.getMoreEarthquakes), for: .valueChanged)
    getMoreEarthquakes()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 140
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return earthquakeData.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let earthquakeObject = earthquakeData[indexPath.row]
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.text = "Place: \(earthquakeObject.properties.place)"
    cell.detailTextLabel?.text = "Magnitude: \(earthquakeObject.properties.mag)"
    return cell
  }
  
  // MARK: - Table view data delegate
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      earthquakeData.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let item = earthquakeData[sourceIndexPath.row]
    earthquakeData.remove(at: sourceIndexPath.row)
    earthquakeData.insert(item, at: destinationIndexPath.row)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showMap" {
      let indexPath = tableView.indexPathForSelectedRow
      let destination = segue.destination as! MapViewController
      destination.earthquakeArray = self.earthquakeData
      destination.earthquakeObject = self.earthquakeData[indexPath!.row]
    }
  }
  
  // MARK: - Actions
  @objc func getMoreEarthquakes() {
    DownloadManager.getEarthquakes { (earthquakeData: [WebsiteData.Features]?) in
      if let earthquakeData = earthquakeData {
      self.earthquakeData = earthquakeData
      }
      self.animateTable()
      if self.refreshControl?.isRefreshing == true {
        self.refreshControl?.endRefreshing()
      }
    }
  }
  
  func animateTable() {
    tableView.reloadData()
    let cells = tableView.visibleCells
    let tableViewHeight = tableView.bounds.size.height
    for cell in cells {
      cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
    }
    
    var delayCounter = 0
    for cell in cells {
      UIView.animate(withDuration: 1.0, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
        cell.transform = CGAffineTransform.identity
      })
      delayCounter += 1
    }
  }
  
}
