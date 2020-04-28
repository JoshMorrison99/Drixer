//
//  FinalRecipeViewController.swift
//  Drixer
//
//  Created by Josh Morrison on 4/26/20.
//  Copyright © 2020 Josh Morrison. All rights reserved.
//

import UIKit

class FinalRecipeViewController: UIViewController, UITableViewDataSource {
    
    var info: Recipe? = nil
    
    @IBOutlet weak var mixImage: UIImageView!
    
    @IBOutlet weak var mixIngredientStack: UITableView!
    
    let cellSpacingHeight: CGFloat = 5
    
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mixIngredientStack.dataSource = self
        mixImage.image = getImagesFromDB(imageName: (info?.name?.lowercased())!)

        // Do any additional setup after loading the view.
        if info != nil{
            self.title = info?.name!
            getItems()
            mixIngredientStack.reloadData()
        } else {
            print("Error, there is no name for the mix")
        }
    }

    func getItems(){

        let myIngredients:NSSet = info!.ingredients!.value(forKey: "display") as! NSSet
        myIngredients.forEach { each in
            items.append(each as! String)
        }
        
        let myLiquors:NSSet = info!.liquors!.value(forKey: "display") as! NSSet
        myLiquors.forEach { each in
            items.append(each as! String)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    // Set the spacing between sections
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.items[indexPath.section].lowercased().capitalized
        
        // add border and color
        cell.cellStyle()
        
        return cell
    }
    
    func getImagesFromDB(imageName: String) -> UIImage?{
        
        if let image: UIImage = UIImage(named: imageName){
            return image
        }else{
            print("Image not Found ", imageName)
        }
        return nil
    }
}
