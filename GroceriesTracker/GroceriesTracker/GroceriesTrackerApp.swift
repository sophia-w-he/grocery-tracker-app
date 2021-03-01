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

    var body: some Scene {
        WindowGroup {
            ContentView(model: MyGroceryTrackerModel.designModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
