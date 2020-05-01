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
    
    let cellSpacingHeight: CGFloat = 5
    
    
    @IBOutlet weak var nextBtn: UIButton! {
        didSet{
            nextBtn.backgroundColor = UIColor.systemOrange
            nextBtn.tintColor = UIColor.white
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Liquors"
        
        var returnedIngredients:[Ingredients] = []
        returnedIngredients = Ingredients.getAllIngredients()
        
        for each in returnedIngredients {
            if each.name != nil{
                if(avaliableIngredients.contains(each.name!) == false){
                    avaliableIngredients.append(each.name!.lowercased())
                }
            }
        }
        
        
        var returnedLiquors:[Liquors] = []
        returnedLiquors = Liquors.getAllLiquors()
        for each in returnedLiquors{
            if each.name != nil {
                if(avaliableLiquors.contains(each.name!) == false){
                    avaliableLiquors.append(each.name!.lowercased())
                }
            }
        }
        
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        let currentCell = tableView.cellForRow(at: indexPath)
        if let liquorSelected = currentCell?.textLabel!.text?.lowercased() {
            if Recipe.userSelectedLiquors.contains(liquorSelected){
                Recipe.userSelectedLiquors.remove(at: Recipe.userSelectedLiquors.firstIndex(of: liquorSelected)!)
                currentCell?.cellStyle()
            }else{
                Recipe.userSelectedLiquors.append(liquorSelected)
                currentCell?.cellStyleClicked()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return avaliableLiquors.count
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "liquorCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.avaliableLiquors[indexPath.section].lowercased().capitalized
        
        if let liquorSelected = cell.textLabel!.text?.lowercased() {
            if Recipe.userSelectedLiquors.contains(liquorSelected){
                cell.cellStyleClicked()
            }else{
                cell.cellStyle()
            }
        }
        
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

extension UITableViewCell {
    
    func cellStyle(){
        backgroundColor = UIColor.white
    }
    
    func cellStyleClicked(){
        
        backgroundColor = UIColor.systemOrange
    }
}
