//
//  BoughtItem+CoreData.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/6/21.
//

import Foundation

extension BoughtItem {
  //  let groceryItem: GroceryItem
  //  var expirationDate: Date
  func convertToManagedObject() -> BoughtItemEntity {
    let boughtItemEntity = BoughtItemEntity(context: PersistenceController.shared.container.viewContext)
    boughtItemEntity.groceryItem = self.groceryItem
    boughtItemEntity.expirationDate = self.expirationDate
    return boughtItemEntity
  }
  
  init(boughtItemEntity: BoughtItemEntity) {
    self.groceryItem = BoughtItem(rawValue:boughtItemEntity.groceryItem!)!
  }
  
}
