//
//  ViewController.swift
//  findRecipe
//
//  Created by Administrator on 05/02/22.
//

import UIKit

class A{
    var B : FirstScreenViewController?
}

class FirstScreenViewController: UIViewController {
    var a : A?
    deinit {
        print("Deinit of firstScreenViewController")
    }

    var myDelegate: ControllerForRecipeListTables? = nil
    
    @IBAction func likedButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLikedRecipes", sender: self)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func searchByIngrPressed(_ sender: UIButton) {
//        ParseplistFile.getPlistValues()
        self.performSegue(withIdentifier: "goToAddIngr", sender: self)
    }
    
    var tryRecipeID: Int = 0
    var tryRecipeTitle: String = ""
    var tryRecipeImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "firstScreenTable"
        myDelegate = ControllerForRecipeListTables(tableView)
        let handlerForSegue: (Int,String, String)->Void = { (id,title, image) in
            self.tryRecipeID = id
            self.tryRecipeTitle = title
            self.tryRecipeImage = image
            self.performSegue(withIdentifier: "goToLastScreen", sender: self)
        }
        
        tableView.dataSource = myDelegate!
        tableView.delegate = myDelegate!
        myDelegate!.recipeFetcherObject.handlerForSegue = handlerForSegue
        self.tableView.rowHeight = 104.0
        
        myDelegate!.recipeFetcherObject.updateRecipeResultList(completionHandler: { (status) in
            if status == "failed" {
                DispatchQueue.main.async {
                    let failedNetworkCallAlert = returnFailedAlert()
                    self.present(failedNetworkCallAlert, animated: true, completion: nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
        tableView.separatorStyle = .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLastScreen" {
            let destinationVC = segue.destination as! RecipeInformationViewController
            destinationVC.selectedRecipeID = self.tryRecipeID
            destinationVC.selecetedRecipeTitle = self.tryRecipeTitle
            destinationVC.selectedRecipeImage = self.tryRecipeImage
        }
    }
}

