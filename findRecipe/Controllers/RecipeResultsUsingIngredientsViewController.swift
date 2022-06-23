//
//  RecipeResultsViewController.swift
//  findRecipe
//
//  Created by Administrator on 06/02/22.
//

import UIKit


class RecipeResultsUsingIngredientsViewController: UIViewController {

    deinit {
        print("Deinit of RecipeResultsUsingIngredientsViewController")
    }
    
    var myDelegate: ControllerForRecipeListTables? = nil
    var ingredient = [String]()
    var tryRecipeID = 0
    var tryRecipeTitle = ""
    var tryRecipeImage:String = ""
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = " "                     // to clear the text in the back button in navigation bar
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Your Recipes"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "recipeResultsFromIngredientsTable"
        myDelegate = ControllerForRecipeListTables(ingredient, tableView)
        let handlerForSegue: (Int,String, String)->Void = { (id,title, image) in
            self.tryRecipeID = id
            self.tryRecipeTitle = title
            self.tryRecipeImage = image
            self.performSegue(withIdentifier: "goToFinalScreen", sender: self)
        }
        tableView.dataSource = myDelegate!
        tableView.delegate = myDelegate!
        myDelegate!.recipeFetcherObject.handlerForSegue = handlerForSegue
        
        myDelegate!.recipeFetcherObject.updateRecipeResultList(completionHandler: { (status)  in
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
        if segue.identifier == "goToFinalScreen" {
            let destinationVC = segue.destination as! RecipeInformationViewController
            destinationVC.selectedRecipeID = self.tryRecipeID
            destinationVC.selecetedRecipeTitle = self.tryRecipeTitle
            destinationVC.selectedRecipeImage = self.tryRecipeImage
        }
    }
    
}

