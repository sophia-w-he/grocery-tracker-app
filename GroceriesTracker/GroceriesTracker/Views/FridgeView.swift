//
//  FridgeView.swift
//  GroceriesTracker
//
//  Created by Sophia on 3/20/21.
//

import Foundation
import SwiftUI
import Combine

struct FridgeView: View {
  @Binding var fridge: [BoughtItem]
  @State private var isAddSheetShowing = false
  var body: some View {
    NavigationView {
      VStack {
        List(fridge, id: \.groceryItem.name) { item in
          NavigationLink(destination: BoughtItemView(item: item), label: {
            //EmptyView()
            GroceryItemRowView(item: item.groceryItem)
          })
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      //.navigationTitle("Fridge")
        //.background(NavigationConfigurator { nc in
        //  nc.navigationBar.barTintColor = .blue
        //  nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        //})
       .toolbar {
            ToolbarItem(placement: .principal) { 
                VStack {
                  Spacer()
                  Text("Fridge").font(.system(size: 30, design: .serif))
                  Spacer()
                  Spacer()
                  
                }
            }
        }
        .navigationBarItems(trailing: Button("Add") {
            self.isAddSheetShowing.toggle()
        }).sheet(isPresented: self.$isAddSheetShowing, content: {
          AddStorageItemView(fridge: $fridge, isPresented: $isAddSheetShowing)
        })
    }
  }
  
}


struct CoreDataFridgeView: View {
  // FIX THIS
  @FetchRequest(
    entity: BoughtItemEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \BoughtItemEntity.expirationDate, ascending: true),]
    //,predicate: NSPredicate(format: "SUBQUERY(groceryItem, $groceryItem, $groceryItem.storageLocation == 'Fridge').@count > 0")
    //predicate:  NSPredicate(format: "item.storageLocation == %@", "Fridge")
  ) var fridge: FetchedResults<BoughtItemEntity>
  
  @Environment(\.managedObjectContext) var context
  @FetchRequest(
    entity: GroceryItemEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \GroceryItemEntity.name, ascending: true),
  ]) var shoppingList: FetchedResults<GroceryItemEntity>
  
  @State private var isAddSheetShowing = false
  var body: some View {
    NavigationView {
      VStack {
        /*List(fridge, id: \.groceryItem.name) { item in
          NavigationLink(destination: BoughtItemView(item: item), label: {
            GroceryItemRowView(item: item.groceryItem)
          })
        }*/
        
        List(fridge, id: \.expirationDate!) { item in
          Text("ygjbjbjh")
          /*let grocItem = GroceryItem(groceryItemEntity: MyGroceryTrackerCoreDataModel.getGroceryItemWith(name: item.name!)!)
          NavigationLink(destination: GroceryItemView(item: grocItem), label: {
            GroceryItemRowView(item: grocItem)
          })*/
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      //.navigationTitle("Fridge")
        //.background(NavigationConfigurator { nc in
        //  nc.navigationBar.barTintColor = .blue
        //  nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        //})
       .toolbar { // <2>
            ToolbarItem(placement: .principal) { // <3>
                VStack {
                  Spacer()
                  Text("Fridge").font(.system(size: 30, design: .serif))
                  Spacer()
                  Spacer()
                  
                }
            }
        }
        .navigationBarItems(trailing: Button("Add") {
            self.isAddSheetShowing.toggle()
        }).sheet(isPresented: self.$isAddSheetShowing, content: {
            //AddFridgeItemView(fridge: $fridge)
        })
    }
  }
  
}
