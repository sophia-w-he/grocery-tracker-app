//
//  PantryView.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/7/21.
//

import Foundation
import SwiftUI
import Combine

// TODO QTY STEPPER
struct CoreDataPantryView: View {
  @State var notificationCenter:UNUserNotificationCenter! = UNUserNotificationCenter.current()
  @State var notificationDelegate: UNUserNotificationCenterDelegate = NotificationDelegate()
  
  @FetchRequest(
    entity: GroceryItemEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \GroceryItemEntity.name, ascending: true),],
    predicate:  NSCompoundPredicate(andPredicateWithSubpredicates: [NSPredicate(format: "onShoppingList == false"), NSPredicate(format: "storageLocation == 'Pantry'")])
  ) var pantry: FetchedResults<GroceryItemEntity>
  
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
        List(pantry, id: \.name!, selection: $itemsToEdit) { item in
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
            Text("Pantry").font(.system(size: 25, design: .serif))
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
struct PantryView: View {
  @Binding var pantry: [BoughtItem]
  @State private var isAddSheetShowing = false
  var body: some View {
    NavigationView {
      VStack {
        List(pantry, id: \.groceryItem.name) { item in
          NavigationLink(destination: BoughtItemView(item: item), label: {
            GroceryItemRowView(item: item.groceryItem)
          })
        }
      }
      .navigationBarTitleDisplayMode(.inline)
       .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                  Spacer()
                  Text("Pantry").font(.system(size: 30, design: .serif))
                  Spacer()
                  Spacer()
                  
                }
            }
        }
        .navigationBarItems(trailing: Button("Add") {
            self.isAddSheetShowing.toggle()
        }).sheet(isPresented: self.$isAddSheetShowing, content: {
          AddStorageItemView(fridge: $pantry, isPresented: $isAddSheetShowing)
        })
    }
  }
  
}
