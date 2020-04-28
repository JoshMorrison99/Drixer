//
//  Ingredients.swift
//  Drixer
//
//  Created by Josh Morrison on 4/24/20.
//  Copyright © 2020 Josh Morrison. All rights reserved.
//

import UIKit
import CoreData

class Ingredients: NSManagedObject {

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
}
