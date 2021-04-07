//
//  BoughtItem+CoreData.swift
//  GroceriesTracker
//
//

import Foundation

extension BoughtItem {
  //  let groceryItem: GroceryItem
  //  var expirationDate: Date
  func convertToManagedObject() -> BoughtItemEntity {
    let boughtItemEntity = BoughtItemEntity(context: PersistenceController.shared.container.viewContext)
    boughtItemEntity.groceryItem = nil
    boughtItemEntity.expirationDate = self.expirationDate
    return boughtItemEntity
  }
  
  init(boughtItemEntity: BoughtItemEntity) {
    self.groceryItem = GroceryItem(groceryItemEntity:boughtItemEntity.groceryItem!)
    self.expirationDate = boughtItemEntity.expirationDate!
  }
  
}
