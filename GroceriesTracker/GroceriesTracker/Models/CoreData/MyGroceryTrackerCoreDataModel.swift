//
//  MyGroceryTrackerCoreDataModel.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/6/21.
//

import Foundation
import SwiftUI
import CoreData

struct MyGroceryTrackerCoreDataModel: PersonalGroceryTrackerModel {
  
  //var testData = GroceryTrackerModelTestData()
  //var testModel = MyGroceryTrackerModel(myShoppingList: testData.myShoppingList!, myFridge: testData.myFridge!, myFreezer: testData.myFreezer!, myPantry: testData.myPantry!, myRecipes: testData.myRecipes!)
  
/*
  var myShoppingList: [GroceryItem] { return [] }
  
  var myFridge: [BoughtItem] { return [] }
  
  var myFreezer: [BoughtItem] { return [] }
  
  var myPantry: [BoughtItem] { return [] }
  
  var myRecipes: [Recipe] { return [] }
 */
  
  var myShoppingList: [GroceryItem]
  
  var myFridge: [BoughtItem]
  
  var myFreezer: [BoughtItem]
  
  var myPantry: [BoughtItem]
  
  var myRecipes: [Recipe]
  
  static var context = PersistenceController.shared.container.viewContext
  let testData = GroceryTrackerModelTestData()
  
  func emptyDB() {
    //TODO
    let groceryItemFetchRequest: NSFetchRequest<NSFetchRequestResult> = GroceryItemEntity.fetchRequest()
    let groceryItemDeleteRequest = NSBatchDeleteRequest(fetchRequest: groceryItemFetchRequest)
    
    do {
      try MyGroceryTrackerCoreDataModel.context.execute(groceryItemDeleteRequest)

    } catch let error as NSError {
      print("error during deletion \(error.localizedDescription)")
    }
  }
  
  func loadAllDatabaseData() {
    //TODO
    emptyDB()
    loadShoppingListFromJSON()
  }
  
  func loadShoppingListFromJSON() {
    guard let myShoppingList = testData.myShoppingList else {
      return print("Error loading shopping list")
    }
    
    myShoppingList.forEach({ item in _ = item.convertToManagedObject() })
    
    do {
      try MyGroceryTrackerCoreDataModel.context.save()
    } catch {
      print("Error saving item to core data \(error)")
    }
    
  }
  
  /// Returns a `GroceryItemEntity` for a given `name`
  /// - Parameter name: the name of the item
  /// - Returns: the optioanl `GroceryItemEntity` corresponding to that name
  static func getGroceryItemWith(name: String) -> GroceryItemEntity?
  {
    let request: NSFetchRequest<GroceryItemEntity> = GroceryItemEntity.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@", name)
    
    do {
      let courseClass = try MyGroceryTrackerCoreDataModel.context.fetch(request).first
      return courseClass
    } catch {
      print("fetch failed")
      return nil
    }
  }
  
}
