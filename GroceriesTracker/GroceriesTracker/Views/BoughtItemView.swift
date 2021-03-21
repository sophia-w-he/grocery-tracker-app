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
