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
  @State var fridge: [BoughtItem]
  @State private var isAddSheetShowing = false
  var body: some View {
    NavigationView {
      VStack {
        List(fridge, id: \.groceryItem.name) { item in
          NavigationLink(destination: BoughtItemView(item: item), label: {
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
            AddFridgeItemView(fridge: $fridge)
        })
    }
  }
  
}
