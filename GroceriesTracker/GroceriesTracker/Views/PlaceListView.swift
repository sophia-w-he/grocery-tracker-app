//
//  PlaceListView.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/22/21.
//  Followed tutorial at https://www.youtube.com/watch?v=WTzBKOe7MmU

import Foundation
import SwiftUI
import MapKit

// shows places found via map search
struct PlaceListView: View {
  
  let landmarks: [Landmark]
  var onTap: () -> ()
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("See Nearby Locations").font(.system(size: 20, design: .serif))
      }.frame(width: UIScreen.main.bounds.size.width, height: 60)
      .foregroundColor(Color.black)
      .background(Color(red: 144 / 255, green: 238 / 255, blue: 144 / 255))
      .gesture(TapGesture()
                .onEnded(self.onTap)
      )
      
      List {
        ForEach(self.landmarks, id: \.id) { landmark in
          VStack(alignment: .leading) {
            Text(landmark.name)
              .fontWeight(.bold)
            Text(landmark.title)
          }
        }
        
      }.animation(nil)
      
    }.cornerRadius(10)
  }
}

struct PlaceListView_Previews: PreviewProvider {
  static var previews: some View {
    PlaceListView(landmarks: [Landmark(placemark: MKPlacemark())], onTap: {})
  }
}
