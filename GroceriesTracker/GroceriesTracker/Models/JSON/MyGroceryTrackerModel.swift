//
//  MyGroceryTrackerModel.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/28/21.
//

import Foundation

struct MyGroceryTrackerModel: PersonalGroceryTrackerModel {
  
  static var designModel: MyGroceryTrackerModel = testModel
  
  var myShoppingList: [GroceryItem]
  var myFridge: [BoughtItem]
  var myFreezer: [BoughtItem]
  var myPantry: [BoughtItem]
  var myRecipes: [Recipe]
  
  mutating func addToFridge(bought: BoughtItem) { 
    myFridge.append(bought)
    /*if let index = myShoppingList.firstIndex(of: bought.groceryItem) {
        myShoppingList.remove(at: index)
    }*/
  } 

}

struct GroceryTrackerModelTestData {
  
  var myShoppingList: [GroceryItem]?
  var myFridge: [BoughtItem]?
  var myFreezer: [BoughtItem]?
  var myPantry: [BoughtItem]?
  var myRecipes: [Recipe]?
  
  init() {
    myShoppingList = decode([GroceryItem].self, from: "groceries.json")
    myFridge = []
    myFreezer = []
    myPantry = []
    myRecipes = decode([Recipe].self, from: "recipes.json")
  }
  
  // JSONDecoder documentation on apple.com used to create this method
  // DecodingError documentation on apple.com used for error handling
  func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
    
    guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
      fatalError("Failed to locate \(file).")
    }
    
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Failed to load \(file).")
    }
    
    let decoder = JSONDecoder()
    
    do {
      return try decoder.decode(T.self, from: data)
    } catch DecodingError.dataCorrupted(let context) {
      fatalError("ERROR: Decode \(file) failed, invalid JSON or corrupted file – \(context.debugDescription)")
    } catch DecodingError.keyNotFound(let key, let context) {
      fatalError("ERROR: Decode \(file) failed, Key '\(key.stringValue)' not found – \(context.debugDescription)")
    } catch DecodingError.typeMismatch(_, let context) {
      fatalError("ERROR: Decode \(file) failed, type mismatch – \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let value, let context) {
      fatalError("ERROR: Decode \(file) failed, Value \(value) not found – \(context.debugDescription)")
    } catch {
      fatalError("ERROR: Decode \(file) failed: \(error)")
    }
  }
}


var testData = GroceryTrackerModelTestData()
var testModel = MyGroceryTrackerModel(myShoppingList: testData.myShoppingList!, myFridge: testData.myFridge!, myFreezer: testData.myFreezer!, myPantry: testData.myPantry!, myRecipes: testData.myRecipes!)

