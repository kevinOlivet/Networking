//
//  ViewController.swift
//  PostRequest
//
//  Created by Jon Olivet on 10/13/17.
//  Copyright © 2017 Jon Olivet. All rights reserved.
//

import UIKit

enum Which {
  case parameters
  case partModel
  case wholeModel
}

class ViewController: UIViewController {
  
  // Use to choose from the enum Which for different effects
  let type: Which = .partModel
  
  // Use "parameters" with JSONSerialization for simple json uploading.
  let parameters = ["username": "@kevin_olivet", "tweet": "HelloWorld"]
  
  // Uploading part of the object
  let partModel = WebsiteData.Company(name: "John's computers", catchPhrase: "There's no computer to big.", bs: "We love swift!")
  
  // Uploading the whole object!
  let wholeModel = WebsiteData(id: 3, name: "Kevin", username: "kevinbaby", email: "baby@yahoo.com",
                               address: WebsiteData.Address(street: "555 Broadway", suite: "342", city: "San Diego", zipcode: "432432",
                                                            geo: WebsiteData.Address.Geo(lat: "5445353", lng: "890809")),
                               phone: "0980980", website: "www.yeah.com",
                               company: WebsiteData.Company(name: "Kev's Company", catchPhrase: "Well hello there!", bs: "This is all there is."))
  
  // MARK: - Actions
  @IBAction func getTapped(_ sender: UIButton) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
    
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, error) in
      if let response = response {
        print(response)
      }
      
      if let data = data {
        print(data)
        do {
          let websiteInfoArray = try JSONDecoder().decode([WebsiteData].self, from: data)
          for websiteInfo in websiteInfoArray {
            print(websiteInfo.name)
          }
        } catch {
          print(error.localizedDescription)
        }
      }
      }.resume()
  }
  
  @IBAction func postTapped(_ sender: UIButton) {
    
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
      switch type {
      case .parameters:
        // If using "parameters" use JSONSerialization.data
        let httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = httpBody
      case .partModel:
        // Or just part of the object
        let httpBody = try JSONEncoder().encode(partModel)
        request.httpBody = httpBody
      case .wholeModel:
        // With encode I can encode the entire model object
        let httpBody = try JSONEncoder().encode(wholeModel)
        request.httpBody = httpBody
      }
    } catch {
      print(error.localizedDescription)
    }
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let response = response {
        print(response)
      }
      
      if let data = data {
        do {
          switch self.type {
          case .parameters:
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
          case .partModel:
            let json = try JSONDecoder().decode(WebsiteData.Company.self, from: data)
            print(json)
          case .wholeModel:
            let json = try JSONDecoder().decode(WebsiteData.self, from: data)
            print(json)
          }
        } catch {
          print(error.localizedDescription)
        }
      }
      }.resume()
  }
  
}
