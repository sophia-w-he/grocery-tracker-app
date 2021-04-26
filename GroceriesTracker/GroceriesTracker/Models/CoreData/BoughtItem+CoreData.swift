//
//  BoughtItem+CoreData.swift
//  GroceriesTracker
//
//

import Foundation
import CoreData

// core data bought item not used
// expiry date initialized with internal grocery item function
extension BoughtItem {
  //  let groceryItem: GroceryItem
  //  var expirationDate: Date
  func convertToManagedObject() -> BoughtItemEntity {
    let boughtItemEntity = BoughtItemEntity(context: PersistenceController.shared.container.viewContext)
    //BoughtItem.getGroceryItemWith(name: self.groceryItem.name)?.boughtItem = boughtItemEntity
    boughtItemEntity.groceryItem = nil //BoughtItem.getGroceryItemWith(name: self.groceryItem.name)
    boughtItemEntity.expirationDate = self.expirationDate
    return boughtItemEntity
  }
  
  init(boughtItemEntity: BoughtItemEntity) {
    print(boughtItemEntity.groceryItem!)
    self.groceryItem = GroceryItem(groceryItemEntity: boughtItemEntity.groceryItem!)
    self.expirationDate = boughtItemEntity.expirationDate!
  }
  
  /// Returns a `GroceryItemEntity` for a given `name`
  /// - Parameter name: the name of the item
  /// - Returns: the optioanl `GroceryItemEntity` corresponding to that name
  static func getGroceryItemWith(name: String) -> GroceryItemEntity?
  {
    let request: NSFetchRequest<GroceryItemEntity> = GroceryItemEntity.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@", name)
    
    do {
      let grocItem = try MyGroceryTrackerCoreDataModel.context.fetch(request).first
      return grocItem
    } catch {
      print("fetch failed")
      return nil
    }
  }
  
  
}
