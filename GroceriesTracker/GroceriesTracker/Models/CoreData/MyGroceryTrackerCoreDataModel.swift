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
  var myShoppingList: [GroceryItem]
  
  var myFridge: [BoughtItem]
  
  var myFreezer: [BoughtItem]
  
  var myPantry: [BoughtItem]
  
  var myRecipes: [Recipe]
  
  /*var myShoppingList: [GroceryItem]
  
  var myFridge: [BoughtItem]
  
  var myFreezer: [BoughtItem]
  
  var myPantry: [BoughtItem]
  
  var myRecipes: [Recipe]*/
  
  /*var myShoppingList: [GroceryItem] { return [] }
  
  var myFridge: [BoughtItem] { return [] }
  
  var myFreezer: [BoughtItem] { return [] }
  
  var myPantry: [BoughtItem] { return [] }
  
  var myRecipes: [Recipe] { return [] }*/
  
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
}
