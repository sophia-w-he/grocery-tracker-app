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
  //var boughtItem: Bool                 // false
  var daysExpireTime: Int               // 0 days
  var weeksExpireTime : Int            // 0 weeks
  var monthsExpireTime: Int           // 1 month
  var yearsExpireTime: Int            // 0 years
  var storageLocation: StorageLocation // fridge
  var quantity: Int
  var expirationDate: Date?
  
  mutating func setExpirationDate() {
    let currentDate = Date()
    var dateComponent = DateComponents()
    dateComponent.month = self.monthsExpireTime
    dateComponent.day = self.daysExpireTime + (self.weeksExpireTime * 7)
    dateComponent.year = self.yearsExpireTime
    let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
    print(currentDate)
    print(futureDate!)
    self.expirationDate = futureDate!
  }

}
