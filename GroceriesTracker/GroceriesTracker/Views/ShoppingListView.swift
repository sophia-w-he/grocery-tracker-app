//
//  ShoppingListView.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/28/21.
//

import Foundation
import SwiftUI

struct ShoppingListView: View {
  var shoppingList: [GroceryItem]
  @State private var isAddSheetShowing = false
     
  
  var body: some View {
    NavigationView {
      List(shoppingList, id: \.name) { item in
        NavigationLink(destination: GroceryItemView(item: item), label: {
          GroceryItemRowView(item: item)
        })
      }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { // <2>
            ToolbarItem(placement: .principal) { // <3>
                VStack {
                  Spacer()
                  Text("Shopping List").font(.system(size: 30, design: .serif))
                  Spacer()
                  Spacer()
                  
                }
            }
        }
        .navigationBarItems(trailing: Button("Add") {
            self.isAddSheetShowing.toggle()
        }).sheet(isPresented: self.$isAddSheetShowing, content: {
              AddShoppingListItemView()
        })
    }
  }
}

struct GroceryItemView: View {
  var item: GroceryItem
  var body: some View {
    VStack {
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

struct AddShoppingListItemView: View {
  @State private var name: String = ""
  @State private var imageName: String = ""
  @State private var onShoppingList: Bool = true
  @State private var boughtItem: Bool = false
  @State private var daysExpireTime: Int = 0
  @State private var weeksExpireTime: Int = 0
  @State private var monthsExpireTime: Int = 0
  @State private var yearsExpireTime: Int = 0
  @State private var storageLocation: StorageLocation = .Fridge
  @State private var quantity: Int = 0
  
  @State private var itemSubmitted: Bool = false
  
  var storageList: [StorageLocation] = [.Fridge, .Pantry, .Freezer]
  
  @State private var storage = ""
       
  
  var body: some View {
    if !itemSubmitted {
      Text("Add Item").font(.system(size: 30, design: .serif))
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          Text("Item Name: ")
          Spacer()
          TextField("Item Name", text: $name)
            .textFieldStyle(RoundedBorderTextFieldStyle())
          Spacer(minLength: 50)
        }
        HStack {
          Text("Stored In: ")
          Menu {
            Button {
              storageLocation = .Fridge
              storage = "Fridge"
            } label: {
              Text("Fridge")
              //Image(systemName: "arrow.down.right.circle")
            }
            Button {
              storageLocation = .Freezer
              storage = "Freezer"
            } label: {
              Text("Freezer")
              //Image(systemName: "arrow.up.and.down.circle")
            }
            Button {
              storageLocation = .Pantry
              storage = "Pantry"
            } label: {
              Text("Pantry")
              //Image(systemName: "arrow.up.and.down.circle")
            }
          } label: {
            HStack {
              Image(systemName: "plus.circle")
              //TextField("Stored In", text: storage)
              //  .textFieldStyle(RoundedBorderTextFieldStyle())
              Text(storage)
            }
          }
          Spacer(minLength: 50)
        }
      }.padding(.horizontal, 20)
      Button(action: {
        // submit action
        self.itemSubmitted.toggle()
      }, label: { Text("Add") })
      
    } else {
      Text("test")
    }
  }
}

/*
 "name" : "banana",
 "imageName" : "banana.jpg",
 "onShoppingList" : true,
 "boughtItem" : false,
 "daysExpireTime" : 0,
 "weeksExpireTime" : 1,
 "monthsExpireTime" : 0,
 "yearsExpireTime" : 0,
 "storageLocation" : "Pantry",
 "quantity" : 5
 */
