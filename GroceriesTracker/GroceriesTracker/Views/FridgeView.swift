//
//  FridgeView.swift
//  GroceriesTracker
//
//  Created by Sophia on 3/20/21.
//

import Foundation
import SwiftUI
import Combine

// Shows fridge contents
struct CoreDataFridgeView: View {
  
  @State var notificationCenter:UNUserNotificationCenter! = UNUserNotificationCenter.current()
  @State var notificationDelegate: UNUserNotificationCenterDelegate = NotificationDelegate()
  @FetchRequest(
    entity: GroceryItemEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \GroceryItemEntity.name, ascending: true),],
    predicate:  NSCompoundPredicate(andPredicateWithSubpredicates: [NSPredicate(format: "onShoppingList == false"), NSPredicate(format: "storageLocation == 'Fridge'")])
  ) var fridge: FetchedResults<GroceryItemEntity>
  
  @Environment(\.managedObjectContext) var context
  @FetchRequest(
    entity: GroceryItemEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \GroceryItemEntity.name, ascending: true),
    ]) var shoppingList: FetchedResults<GroceryItemEntity>
  
  @State private var isAddSheetShowing = false
  @State private var itemsToEdit = Set<String>()
  @State var isEditMode: EditMode = .active
  
  @State var isEditing = false
  @State var selection = Set<String>()
  
  var body: some View {
    NavigationView {
      VStack {
        List(fridge, id: \.name!, selection: $itemsToEdit) { item in
          let grocItem = GroceryItem(groceryItemEntity: MyGroceryTrackerCoreDataModel.getInventoryItemWith(name: item.name!)!)
          NavigationLink(destination: BoughtItemCoreDataView(item: (grocItem), dataItem: item), label: {
            GroceryItemCoreDataRowView(item: grocItem, dataItem: item)
          })
        }
      }
      .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          VStack {
            Spacer()
            Text("Fridge").font(.system(size: 25, design: .serif))
            Spacer()
            Spacer()
            
          }.foregroundColor(.black)
        }
      }
      .navigationBarItems(leading:
                            Button(isEditing ? "Remove" : "Edit") {
                              if !isEditing {
                                self.isEditing.toggle()
                              }else {
                                itemsToEdit.forEach(){ item in
                                  print(itemsToEdit)
                                  
                                  let grocIndex = shoppingList.firstIndex(where: { $0.name! ==  item})
                                  let groc = shoppingList[grocIndex!]
                                  
                                  context.delete(groc)
                                  let itemIndex = itemsToEdit.firstIndex(of: item)
                                  itemsToEdit.remove(at:itemIndex!)
                                  
                                }
                                self.isEditing.toggle()
                                
                                
                                
                              }
                            },
                          trailing: Button(isEditing ? "Cancel" : "Add") {
                            if !isEditing {
                              self.isAddSheetShowing.toggle()
                            } else {
                              self.isEditing.toggle()
                            }
                          }).sheet(isPresented: self.$isAddSheetShowing, content: {
                            AddStorageItemCoreDataView(isPresented: $isAddSheetShowing, notificationCenter: $notificationCenter, notificationDelegate: $notificationDelegate)
                            
                          })
      
      
    }
  }
  
}

// non core data view
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
