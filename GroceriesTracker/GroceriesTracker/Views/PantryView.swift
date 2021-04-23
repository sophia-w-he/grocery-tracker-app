//
//  PantryView.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/7/21.
//

import Foundation
import SwiftUI
import Combine

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
      //.navigationTitle("Pantry")
        //.background(NavigationConfigurator { nc in
        //  nc.navigationBar.barTintColor = .blue
        //  nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        //})
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
