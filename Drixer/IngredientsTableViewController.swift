//
//  IngredientsTableViewController.swift
//  Drixer
//
//  Created by Josh Morrison on 4/25/20.
//  Copyright © 2020 Josh Morrison. All rights reserved.
//

import UIKit

class IngredientsTableViewController: UITableViewController {
    
    var items = [String]()
    var userSelectedLiquors = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Ingredients"
        print(items)
        print("userISelected ", Recipe.userSelectedIngredients)
    }
    
    override func viewDidLayoutSubviews() {
        color()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        let currentCell = tableView.cellForRow(at: indexPath)
        if let ingredientsSelected = currentCell?.textLabel!.text {
            if Recipe.userSelectedIngredients.contains(ingredientsSelected){
                Recipe.userSelectedIngredients.remove(at: Recipe.userSelectedIngredients.firstIndex(of: ingredientsSelected)!)
                currentCell?.backgroundColor = UIColor.white
            }else{
                Recipe.userSelectedIngredients.append(ingredientsSelected)
                currentCell?.backgroundColor = UIColor.green
            }
        }
    }
    
    func color(){
        let cells = self.tableView.visibleCells

        for cell in cells {
            // look at data
            if Recipe.userSelectedIngredients.contains((cell.textLabel?.text)!){
                cell.backgroundColor = UIColor.green
            }else{
                cell.backgroundColor = UIColor.white
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsId", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[indexPath.item]
        return cell
    }
}

