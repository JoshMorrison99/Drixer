//
//  Liquors.swift
//  Drixer
//
//  Created by Josh Morrison on 4/24/20.
//  Copyright © 2020 Josh Morrison. All rights reserved.
//

import UIKit
import CoreData

class Liquors: NSManagedObject {

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
}
