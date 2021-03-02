//
//  BoughtItem.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/28/21.
//

import Foundation

struct BoughtItem: Codable {
  
  let groceryItem: GroceryItem
  let expirationDate: Date
  let quantity: Int

}
