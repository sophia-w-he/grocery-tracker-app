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
        }).navigationBarTitle("Shopping List")
        .navigationBarItems(trailing: Button("Add Item") {
          self.isAddSheetShowing.toggle()
        }).sheet(isPresented: self.$isAddSheetShowing, content: {
          AddShoppingListItemView()
        })
      }
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
      Image(item.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
      Text(item.name).font(.system(size: 25, design: .serif))
    }
  }
  
}

struct AddShoppingListItemView: View {
  @State private var name: String = ""
  @State private var imageName: String = ""
  @State private var onShoppingList: Bool = true
  @State private var boughtItem: Bool = false
  @State private var expirationTime: String = ""
  @State private var storageLocation: StorageLocation = .Fridge
  @State private var quantity: Int = 0
  
  @State private var itemSubmitted: Bool = false
  
  var body: some View {
    if !itemSubmitted {
      VStack {
        Text("Add Item")
          .font(.title)
        HStack {
          Spacer(minLength: 50)
          TextField("Item Name", text: $name)
            .textFieldStyle(RoundedBorderTextFieldStyle())
          Spacer(minLength: 50)
        }
        Button(action: {
          // submit action
          self.itemSubmitted.toggle()
        }, label: { Text("Add") })
        
      }
    } else {
      Text("test")
    }
  }
}
