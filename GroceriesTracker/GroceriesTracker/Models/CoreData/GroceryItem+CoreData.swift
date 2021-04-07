//
//  GroceryItem+CoreData.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/6/21.
//

import Foundation
import UIKit
/*
 struct GroceryItem: Codable {
   
   var name: String                     // "apple"
   var imageName: String                // "apple.jpg"
   var daysExpireTime: Int               // 0 days
   var weeksExpireTime : Int            // 0 weeks
   var monthsExpireTime: Int           // 1 month
   var yearsExpireTime: Int            // 0 years
   var storageLocation: StorageLocation // fridge
   var quantity: Int

 }
 */
extension GroceryItem {
  func convertToManagedObject() -> GroceryItemEntity {
    let groceryItemEntity = GroceryItemEntity(context: PersistenceController.shared.container.viewContext)
    groceryItemEntity.name = self.name
    groceryItemEntity.imageName = self.imageName
    groceryItemEntity.daysExpireTime = Int32(self.daysExpireTime)
    groceryItemEntity.weeksExpireTime = Int32(self.weeksExpireTime)
    groceryItemEntity.monthsExpireTime = Int32(self.monthsExpireTime)
    groceryItemEntity.yearsExpireTime = Int32(self.yearsExpireTime)
    groceryItemEntity.storageLocation = self.storageLocation.rawValue
    groceryItemEntity.quantity = Int32(self.quantity)
    return groceryItemEntity
  }
  
  init(groceryItemEntity: GroceryItemEntity) {
    self.name = groceryItemEntity.name!
    self.imageName = groceryItemEntity.imageName!
    self.daysExpireTime = Int(groceryItemEntity.daysExpireTime)
    self.weeksExpireTime = Int(groceryItemEntity.weeksExpireTime)
    self.monthsExpireTime = Int(groceryItemEntity.monthsExpireTime)
    self.yearsExpireTime = Int(groceryItemEntity.yearsExpireTime)
    self.storageLocation = StorageLocation(rawValue: groceryItemEntity.storageLocation!)!
    self.quantity = Int(groceryItemEntity.quantity)
  }
  
}
