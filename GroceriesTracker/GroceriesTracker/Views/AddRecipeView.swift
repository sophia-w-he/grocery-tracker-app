//
//  AddRecipeView.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/24/21.
//

import Foundation
import SwiftUI

// View to add a recipe to my recipes
struct AddRecipeView: View {
  
  @Binding var isPresented: Bool
  @State private var itemSubmitted: Bool = false
  
  @State private var name: String = ""
  @State private var ingredients = [String]()
  @State private var steps = [String]()
  @State var itemName = ""
  @State var stepName = ""
  
  var body: some View {
    if !itemSubmitted {
      ZStack {
        LinearGradient(gradient: Gradient(colors: [.green, .white, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
        VStack {
          Spacer(minLength: 50)
          HStack {
            VStack{ Image("apple")
              .resizable()
              .aspectRatio(contentMode: .fit)
            }.frame(width: 30.0,height:30.0);
            VStack{ Image("avocado")
              .resizable()
              .aspectRatio(contentMode: .fit)
            }.frame(width: 30.0,height:30.0);
            VStack{ Image("carrot")
              .resizable()
              .aspectRatio(contentMode: .fit)
            }.frame(width: 30.0,height:30.0);
          }
          Text("Add Recipe").font(.system(size: 30, design: .serif)).fontWeight(.bold)
          HStack {
            VStack(alignment: .leading) {
              Text("Recipe Name: ").frame(maxHeight: .infinity).padding(.bottom, 4)
              
            }
            VStack(alignment: .leading) {
              HStack {
                Spacer()
                TextField("Recipe Name", text: $name)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer(minLength: 25)
              }
              
            }.padding(.leading)
            
          }.padding(.horizontal)
          .fixedSize(horizontal: false, vertical: true)
          VStack {
            Spacer(minLength: 25)
            Text("Ingredients:")
            ScrollView {
              ForEach(self.ingredients, id: \.self) { ingred in
                Text(ingred)
              }
              
              VStack {
                TextField("Ingredient Name", text: $itemName).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                  self.ingredients.append(self.itemName.lowercased())
                  self.itemName = ""
                  
                }) {
                  Text("Add Ingredient")
                }
              }.background(Color.clear)
              
            }.background(Color.clear)
            .listStyle(InsetGroupedListStyle())
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
            //Spacer()
            Text("Recipe Steps:")
            ScrollView {
              ForEach(self.steps, id: \.self) { ingred in
                Text(ingred)
              }
              
              VStack {
                TextField("Step", text: $stepName).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                  self.steps.append(self.stepName)
                  self.stepName = ""
                  
                }) {
                  Text("Add Step")
                }
              }.background(Color.clear)
              
            }.background(Color.clear)
            .listStyle(InsetGroupedListStyle())
          }.padding(.horizontal)
          .cornerRadius(20)
          .background(Color.clear)
          
          VStack {
            
            Button(action: {
              // submit action
              var rec = Recipe(name: name.lowercased(), imageName: name.lowercased().replacingOccurrences(of: "\\s", with: "", options: .regularExpression), recipeSteps: steps, ingredientNames: ingredients)
              
              
              rec.convertToManagedObject()
              
              do {
                try MyGroceryTrackerCoreDataModel.context.save()
              } catch {
                print("Error saving item to core data \(error)")
              }
              
              self.itemSubmitted.toggle()
              isPresented = false
              
            }, label: {
              Text("Add Recipe")
            })
            Spacer()
            Spacer()
            Spacer()
            Button("Cancel") {
              isPresented = false
            }
            Spacer(minLength: 50)
          }.padding(.vertical)
          .fixedSize(horizontal: false, vertical: true)
        }
      }.edgesIgnoringSafeArea(.all)
    } else {
      Text("Added!")
    }
  }
  
}
