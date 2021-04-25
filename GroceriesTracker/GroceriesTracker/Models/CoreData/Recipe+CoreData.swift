//
//  Recipe+CoreData.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/6/21.
//

import Foundation

/*
 struct Recipe: Codable {
   let name: String                     // "apple"
   var imageName: String                // "apple.jpg"
   var ingredients: [GroceryItem]
   var recipeSteps: [String]            // recipe steps
 }
 */
extension Recipe {
  func convertToManagedObject() -> RecipeEntity {
    let recipeEntity = RecipeEntity(context: PersistenceController.shared.container.viewContext)
    recipeEntity.name = self.name
    recipeEntity.imageName = self.imageName
    recipeEntity.ingredients = NSSet()
    recipeEntity.recipeSteps = self.recipeSteps
    recipeEntity.ingredientNames = self.ingredientNames
    return recipeEntity
    
  }
  
  init(recipeEntity: RecipeEntity) {
    self.name = recipeEntity.name!
    self.imageName = recipeEntity.imageName!
    self.ingredients = []
    var tempIngredients: [GroceryItem] = []
    for item in recipeEntity.ingredients!.allObjects as! [GroceryItemEntity] {
      
      let grocItem = GroceryItem(groceryItemEntity: item)
      tempIngredients.append(grocItem)
    }
    self.ingredients = tempIngredients
    
    self.recipeSteps = recipeEntity.recipeSteps!
    self.ingredientNames = recipeEntity.ingredientNames!
    
  }
  
}
