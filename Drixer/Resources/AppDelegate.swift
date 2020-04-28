//
//  AppDelegate.swift
//  Drixer
//
//  Created by Josh Morrison on 4/21/20.
//  Copyright © 2020 Josh Morrison. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        testing()
        preloadData()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func testing(){
        // TESTING--------------------==
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Ingredients")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Recipe")
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        let fetchRequest3: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Liquors")
        let deleteRequest3 = NSBatchDeleteRequest(fetchRequest: fetchRequest3)

        do {
            print("deleting...")
            try AppDelegate.storeCoordinator.execute(deleteRequest, with: AppDelegate.viewContext)
            try AppDelegate.storeCoordinator.execute(deleteRequest2, with: AppDelegate.viewContext)
            try AppDelegate.storeCoordinator.execute(deleteRequest3, with: AppDelegate.viewContext)
        } catch _ as NSError {
            // TODO: handle the error
            print("error")
        }
        
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
        let preloadedDataKey = "didPreloadData"
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(false, forKey: preloadedDataKey)
        print(userDefaults.bool(forKey: "didPreloadData"))
        
        
    }
    
    func preloadData(){
        print("Preload...")
        let preloadedDataKey = "didPreloadData"
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            // If we are in here, then the data has never been preloaded.
            guard let urlPath = Bundle.main.url(forResource: "Recipes", withExtension: "plist") else {
                return
            }
            
            let backgroundContext = persistentContainer.newBackgroundContext()
            persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            
            backgroundContext.perform {
                if let arrayContents = NSDictionary(contentsOf: urlPath) as? Dictionary<String, Dictionary<String, [Dictionary<String, Any>]>>{
                    do {
                        for item in arrayContents{
                            print("Item Name: ", item.key)
                            let recipeObject = Recipe(context: backgroundContext)
                            recipeObject.id = UUID()
                            recipeObject.created = Date()
                            recipeObject.name = item.key
                            for each in item.value{
                                //print("Category: ", each.key )
                                if(each.key == "ingredients"){
                                    //print("INGREDIENTS")
                                    for every in each.value {
                                        for all in every {
                                            //print(" -", all.key, " -", all.value)
                                            let ingredientObject = Ingredients(context: backgroundContext)
                                            recipeObject.addToIngredients(ingredientObject)
                                            if(all.key == "name"){
                                                //print("NAME")
                                                ingredientObject.name = all.value as? String
                                            }else if (all.key == "display"){
                                                ingredientObject.display = all.value as? String
                                            }
                                        }
                                    }
                                } else if(each.key == "liquor") {
                                    //print("LIQUOR")
                                    for every in each.value {
                                        for all in every {
                                            //print(" -", all.key, " -", all.value)
                                            let liquorObject = Liquors(context: backgroundContext)
                                            recipeObject.addToLiquors(liquorObject)
                                            if(all.key == "name"){
                                                //print("NAME")
                                                liquorObject.name = all.value as? String
                                            }else if (all.key == "display"){
                                                liquorObject.display = all.value as? String
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    try backgroundContext.save()
                    // Preload complete
                    userDefaults.set(true, forKey: preloadedDataKey)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Drixer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Create a static var for the container. Access by: let coreDataContainer = AppDelegate.persistentContainer
    static var persistentContainer: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    // Create a static var for the context. Access by: let context = AppDelegate.viewContext
    static var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Create a static var for the context. Access by: let context = AppDelegate.persistentStoreCoordinator
   static var storeCoordinator: NSPersistentStoreCoordinator {
        return persistentContainer.persistentStoreCoordinator
   }
    
    

}
