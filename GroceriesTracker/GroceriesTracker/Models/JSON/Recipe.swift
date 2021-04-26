//
//  Recipe.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/24/21.
//

import Foundation

struct Recipe: Codable {
  
  let name: String                     // "apple"
  var imageName: String                // "apple.jpg"
  var recipeSteps: [String]            // recipe steps
  var ingredientNames: [String]            // ingred names

}
