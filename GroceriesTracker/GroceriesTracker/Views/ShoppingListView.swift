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
  @State var shoppingList: [GroceryItem]
  @State private var isAddSheetShowing = false
  
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
          List(shoppingList, id: \.name) { item in
            NavigationLink(destination: GroceryItemView(item: item), label: {
              GroceryItemRowView(item: item)
            })
          }
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
                      Text("Shopping List").font(.system(size: 30, design: .serif))
                      Spacer()
                      Spacer()
                      
                    }
                }
            }
            .navigationBarItems(trailing: Button("Add") {
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

struct GroceryItemView: View {
  var item: GroceryItem
  var expTime: String
  
  init(item: GroceryItem) {
    self.item = item
    expTime = ""
    if (item.daysExpireTime != 0) {
      expTime += String(item.daysExpireTime) + " day"
      if (item.daysExpireTime != 1) {
        expTime += "s"
      }
    }
    if (item.weeksExpireTime != 0) {
      expTime += " " + String(item.weeksExpireTime) + " week"
      if (item.weeksExpireTime != 1) {
        expTime += "s"
      }
    }
    if (item.monthsExpireTime != 0) {
      expTime += " " + String(item.monthsExpireTime) + " month"
      if (item.monthsExpireTime != 1) {
        expTime += "s"
      }
    }
    if (item.yearsExpireTime != 0) {
      expTime += " " + String(item.yearsExpireTime) + " years "
      if (item.yearsExpireTime != 1) {
        expTime += "s"
      }
    }
  }
  
  var body: some View {
    
    VStack {
      Image(item.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
      Spacer().frame(height: 20)
      HStack {
        Text(item.name).font(.title)
      }.padding(.bottom, 10)
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          Text("Stored In:").font(.body)
          Spacer()
          Text(item.storageLocation.rawValue).font(.body)
        }.padding(.bottom, 10)
        HStack {
          Text("Expires In:").font(.body)
          Spacer()
          Text(expTime).font(.body)
        }.padding(.bottom, 10)
        
      }.padding(.horizontal, 20)
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
  @Binding var shoppingList:[GroceryItem]
  
  @State private var name: String = ""
  @State private var imageName: String = ""
  @State private var onShoppingList: Bool = true
  @State private var boughtItem: Bool = false
  @State private var daysExpireTime: Int = 0
  @State private var weeksExpireTime: Int = 0
  @State private var monthsExpireTime: Int = 0
  @State private var yearsExpireTime: Int = 0
  @State private var storageLocation: StorageLocation = .Fridge
  @State private var quantity: String = "0"
  @State private var qtyExpire: String = "0"
  
  @State private var itemSubmitted: Bool = false
  
  var storageList: [StorageLocation] = [.Fridge, .Pantry, .Freezer]
  
  @State private var storage = ""
  @State private var timeDescriptor = ""
  
  var body: some View {
    if !itemSubmitted {
      ZStack {
        //RadialGradient(gradient: Gradient(colors: [.orange, .red]), center: .center, startRadius: 100, endRadius: 470)
        LinearGradient(gradient: Gradient(colors: [.blue, .white, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
        //AngularGradient(gradient: Gradient(colors: [.green, .blue, .black, .green, .blue, .black, .green]), center: .center)
        VStack {
          Text("Add Item").font(.system(size: 30, design: .serif)).fontWeight(.bold)
          HStack {
            VStack(alignment: .leading) {
              Text("Item Name: ").frame(maxHeight: .infinity).padding(.bottom, 4)
              Text("Quantity: ").frame(maxHeight: .infinity).padding(.bottom, 4)
              Text("Stored In: ").frame(maxHeight: .infinity).padding(.bottom, 4)
              Text("Expires In: ").frame(maxHeight: .infinity).padding(.bottom, 4)
              
            }
            VStack(alignment: .leading) {
              HStack {
                Spacer()
                TextField("Item Name", text: $name)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer(minLength: 25)
              }
              HStack {
                // TODO: Use picker for quantity
                Spacer()
                TextField("Quantity", text: $quantity)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .keyboardType(.numberPad)
                  .onReceive(Just(quantity)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.quantity = filtered
                        }
                }
                Spacer(minLength: 25)
              }
              HStack {
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
                    Spacer()
                    Image(systemName: "plus.circle")
                    Text(storage)
                  }
                }
                Spacer(minLength: 25)
              }
              HStack {
                // TODO: Use picker for expiration times
                Spacer()
                TextField("Qty", text: $qtyExpire)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .keyboardType(.numberPad)
                  .onReceive(Just(quantity)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.quantity = filtered
                        }
                }
                Menu {
                  Button {
                    weeksExpireTime = 0
                    monthsExpireTime = 0
                    yearsExpireTime = 0
                    daysExpireTime = Int(qtyExpire) ?? 0
                    if daysExpireTime == 1 {
                      timeDescriptor = "Day"
                    } else { timeDescriptor = "Days" }
                  } label: {
                    Text("Days")
                  }
                  Button {
                    daysExpireTime = 0
                    monthsExpireTime = 0
                    yearsExpireTime = 0
                    weeksExpireTime = Int(qtyExpire) ?? 0
                    if weeksExpireTime == 1 {
                      timeDescriptor = "Week"
                    } else { timeDescriptor = "Weeks" }
                  } label: {
                    Text("Weeks")
                  }
                  Button {
                    daysExpireTime = 0
                    weeksExpireTime = 0
                    yearsExpireTime = 0
                    monthsExpireTime = Int(qtyExpire) ?? 0
                    if monthsExpireTime == 1 {
                      timeDescriptor = "Month"
                    } else { timeDescriptor = "Months" }
                  } label: {
                    Text("Months")
                  }
                  Button {
                    daysExpireTime = 0
                    weeksExpireTime = 0
                    monthsExpireTime = 0
                    yearsExpireTime = Int(qtyExpire) ?? 0
                    if yearsExpireTime == 1 {
                      timeDescriptor = "Year"
                    } else { timeDescriptor = "Years" }
                  } label: {
                    Text("Years")
                  }
                } label: {
                  HStack {
                    Image(systemName: "plus.circle")
                    Text(timeDescriptor)
                  }
                }
                Spacer(minLength: 25)
              }
              HStack {
                // TODO: Upload image somehow
              }
              
            }.padding(.leading)
            
          }.padding(.horizontal)
          .fixedSize(horizontal: false, vertical: true)
          VStack {
            //Spacer(minLength: 5)
            Button(action: {
              // submit action
              self.itemSubmitted.toggle()
              let groc = GroceryItem(name: name, imageName: "", onShoppingList: onShoppingList, boughtItem: boughtItem, daysExpireTime: daysExpireTime, weeksExpireTime: weeksExpireTime, monthsExpireTime: monthsExpireTime, yearsExpireTime: yearsExpireTime, storageLocation: storageLocation, quantity: Int(quantity) ?? 0)
              shoppingList.append(groc)
            }, label: {
              Text("Add")
            })
          }.padding(.vertical)
          .fixedSize(horizontal: false, vertical: true)
        }
      }.edgesIgnoringSafeArea(.all)
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
