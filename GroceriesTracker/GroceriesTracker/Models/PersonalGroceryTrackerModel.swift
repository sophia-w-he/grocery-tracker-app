//
//  PersonalGroceryTrackerModel.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/24/21.
//

import Foundation

protocol PersonalGroceryTrackerModel {
  var myShoppingList: [GroceryItem] { get }
  var myFridge: [BoughtItem] { get }
  var myFreezer: [BoughtItem] { get }
  var myPantry: [BoughtItem] { get }
  var myRecipes: [Recipe] { get }
}
