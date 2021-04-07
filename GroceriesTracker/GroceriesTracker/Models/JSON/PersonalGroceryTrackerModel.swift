//
//  PersonalGroceryTrackerModel.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/24/21.
//

import Foundation

protocol PersonalGroceryTrackerModel {
  var myShoppingList: [GroceryItem] { get set }
  var myFridge: [BoughtItem] { get set }
  var myFreezer: [BoughtItem] { get set }
  var myPantry: [BoughtItem] { get set }
  var myRecipes: [Recipe] { get set }
}
