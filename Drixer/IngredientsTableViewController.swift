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
    
    let cellSpacingHeight: CGFloat = 5
    
    @IBOutlet weak var nextBtn: UIButton!{
        didSet{
            nextBtn.backgroundColor = UIColor(displayP3Red: 0, green: 1, blue: 0, alpha: 0.5)
            nextBtn.tintColor = UIColor.black
        }
    }
    

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
        if let ingredientsSelected = currentCell?.textLabel!.text?.lowercased() {
            if Recipe.userSelectedIngredients.contains(ingredientsSelected){
                Recipe.userSelectedIngredients.remove(at: Recipe.userSelectedIngredients.firstIndex(of: ingredientsSelected)!)
                currentCell?.cellStyle()
            }else{
                Recipe.userSelectedIngredients.append(ingredientsSelected)
                currentCell?.cellStyleClicked()
            }
        }
    }
    
    func color(){
        let cells = self.tableView.visibleCells

        for cell in cells {
            // look at data
            if Recipe.userSelectedIngredients.contains((cell.textLabel?.text)!.lowercased()){
                cell.cellStyleClicked()
            }else{
                cell.cellStyle()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsId", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[indexPath.section].lowercased().capitalized
        return cell
    }
}

