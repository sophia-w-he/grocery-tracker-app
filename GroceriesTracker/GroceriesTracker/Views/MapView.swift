//
//  MapView.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/22/21.
//

import Foundation
/*import SwiftUI
import MapKit
import CoreLocation
import Combine*/


import SwiftUI
import MapKit
import UIKit


class Coordinator: NSObject, MKMapViewDelegate {
    
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                    
                }
            }
        }
        
    }
}

struct MapView: UIViewRepresentable {
    
    let landmarks: [Landmark]
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        //
        updateAnnotations(from: uiView)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.landmarks.map(LandmarkAnnotation.init)
        mapView.addAnnotations(annotations)
    }
    
}

struct Landmark {
    
    let placemark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }

    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}

final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}


class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
    }
    
}


/*struct GrocMapView: View {
  @State private var isMapShowing = false
  @State private var region: [CLLocationCoordinate2D] = []
  @State private var storeLocations: [StoreLocation] = []
  
  var body: some View {
    Text("test")
    .navigationBarTitle("TEST")
    .navigationBarItems(trailing: Button("Map") {
      self.geocode()
    })
    .sheet(isPresented: self.$isMapShowing)
    {
      MapViewView(studentLocations: self.$storeLocations)
          
    }
  }
  
  func geocode() {
    let addresses = ["City, State"]
    let geocoder = CLGeocoder()
    
    let operationQueue = OperationQueue()
    var operations: [Operation] = []
    
    // create an operation for processing the response for each address
    addresses.forEach { address in
      let geocodeOperation = BlockOperation {
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            // Process Response
          self.processResponse(withPlacemarks: placemarks, error: error)
        }
        sleep(1)
      }
      // append to operations list
      operations.append(geocodeOperation)
    }
        
    // create dependencies so operations are processed in order of students list
    for index in stride(from: (operations.count - 1), to: 0, by: -1) {
      operations[index].addDependency(operations[index - 1])
    }
    
    operations[operations.count - 1].completionBlock = {
      print("Final Regions Coordinates List", self.region)
      
      // Create the student locations for map view
      for i in 0...(addresses.count - 1) {
        let coordinate = region[i]
        let storeName = ""//courseClass.students[i].name
        let storeAddress = ""//courseClass.students[i].address
        
        let storeLocation = StoreLocation(title: storeName, locationName: storeAddress, coordinate: CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude))
        
        storeLocations.append(storeLocation)
      }
      
      self.isMapShowing.toggle()
    }
    
    for i in 0...(operations.count - 1) {
      operationQueue.addOperation(operations[i])
    }
    
  }
  
  func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
      if let error = error {
          print("Unable to Forward Geocode Address (\(error))")

      } else {
          var location: CLLocation?

          if let placemarks = placemarks, placemarks.count > 0 {
              location = placemarks.first?.location
          }

          if let location = location {
            let coordinate = location.coordinate
            let mkCoord = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            self.region.append(mkCoord)
            print("Student's Region: ", self.region)
          } else {
              print("Unable to set region")
          }
      }
  }
}


class StoreLocation: NSObject, MKAnnotation
{
  var title: String?
  var locationName: String!
  var coordinate: CLLocationCoordinate2D
  
  init(title: String, locationName: String, coordinate: CLLocationCoordinate2D)
  {
    self.title = title
    self.locationName = locationName
    self.coordinate = coordinate
    super.init()
  }
}

struct MapViewView: View {
  @Environment(\.presentationMode) var presentation
  @Binding var studentLocations: [StoreLocation]
  
  var body: some View {
    return NavigationView {
      MapView(studentLocations: self.$studentLocations)
        .navigationTitle("Student Locations")
        .navigationBarItems(trailing: Button("Dismiss")
        {
          self.presentation.wrappedValue.dismiss()
        })
    }
  }
  
}

struct MapView: UIViewRepresentable {
  @Binding var studentLocations: [StoreLocation]
  
  var map = MKMapView(frame: .zero)
  func makeCoordinator() -> Coordinator {
    return Coordinator(mapView: self)
  }
  
  func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
    map.delegate = context.coordinator
    
    // Center of the US
    let coordinate = CLLocationCoordinate2D(latitude: 39.8283, longitude: -98.5795)
    
    studentLocations.forEach { loc in
      map.addAnnotation(loc)
    }
  
    // Span to fit entire US on phone screen
    let span = MKCoordinateSpan(latitudeDelta: 75, longitudeDelta: 75)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    map.setRegion(region, animated: true)
    
    return map
  }
  
  
  func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
  }
}

class Coordinator: NSObject, MKMapViewDelegate {
  var mapView: MapView!
  let regionRadius:CLLocationDistance = 1000.0
  init(mapView: MapView) {
    super.init()
    self.mapView = mapView
  }
  //mkannotationview
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
  {
    guard let annotation = annotation as? StoreLocation else { return nil }
    
    let identifier = "pin"
    var view: MKPinAnnotationView
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        as? MKPinAnnotationView
    {
      dequeuedView.annotation = annotation
      view = dequeuedView
    }
    else
    {
      view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
    
  }
  //rendering paths
  func showRoute(response: MKDirections.Response)
  {
    for route in response.routes
    {
      mapView.map.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
    }
  }
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
  {
    if overlay is MKPolyline
    {
      let path = MKPolylineRenderer(overlay: overlay);
      path.strokeColor = UIColor.red.withAlphaComponent(0.5);
      path.lineWidth = 5;
      return path;
    }
    return MKOverlayRenderer()
  }
}*/
