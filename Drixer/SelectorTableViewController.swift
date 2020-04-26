//
//  SelectorTableViewController.swift
//  Drixer
//
//  Created by Josh Morrison on 4/21/20.
//  Copyright © 2020 Josh Morrison. All rights reserved.
//

import UIKit
import CoreData

class SelectorTableViewController: UITableViewController {
    
    let context = AppDelegate.viewContext
    let container = AppDelegate.persistentContainer
    
    var avaliableIngredients: [String] = []
    var avaliableLiquors: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Liquors"
        
        var returnedIngredients:[Ingredients] = []
        returnedIngredients = Recipe.getAllIngredients()
        
        for each in returnedIngredients {
            if each.name != nil {
                avaliableIngredients.append(each.name!)
            }
        }
        
        
        var returnedLiquors:[Liquors] = []
        returnedLiquors = Recipe.getAllLiquors()
        for each in returnedLiquors {
            if each.name != nil {
                avaliableLiquors.append(each.name!)
            }
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return avaliableLiquors.count
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        let currentCell = tableView.cellForRow(at: indexPath)
        if let liquorSelected = currentCell?.textLabel!.text {
            if Recipe.userSelectedLiquors.contains(liquorSelected){
                Recipe.userSelectedLiquors.remove(at: Recipe.userSelectedLiquors.firstIndex(of: liquorSelected)!)
                currentCell?.backgroundColor = UIColor.white
            }else{
                Recipe.userSelectedLiquors.append(liquorSelected)
                currentCell?.backgroundColor = UIColor.green
            }
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return avaliableLiquors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "liquorCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.avaliableLiquors[indexPath.item]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is IngredientsTableViewController
        {
            let vc = segue.destination as? IngredientsTableViewController
            vc?.items = avaliableIngredients
        }
    }

}
