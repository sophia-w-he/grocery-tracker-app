//
//  InventoryView.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/24/21.
//

import Foundation
import SwiftUI

struct InventoryView: View {
  @Binding var fridge: [BoughtItem]
  @Binding var freezer: [BoughtItem]
  @Binding var pantry: [BoughtItem]
  @State private var selection = 1
  var body: some View {
    VStack {
      NotificationView()
      TabView(selection: $selection) {
        CoreDataFridgeView()
          .tabItem{ //Image("fridge-icon");
            Image(systemName: "thermometer");
            Text("Fridge") }
          .tag(1)
        CoreDataFreezerView()
          .tabItem{ Image(systemName: "snow");Text("Freezer") }
          .tag(2)
        CoreDataPantryView()
          .tabItem{Image(systemName: "table"); Text("Pantry") }
          .tag(3)
        /*FridgeView(fridge: $fridge)
          .tabItem{ //Image("fridge-icon");
            Image(systemName: "thermometer");
            Text("Fridge") }
          .tag(2)
        FreezerView(freezer: $freezer)
          .tabItem{ Image(systemName: "snow");Text("Freezer") }
          .tag(2)
        PantryView(pantry: $pantry)
          .tabItem{Image(systemName: "table"); Text("Pantry") }
          .tag(3)*/

      }
      //TopTabView()
      Spacer()
    }
  }
  
}

struct TopTabView: View {
    
    @State var selectedTab = Tabs.FirstTab
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "thermometer")
                    .foregroundColor(selectedTab == .FirstTab ? Color.blue : Color.gray)
                    Text("Fridge")
                }
                .onTapGesture {
                    self.selectedTab = .FirstTab
                }
                Spacer()
                VStack {
                    Image(systemName: "snow")
                        .foregroundColor(selectedTab == .SecondTab ? Color.blue : Color.gray)
                    Text("Freezer")
                }
                .onTapGesture {
                    self.selectedTab = .SecondTab
                }
                Spacer()
                VStack {
                    Image(systemName: "table")
                        .foregroundColor(selectedTab == .ThirdTab ? Color.blue : Color.gray)
                    Text("Pantry")
                }
                .onTapGesture {
                    self.selectedTab = .ThirdTab
                }
                Spacer()
            }
            .padding(.bottom)
            .background(Color.green.edgesIgnoringSafeArea(.all))
            
            Spacer()
            
            if selectedTab == .FirstTab {
                FirstTabView()
            } else if selectedTab == .SecondTab {
                SecondTabView()
            } else {
                ThirdTabView()
            }
        }
    }
}

struct FirstTabView : View {
    
    var body : some View {
        VStack {
            Text("FIRST TAB VIEW")
        }
    }
}

struct SecondTabView : View {
    
    var body : some View {
        Text("SECOND TAB VIEW")
    }
}

struct ThirdTabView : View {
    
    var body : some View {
        Text("THIRD TAB VIEW")
    }
}

enum Tabs {
    case FirstTab
    case SecondTab
    case ThirdTab
}
