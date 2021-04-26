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
  
  static var context = PersistenceController.shared.container.viewContext
  let testData = GroceryTrackerModelTestData()
  
  func emptyDB() {

    let groceryItemFetchRequest: NSFetchRequest<NSFetchRequestResult> = GroceryItemEntity.fetchRequest()
    let groceryItemDeleteRequest = NSBatchDeleteRequest(fetchRequest: groceryItemFetchRequest)
    
    let recipeFetchRequest: NSFetchRequest<NSFetchRequestResult> = RecipeEntity.fetchRequest()
    let recipeDeleteRequest = NSBatchDeleteRequest(fetchRequest: recipeFetchRequest)
    
    let boughtItemFetchRequest: NSFetchRequest<NSFetchRequestResult> = BoughtItemEntity.fetchRequest()
    let boughtItemDeleteRequest = NSBatchDeleteRequest(fetchRequest: boughtItemFetchRequest)
    
    do {
      try MyGroceryTrackerCoreDataModel.context.execute(groceryItemDeleteRequest)
      try MyGroceryTrackerCoreDataModel.context.execute(recipeDeleteRequest)
      try MyGroceryTrackerCoreDataModel.context.execute(boughtItemDeleteRequest)
      
    } catch let error as NSError {
      print("error during deletion \(error.localizedDescription)")
    }
  }
  
  func loadAllDatabaseData() {
    emptyDB()
    loadShoppingListFromJSON()
    loadRecipesFromJSON() 
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
  
  func loadRecipesFromJSON() {
    guard let myRecipes = testData.myRecipes else {
      return print("Error loading recipes")
    }
    
    myRecipes.forEach({ item in _ = item.convertToManagedObject() })
    print(myRecipes)
    
    do {
      try MyGroceryTrackerCoreDataModel.context.save()
    } catch {
      print("Error saving item to core data \(error)")
    }
    
  }
  
  /// Returns a `GroceryItemEntity` for a given `name`that is on the shopping list
  /// - Parameter name: the name of the item
  /// - Returns: the optioanl `GroceryItemEntity` corresponding to that name
  static func getGroceryItemWith(name: String) -> GroceryItemEntity?
  {
    let request: NSFetchRequest<GroceryItemEntity> = GroceryItemEntity.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@ AND onShoppingList = true", name)
    
    do {
      let groc = try MyGroceryTrackerCoreDataModel.context.fetch(request).first
      return groc
    } catch {
      print("fetch failed")
      return nil
    }
  }
  
  
  /// Returns a `Recipe` for a given `name`
  /// - Parameter name: the name of the item
  /// - Returns: the optioanl `RecipeEntity` corresponding to that name
  static func getRecipeWith(name: String) -> RecipeEntity?
  {
    let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@", name)
    
    do {
      let recipe = try MyGroceryTrackerCoreDataModel.context.fetch(request).first
      return recipe
    } catch {
      print("fetch failed")
      return nil
    }
  }
  
  
  /// Returns a `GroceryItemEntity` for a given `name`that is in inventory/bought
  /// - Parameter name: the name of the item
  /// - Returns: the optioanl `GroceryItemEntity` corresponding to that name
  static func getInventoryItemWith(name: String) -> GroceryItemEntity?
  {
    let request: NSFetchRequest<GroceryItemEntity> = GroceryItemEntity.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@ AND onShoppingList = false", name)
    
    do {
      let courseClass = try MyGroceryTrackerCoreDataModel.context.fetch(request).first
      return courseClass
    } catch {
      print("fetch failed")
      return nil
    }
  }

}
