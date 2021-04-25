//
//  GroceryItemView.swift
//  GroceriesTracker
//
//  Created by Sophia on 3/4/21.
//

import Foundation
import SwiftUI

// TODO QTY STEPPER
struct GroceryItemCoreDataView: View {
  var item: GroceryItem
  var dataItem: GroceryItemEntity
  @State private var qty = 0
  @Environment(\.managedObjectContext) var context
  var expTime: String
  
  init(item: GroceryItem, dataItem: GroceryItemEntity) {
    self.item = item
    self.dataItem = dataItem
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
  
  @ViewBuilder func isHidden(_ shouldHide: Bool) -> some View {
      switch shouldHide {
      case true: self.hidden()
      case false: self
      }
  }
  
  var body: some View {
    
    VStack {
      HStack {
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 50.0,height:50.0);
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 50.0,height:50.0);
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 50.0,height:50.0);
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
            Text(String(qty)).font(.body).onAppear {
              qty = Int(self.dataItem.quantity)
            }
            Button(action: {
              self.dataItem.quantity += 1
              qty += 1
            }) {
              Image(systemName: "plus.circle")
            }
          }
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

// non core data view
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
  
  @ViewBuilder func isHidden(_ shouldHide: Bool) -> some View {
      switch shouldHide {
      case true: self.hidden()
      case false: self
      }
  }
  
  var body: some View {
    
    VStack {
      HStack {
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 50.0,height:50.0);
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 50.0,height:50.0);
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 50.0,height:50.0);
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
          Text(String(item.quantity)).font(.body)
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
