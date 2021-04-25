//
//  BoughtItemView.swift
//  GroceriesTracker
//
//  Created by Sophia on 3/20/21.
//

import Foundation
import SwiftUI

struct BoughtItemView: View {
  var item: BoughtItem
  var expDate: String
  
  init(item: BoughtItem) {
    self.item = item
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/YY"
    expDate = dateFormatter.string(from: item.expirationDate)
    print("expDate")
    print(expDate)
    
  }
  var body: some View {
    
    VStack {
      Image(item.groceryItem.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
      Spacer().frame(height: 20)
      HStack {
        Text(item.groceryItem.name).font(.title)
      }.padding(.bottom, 10)
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          Text("Stored In:").font(.body)
          Spacer()
          Text(item.groceryItem.storageLocation.rawValue).font(.body)
        }.padding(.bottom, 10)
        HStack {
          Text("Expires:").font(.body)
          Spacer()
          Text(expDate).font(.body)
        }.padding(.bottom, 10)
        
      }.padding(.horizontal, 20)
    }
  }
}


struct BoughtItemCoreDataView: View {
  var item: GroceryItem
  var dataItem: GroceryItemEntity
  var expDate: String = ""
  @State private var qty = 0
  @Environment(\.managedObjectContext) var context
  
  init(item: GroceryItem, dataItem: GroceryItemEntity) {
    self.item = item
    self.dataItem = dataItem
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/YY"
    self.expDate = dateFormatter.string(from: self.item.expirationDate!)
    print("expDate")
    print(expDate)
    
  }
  
  
  var body: some View {
    
    VStack {
      //Image(item.imageName)
      //  .resizable()
      //  .aspectRatio(contentMode: .fit)
      HStack {
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 60.0,height:60.0);
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 60.0,height:60.0);
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 60.0,height:60.0);
      }
      Spacer().frame(height: 20)
      HStack {
        Text(item.name).font(.system(size: 25, design: .serif))
      }.padding(.bottom, 10)
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          Text("Stored In:").font(.body)
          Spacer()
          Text(item.storageLocation.rawValue).font(.body)
        }.padding(.bottom, 10)
        HStack {
          Text("Quantity:").font(.body)
          Spacer()
          HStack{
            Button(action: {
              self.dataItem.quantity += 1
              qty += 1
            }) {
                Image(systemName: "plus.circle")
            }
            Text(String(qty)).font(.body).onAppear {
              qty = Int(self.dataItem.quantity)
          }
            Button(action: {
              if qty > 0 {
                self.dataItem.quantity -= 1
                qty -= 1
              }

              if qty == 0 {
                context.delete(dataItem)
              }
            }) {
                Image(systemName: "minus.circle")
            }
          }
        }.padding(.bottom, 10)
        HStack {
          Text("Expires:").font(.body)
          Spacer()
          Text(expDate).font(.body)
        }.padding(.bottom, 10)
        
      }.padding(.horizontal, 20)
    }
  }
}
