//
//  RecipeView.swift
//  GroceriesTracker
//
//  Created by Sophia on 4/24/21.
//

import Foundation
import SwiftUI

struct RecipeListView: View {
  @Environment(\.managedObjectContext) var context
  @FetchRequest(
    entity: RecipeEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \RecipeEntity.name, ascending: true),]
  ) var recipes: FetchedResults<RecipeEntity>
  
  @State private var isAddSheetShowing = false
  @State private var itemsToEdit = Set<String>()
  @State var isEditMode: EditMode = .active
  
  @State var isEditing = false
  @State var selection = Set<String>()
  
  var body: some View {
    NavigationView {
      VStack {
        List(recipes, id: \.name!, selection: $itemsToEdit) { item in
          let rec = Recipe(recipeEntity: MyGroceryTrackerCoreDataModel.getRecipeWith(name: item.name!)!)
          
          NavigationLink(destination: RecipeView(item: rec, dataItem: item).toolbar {
            ToolbarItem(placement: .principal) {
              VStack {
                Spacer()
                Text("Recipe").font(.system(size: 25, design: .serif))
                Spacer()
                Spacer()
                
              }.foregroundColor(.black)
            }
          }, label: {
            RecipeCoreDataRowView(item: rec, dataItem: item)
          })
        }
      }.navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          VStack {
            Spacer()
            Text("Recipes").font(.system(size: 25, design: .serif))
            Spacer()
            Spacer()
            
          }.foregroundColor(.black)
        }
      }
      .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
      .navigationBarItems(leading:
                            Button(isEditing ? "Remove" : "Edit") {
                              if !isEditing {
                                self.isEditing.toggle()
                              }else {
                                itemsToEdit.forEach(){ item in
                                  print(itemsToEdit)
                                  
                                  let recIndex = recipes.firstIndex(where: { $0.name! ==  item})
                                  let rec = recipes[recIndex!]
                                  
                                  context.delete(rec)
                                  let itemIndex = itemsToEdit.firstIndex(of: item)
                                  itemsToEdit.remove(at:itemIndex!)
                                  
                                }
                                self.isEditing.toggle()
                                
                                
                                
                              }
                            },
                          trailing: Button(isEditing ? "Cancel" : "Add") {
                            if !isEditing {
                              self.isAddSheetShowing.toggle()
                            } else {
                              self.isEditing.toggle()
                            }
                          }).sheet(isPresented: self.$isAddSheetShowing, content: {
                            AddRecipeView(isPresented: $isAddSheetShowing)
                            
                          })
      
    }
  }
  
}


struct RecipeCoreDataRowView: View {
  
  var item: Recipe
  var dataItem: RecipeEntity
  
  var body: some View {
    HStack {
      VStack{ Image(item.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
      }.frame(width: 20.0,height:20.0)
      Text(item.name).font(.system(size: 25, design: .serif))
      Spacer()
    }
  }
  
}

struct RecipeView: View {
  var item: Recipe
  var dataItem: RecipeEntity
  
  var body: some View {
    VStack {
      Spacer()
      Text(item.name).font(.system(size: 30, design: .serif))
      HStack {
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 50.0,height:50.0)
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 50.0,height:50.0)
        VStack{ Image(item.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        }.frame(width: 50.0,height:50.0)
      }
      Spacer()
      Spacer()
      Spacer()
      Spacer()
      VStack {
        Spacer()
        Text("Ingredients").font(.system(size: 25, design: .serif))
        List(item.ingredientNames, id: \.self) { ingredient in
          HStack {
            VStack{ Image(ingredient)
              .resizable()
              .aspectRatio(contentMode: .fit)
            }.frame(width: 20.0,height:20.0);
            Text(ingredient).font(.system(size: 25, design: .serif))
          }
        }
      }
      
      VStack {
        Text("Steps").font(.system(size: 25, design: .serif))
        List(item.recipeSteps, id: \.self) { step in
          Text(step).font(.system(size: 20, design: .serif))
        }
      }
    }
  }
  
}
