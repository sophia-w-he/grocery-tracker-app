//
//  PlaceListView.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/22/21.
//

import Foundation
import SwiftUI
import MapKit

// TODO:
// change text to white text
// change font to match app font
struct PlaceListView: View {
  
  let landmarks: [Landmark]
  var onTap: () -> ()
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("See Nearby Locations")
      }.frame(width: UIScreen.main.bounds.size.width, height: 60)
      .background(Color.gray)
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
