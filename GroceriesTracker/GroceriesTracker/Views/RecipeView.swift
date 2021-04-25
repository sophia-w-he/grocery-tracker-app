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
    //,predicate:  NSPredicate(format: "onShoppingList == true")
  ) var recipes: FetchedResults<RecipeEntity>
  @State private var itemsToEdit = Set<String>()
  
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
