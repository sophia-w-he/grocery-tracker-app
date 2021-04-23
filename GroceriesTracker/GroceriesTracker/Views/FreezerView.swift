//
//  FreezerView.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/7/21.
//

import Foundation
import SwiftUI
import Combine

struct FreezerView: View {
  @Binding var freezer: [BoughtItem]
  @State private var isAddSheetShowing = false
  var body: some View {
    NavigationView {
      VStack {
        List(freezer, id: \.groceryItem.name) { item in
          NavigationLink(destination: BoughtItemView(item: item), label: {
            GroceryItemRowView(item: item.groceryItem)
          })
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      //.navigationTitle("Freezer")
        //.background(NavigationConfigurator { nc in
        //  nc.navigationBar.barTintColor = .blue
        //  nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        //})
       .toolbar {
            ToolbarItem(placement: .principal) { 
                VStack {
                  Spacer()
                  Text("Freezer").font(.system(size: 30, design: .serif))
                  Spacer()
                  Spacer()
                  
                }
            }
        }
        .navigationBarItems(trailing: Button("Add") {
            self.isAddSheetShowing.toggle()
        }).sheet(isPresented: self.$isAddSheetShowing, content: {
          AddStorageItemView(fridge: $freezer, isPresented: $isAddSheetShowing)
        })
    }
  }
  
}

