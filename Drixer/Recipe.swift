//
//  Recipe.swift
//  Drixer
//
//  Created by Josh Morrison on 4/24/20.
//  Copyright © 2020 Josh Morrison. All rights reserved.
//

import UIKit
import CoreData

class Recipe: NSManagedObject {
    
    static var userSelectedIngredients = [String]()
    static var userSelectedLiquors = [String]()
    
    class func getAllIngredients() -> [Ingredients]{
        
        let context = AppDelegate.viewContext
        
        // Create an array for ingredients.
        var allIngredients: [Ingredients] = []
        
        // Create a query
        let request: NSFetchRequest<Ingredients> = Ingredients.fetchRequest()
        request.predicate = NSPredicate(value: true)
        
        do{
            allIngredients = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        return allIngredients
    }
    
    class func getAllLiquors() -> [Liquors]{
        
        let context = AppDelegate.viewContext
        
        // Create an array for ingredients.
        var allLiquors: [Liquors] = []
        
        // Create a query
        let request: NSFetchRequest<Liquors> = Liquors.fetchRequest()
        request.predicate = NSPredicate(value: true)
        
        do{
            allLiquors = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        
        return allLiquors
    }
    
    class func getAllSelectedForRecipes(liquorsArr: [String], ingredientsArr: [String]) -> [Recipe]{
        
        let context = AppDelegate.viewContext
        
        var allRecipes: [Recipe] = []
        
        print(liquorsArr)
        print(ingredientsArr)
        
        // Create a query
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
//        request.predicate = NSPredicate(format: "ANY ingredients.name IN %@ AND ANY liquors.name IN %@", ingredientsArr, liquorsArr)
        request.predicate = NSPredicate(format: "SUBQUERY(ingredients, $g, !($g.name IN %@)).@count == 0 AND SUBQUERY(liquors, $g, !($g.name IN %@)).@count == 0", ingredientsArr, liquorsArr)
        
        do{
            allRecipes = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        
        
        print(allRecipes)
        for each in allRecipes {
            print(each.name)
        }
        
        return allRecipes
    }
    
}
