//
//  ShoppingListView.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/28/21.
//

import Foundation
import SwiftUI
import Combine

struct ShoppingListView: View {
  @Binding var shoppingList: [GroceryItem]
  
  @Binding var fridge: [BoughtItem]
  @Binding var freezer: [BoughtItem]
  @Binding var pantry: [BoughtItem]
  
  @State private var isAddSheetShowing = false
  @State private var itemsToAdd = Set<String>()
  @State var isEditMode: EditMode = .active
  
  @State var isEditing = false
  @State var selection = Set<String>()
  
  // TODO CHANGE THIS FOR CORE DATA
  var dataModel = testModel
  
  /*init() {
    self.shoppingList = shoppingList
    UINavigationBar.appearance().backgroundColor = .systemPink

    UINavigationBar.appearance().largeTitleTextAttributes = [
        .foregroundColor: UIColor.white,
        .font : UIFont(name:"Helvetica Neue", size: 40)!]

  }*/
  
  var body: some View {
    NavigationView {
      ZStack {
        RadialGradient(gradient: Gradient(colors: [.orange, .red]), center: .center, startRadius: 100, endRadius: 470)
        VStack {
          List(shoppingList, id: \.name, selection: $itemsToAdd) { item in
            NavigationLink(destination: GroceryItemView(item: item), label: {
              GroceryItemRowView(item: item)
            })
          }
          //.environment(\.editMode, self.$isEditMode)
          .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
          .navigationBarTitleDisplayMode(.inline)
          //.navigationTitle("Shopping List")
            //.background(NavigationConfigurator { nc in
            //  nc.navigationBar.barTintColor = .blue
            //  nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
            //})
            .toolbar { // <2>
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                      Spacer()
                      Text("Shopping List").font(.system(size: 25, design: .serif))
                      Spacer()
                      Spacer()
                      
                    }
                }
            }
          .navigationBarItems(leading:
                                Button(isEditing ? "Check Off" : "Edit") {
                                  if !isEditing {
                                    self.isEditing.toggle()
                                  }else {
                                    itemsToAdd.forEach(){ item in
                                      print(itemsToAdd)
                                      // TODO CHANGE THIS FOR CORE DATA
                                      let grocIndex = shoppingList.firstIndex(where: { $0.name ==  item})
                                      let groc = shoppingList[grocIndex!]
                                      let bought = BoughtItem(groceryItem: groc)
                                      if groc.storageLocation == .Fridge {
                                        fridge.append(bought)
                                      } else if groc.storageLocation == .Freezer {
                                        freezer.append(bought)
                                      } else if groc.storageLocation == .Pantry {
                                        pantry.append(bought)
                                      }
                              
                                      shoppingList.remove(at:grocIndex!)
                                      let itemIndex = itemsToAdd.firstIndex(of: item)
                                      itemsToAdd.remove(at:itemIndex!)
                                      
                                      
                                      //dataModel.assignStudent(student: username, toCourseClass: selectedClass)
                                    }
                                    self.isEditing.toggle()
                                  }
                                },
                              trailing: Button("Add Item") {
                self.isAddSheetShowing.toggle()
            }).sheet(isPresented: self.$isAddSheetShowing, content: {
              AddShoppingListItemView(shoppingList: $shoppingList)
            })
        }
        
      }.edgesIgnoringSafeArea(.all)
    }
  }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}


struct GroceryItemRowView: View {
  
  var item: GroceryItem
  
  var body: some View {
    HStack {
      //Image(item.imageName)
      //  .resizable()
      //  .aspectRatio(contentMode: .fit)
      Text(item.name).font(.system(size: 25, design: .serif))
    }
  }
  
}



struct CoreDataShoppingListView: View {
  //@Binding var shoppingList: [GroceryItem]
  
  @Binding var fridge: [BoughtItem]
  @Binding var freezer: [BoughtItem]
  @Binding var pantry: [BoughtItem]
  
  @Environment(\.managedObjectContext) var context
  @FetchRequest(
    entity: GroceryItemEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \GroceryItemEntity.name, ascending: true),],
    predicate:  NSPredicate(format: "onShoppingList == true")
  ) var shoppingList: FetchedResults<GroceryItemEntity>
  
  @State private var isAddSheetShowing = false
  @State private var itemsToAdd = Set<String>()
  @State var isEditMode: EditMode = .active
  
  @State var isEditing = false
  @State var selection = Set<String>()
  
  // TODO CHANGE THIS FOR CORE DATA
  // var dataModel = MyGroceryTrackerCoreDataModel()
  
  var body: some View {
    NavigationView {
      ZStack {
        RadialGradient(gradient: Gradient(colors: [.orange, .red]), center: .center, startRadius: 100, endRadius: 470)
        VStack {
          List(shoppingList, id: \.name!, selection: $itemsToAdd) { item in
            let grocItem = GroceryItem(groceryItemEntity: MyGroceryTrackerCoreDataModel.getGroceryItemWith(name: item.name!)!)
            NavigationLink(destination: GroceryItemView(item: grocItem), label: {
              GroceryItemRowView(item: grocItem)
            })
          }
          .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
          .navigationBarTitleDisplayMode(.inline)
            .toolbar { // <2>
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                      Spacer()
                      Text("Shopping List").font(.system(size: 25, design: .serif))
                      Spacer()
                      Spacer()
                      
                    }
                }
            }
          .navigationBarItems(leading:
                                Button(isEditing ? "Check Off" : "Edit") {
                                  if !isEditing {
                                    self.isEditing.toggle()
                                  }else {
                                    itemsToAdd.forEach(){ item in
                                      print(itemsToAdd)
                                      // TODO CHANGE THIS FOR CORE DATA
                                      let grocIndex = shoppingList.firstIndex(where: { $0.name! ==  item})
                                      let groc = shoppingList[grocIndex!]
                                      print(groc)
                                      let grocItem = GroceryItem(groceryItemEntity: MyGroceryTrackerCoreDataModel.getGroceryItemWith(name: groc.name!)!)
                                      let bought = BoughtItem(groceryItem: grocItem)
                                      /*print(bought)
                                      bought.convertToManagedObject()*/
                                      
                                      do {
                                        try MyGroceryTrackerCoreDataModel.context.save()
                                      } catch {
                                        print("Error saving item to core data \(error)")
                                      }
                                      
                                      if grocItem.storageLocation == .Fridge {
                                        fridge.append(bought)
                                      } else if grocItem.storageLocation == .Freezer {
                                        freezer.append(bought)
                                      } else if grocItem.storageLocation == .Pantry {
                                        pantry.append(bought)
                                      }
                              
                                      //shoppingList.remove(at:grocIndex!)
                                      groc.onShoppingList = false
                                      do {
                                        try MyGroceryTrackerCoreDataModel.context.save()
                                      } catch {
                                        print("Error saving item to core data \(error)")
                                      }
                                      
                                      let itemIndex = itemsToAdd.firstIndex(of: item)
                                      itemsToAdd.remove(at:itemIndex!)
                                    }
                                    self.isEditing.toggle()
                                    
                                  }
                                },
            trailing: Button("Add Item") {
                self.isAddSheetShowing.toggle()
            }).sheet(isPresented: self.$isAddSheetShowing, content: {
              AddShoppingListItemCoreDataView()
            })
        }
        
      }.edgesIgnoringSafeArea(.all)
    }
  }
}
