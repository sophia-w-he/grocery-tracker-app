//
//  ContentView.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/24/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
  @State private var selection = 1
  @State var model: PersonalGroceryTrackerModel
  
  var body: some View {
    //JSONDataView(selection: $selection, model: $model)
    CoreDataView(selection: $selection, model: $model)
  }
}

struct JSONDataView: View {
  
  @Binding var selection: Int
  @Binding var model: PersonalGroceryTrackerModel
  
  @Binding var shoppingList: [GroceryItem]
  @Binding var fridge: [BoughtItem]
  @Binding var freezer: [BoughtItem]
  @Binding var pantry: [BoughtItem]
  
  init(selection: Binding<Int>, model: Binding<PersonalGroceryTrackerModel>) {
    self._selection = selection
    self._model = model
    
    self._shoppingList = model.myShoppingList
    self._fridge = model.myFridge
    self._freezer = model.myFreezer
    self._pantry = model.myPantry
  }
  
  var body: some View {
    
    TabView(selection: $selection) {
      ShoppingListView(shoppingList: $shoppingList, fridge: $fridge, freezer: $freezer, pantry: $pantry)
        .tabItem{ Text("Shopping List") }
        .tag(1)
      FridgeView(fridge: $fridge)
        .tabItem{ Text("Fridge") }
        .tag(2)
      FreezerView(freezer: $freezer)
        .tabItem{ Text("Freezer") }
        .tag(3)
      PantryView(pantry: $pantry)
        .tabItem{ Text("Pantry") }
        .tag(4)
    }
    
  }
  
}


struct CoreDataView: View {

  @Binding var selection: Int
  @Binding var model: PersonalGroceryTrackerModel
  @Binding var fridge: [BoughtItem]
  @Binding var freezer: [BoughtItem]
  @Binding var pantry: [BoughtItem]
  
  init(selection: Binding<Int>, model: Binding<PersonalGroceryTrackerModel>) {
    self._selection = selection
    self._model = model
    
    self._fridge = model.myFridge
    self._freezer = model.myFreezer
    self._pantry = model.myPantry
  }
  
  @Environment(\.managedObjectContext) var context
  
  @FetchRequest(
    entity: GroceryItemEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \GroceryItemEntity.name, ascending: true),
  ]) var shoppingList: FetchedResults<GroceryItemEntity>

  
  var body: some View {
    TabView(selection: $selection) {
      CoreDataShoppingListView(fridge: $fridge, freezer: $freezer, pantry: $pantry)
        .tabItem{ 
          Image(systemName: "cart");
          Text("Grocery List") }
        .tag(1)
      InventoryView(fridge: $fridge, freezer: $freezer, pantry: $pantry)
        .tabItem{Image(systemName: "list.number"); Text("Inventory") }
        .tag(2)
      RecipeListView()
        .tabItem{Image(systemName: "square.and.pencil"); Text("Recipes") }
        .tag(3)
      GroceryMapView()
        .tabItem{Image(systemName: "globe"); Text("Map") }
        .tag(4)
      /*CounterList()
        .tabItem{Image(systemName: "globe"); Text("Map") }
        .tag(5)*/
    }
  }
  
}

/*
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}*/
