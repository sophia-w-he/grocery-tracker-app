//
//  FridgeView.swift
//  GroceriesTracker
//
//  Created by Sophia on 3/20/21.
//

import Foundation
import SwiftUI
import Combine
import UserNotifications

struct FridgeView: View {
  @Binding var fridge: [BoughtItem]
  @State private var isAddSheetShowing = false
  var body: some View {
    NavigationView {
      VStack {
        List(fridge, id: \.groceryItem.name) { item in
          NavigationLink(destination: BoughtItemView(item: item), label: {
            GroceryItemRowView(item: item.groceryItem)
          })
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      //.navigationTitle("Fridge")
        //.background(NavigationConfigurator { nc in
        //  nc.navigationBar.barTintColor = .blue
        //  nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        //})
       .toolbar { // <2>
            ToolbarItem(placement: .principal) { // <3>
                VStack {
                  Spacer()
                  Text("Fridge").font(.system(size: 30, design: .serif))
                  Spacer()
                  Spacer()
                  
                }
            }
        }
        .navigationBarItems(trailing: Button("Add") {
            self.isAddSheetShowing.toggle()
        }).sheet(isPresented: self.$isAddSheetShowing, content: {
            AddFridgeItemView(fridge: $fridge)
        })
    }
  }
  
}


struct CoreDataFridgeView: View {
  // FIX THIS
  @FetchRequest(
    entity: BoughtItemEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \BoughtItemEntity.expirationDate, ascending: true),]
    //,predicate: NSPredicate(format: "SUBQUERY(groceryItem, $groceryItem, $groceryItem.storageLocation == 'Fridge').@count > 0")
    //predicate:  NSPredicate(format: "item.storageLocation == %@", "Fridge")
  ) var fridge: FetchedResults<BoughtItemEntity>
  
  @Environment(\.managedObjectContext) var context
  @FetchRequest(
    entity: GroceryItemEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \GroceryItemEntity.name, ascending: true),
  ]) var shoppingList: FetchedResults<GroceryItemEntity>
  
  @State private var isAddSheetShowing = false
  var body: some View {
    NavigationView {
      VStack {
        /*List(fridge, id: \.groceryItem.name) { item in
          NavigationLink(destination: BoughtItemView(item: item), label: {
            GroceryItemRowView(item: item.groceryItem)
          })
        }*/
        
        List(fridge, id: \.expirationDate!) { item in
          Text("ygjbjbjh")
          /*let grocItem = GroceryItem(groceryItemEntity: MyGroceryTrackerCoreDataModel.getGroceryItemWith(name: item.name!)!)
          NavigationLink(destination: GroceryItemView(item: grocItem), label: {
            GroceryItemRowView(item: grocItem)
          })*/
        }
      }
      .navigationBarTitleDisplayMode(.inline)
      //.navigationTitle("Fridge")
        //.background(NavigationConfigurator { nc in
        //  nc.navigationBar.barTintColor = .blue
        //  nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        //})
       .toolbar { // <2>
            ToolbarItem(placement: .principal) { // <3>
                VStack {
                  Spacer()
                  Text("Fridge").font(.system(size: 30, design: .serif))
                  Spacer()
                  Spacer()
                  
                }
            }
        }
        .navigationBarItems(trailing: Button("Add") {
            self.isAddSheetShowing.toggle()
        }).sheet(isPresented: self.$isAddSheetShowing, content: {
            //AddFridgeItemView(fridge: $fridge)
        })
    }
  }
  
}


struct NotificationView: View {
  @Binding var storage: [BoughtItem]
  var notificationCenter:UNUserNotificationCenter!
  var notificationDelegate: UNUserNotificationCenterDelegate

  init(storage: Binding<[BoughtItem]>) {
    self.notificationCenter = UNUserNotificationCenter.current()
    self.notificationDelegate = NotificationDelegate()
    self._storage = storage
    setupNotification()
  }
  
  func setupNotification() {
    let options:UNAuthorizationOptions = [.alert, .sound]
    notificationCenter.requestAuthorization(options: options, completionHandler: {
       success, error in
        guard success == true else { print("Access not granted or error"); return }
        print("notification access granted")
    })
  }
  
  func setupAndFireNotification() {
    
    let options:UNAuthorizationOptions = [.alert, .sound]
    notificationCenter.requestAuthorization(options: options, completionHandler: {
       success, error in
        guard success == true else { print("Access not granted or error"); return }
        print("notification access granted")
    })
    
    let content = UNMutableNotificationContent()
    content.title = "Item Expiring Soon!"
    content.body = "Consume or dispose of your food!"
    content.sound = UNNotificationSound.default
    
    let categoryId = "edu.jhu.epp.Grade-Notification-Interface.notification"

    let category = UNNotificationCategory(identifier: categoryId, actions: [], intentIdentifiers: [], options: [])
    notificationCenter.setNotificationCategories([category])

    content.categoryIdentifier = categoryId
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    let notification = UNNotificationRequest(identifier: "Assignment2Notification", content: content, trigger: trigger)

    notificationCenter.add(notification, withCompletionHandler:
    {
        error in
        if let error = error
        {
            print("Error firing notification: \(error.localizedDescription)")
        }
        print("adding to center")
    })
  }
  
  var body: some View {
    Text("")
  }
  
}


class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
  
  override init() {
    super.init()
    UNUserNotificationCenter.current().delegate = self
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

    print("got notification in foreground")
    print("notification content \(notification.request.content.title)")
    completionHandler([.banner,.sound])

  }
}
