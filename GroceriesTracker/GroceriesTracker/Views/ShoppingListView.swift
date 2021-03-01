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
  
  var body: some View {
    NavigationView {
      List(shoppingList, id: \.name) { item in
        NavigationLink(destination: GroceryItemView(item: item), label: {
          GroceryItemRowView(item: item)
        }).navigationBarTitle("Shopping List")
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
      Text(item.name).font(.title)
    }
  }
  
}
