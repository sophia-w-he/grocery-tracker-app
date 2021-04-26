//
//  BoughtItem.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/28/21.
//

import Foundation

// struct used in non-core data views
// initializes an expiration date based on grocery item expiration time
struct BoughtItem {
  
  let groceryItem: GroceryItem
  var expirationDate: Date
  
  init(groceryItem: GroceryItem) {
    self.groceryItem = groceryItem
    
    let currentDate = Date()
    var dateComponent = DateComponents()
    dateComponent.month = groceryItem.monthsExpireTime
    dateComponent.day = groceryItem.daysExpireTime + (groceryItem.weeksExpireTime * 7)
    dateComponent.year = groceryItem.yearsExpireTime
    let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
    print(currentDate)
    print(futureDate!)
    self.expirationDate = futureDate!
  }

}
