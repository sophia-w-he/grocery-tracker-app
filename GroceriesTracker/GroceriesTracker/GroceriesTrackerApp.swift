//
//  GroceriesTrackerApp.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/24/21.
//

import SwiftUI

@main
struct GroceriesTrackerApp: App {
  let persistenceController = PersistenceController.shared
  let dataModel = MyGroceryTrackerCoreDataModel(myShoppingList: [], myFridge: [], myFreezer: [], myPantry: [], myRecipes: [])
  
  init() {
    dataModel.loadAllDatabaseData()
  }
  
  var body: some Scene {
    WindowGroup {
      // non coredata content view commented out
      /*ContentView(model: MyGroceryTrackerModel.designModel)
       .environment(\.managedObjectContext, persistenceController.container.viewContext)*/
      ContentView(model: dataModel)
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
      
    }
  }
}
