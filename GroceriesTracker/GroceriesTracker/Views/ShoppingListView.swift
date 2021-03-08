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

