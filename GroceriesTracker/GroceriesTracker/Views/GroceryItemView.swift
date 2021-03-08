//
//  GroceryItemView.swift
//  GroceriesTracker
//
//  Created by Sophia on 3/4/21.
//

import Foundation
import SwiftUI

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
