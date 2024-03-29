//
//  RecipeOptionsTableViewController.swift
//  Drixer
//
//  Created by Josh Morrison on 4/24/20.
//  Copyright © 2020 Josh Morrison. All rights reserved.
//

import UIKit

class RecipeOptionsTableViewController: UITableViewController {
    
    var recipes: [Recipe] = []
    var indexOfMix: Int = 0
    
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Select Mix"
        
        recipes = Recipe.getAllSelectedForRecipes(liquorsArr: Recipe.userSelectedLiquors, ingredientsArr: Recipe.userSelectedIngredients)
        tableView.reloadData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recipes = Recipe.getAllSelectedForRecipes(liquorsArr: Recipe.userSelectedLiquors, ingredientsArr: Recipe.userSelectedIngredients)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return recipes.count
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeItem", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = recipes[indexPath.section].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        indexOfMix = indexPath.section
        print(indexOfMix)
        performSegue(withIdentifier: "showMix", sender: nil)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is FinalRecipeViewController
        {
            let vc = segue.destination as? FinalRecipeViewController
            vc?.info = recipes[indexOfMix]
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
