//
//  Item.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/24/21.
//

import Foundation

struct GroceryItem: Codable {
  
  var name: String                     // "apple"
  var imageName: String                // "apple.jpg"
  var onShoppingList: Bool             // true
  var boughtItem: Bool                 // false
  var expirationTime: String           // 1 month
  var storageLocation: StorageLocation // fridge
  var quantity: Int

}
