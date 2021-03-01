//
//  ContentView.swift
//  GroceriesTracker
//
//  Created by Sophia on 2/24/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
  @State private var selection = 1
  @State var model: PersonalGroceryTrackerModel
  
  var body: some View {
    JSONDataView(selection: $selection, model: $model)
  }
}

struct JSONDataView: View {
  
  @Binding var selection: Int
  @Binding var model: PersonalGroceryTrackerModel
  
  var body: some View {
    
    TabView(selection: $selection) {
      ShoppingListView(shoppingList: model.myShoppingList)
        .tabItem{ Text("Shopping List") }
        .tag(1)
      
      /*CourseClassView(courseClass: model.schoolClasses[0])
        .tabItem{ Text("Class") }
        .tag(1)
      AssignmentsTableView(assignments: model.assignments)
        .tabItem{ Text("Assignments") }
        .tag(2)
      StudentsView(student: model.students[0])
        .tabItem{ Text("Student") }
        .tag(3)
      TeacherView(teacher: model.teachers[0])
        .tabItem{ Text("Teacher") }
        .tag(4)*/
    }
    
  }
  
}

/*
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}*/
