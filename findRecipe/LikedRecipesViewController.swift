//
//  LikedRecipesViewController.swift
//  findRecipe
//
//  Created by Administrator on 16/02/22.
//

import UIKit

class LikedRecipesViewController: UIViewController {
    
    deinit {
        print("Deinit of LikedRecipesViewController")
        Constants.deinitStatement = "Deinit of LikedRecipesViewController"
    }

//    init() {
//        super.init(nibName: nil, bundle: nil)
//        print("construction of LikedRecipesViewController")
//
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(nibName: nil, bundle: nil)
//        print("construction of LikedRecipesViewController")
//    }
    
    var idArray = [Int]()
    var myDelegate: ControllerForRecipeListTables? = nil
    
    var tryRecipeID: Int = 0
    var tryRecipeTitle: String = ""
    var tryRecipeImage: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Unmanaged.passUnretained(self).toOpaque())
        tableView.accessibilityIdentifier = "likedScreenTable"
        idArray = RecipesStore.fetchBookmarkedRecipesFromUserDefaults(key: Constants.keyForBookmarkedRecipes)
        for item in idArray{
            print(item)
        }
        myDelegate = ControllerForRecipeListTables(id: idArray, tableView)
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
        
        myDelegate!.recipeFetcherObject.updateLikedRecipeResultList(completionHandler: { (status) in
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
    
    @IBAction func DeleteAllButtonPressed(_ sender: UIBarButtonItem) {
        
        let deleteAlert = UIAlertController(title: "Remove all Recipes ?", message: "", preferredStyle: UIAlertController.Style.alert)
        deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] (action: UIAlertAction!) in
            
//            self?.idArray.removeAll()
//            RecipesStore.updateUserDefaults(Constants.keyForBookmarkedRecipes, self?.idArray ?? [Int]())
//            self?.tableView.reloadData()
            
            self.idArray.removeAll()
            RecipesStore.updateUserDefaults(Constants.keyForBookmarkedRecipes, self.idArray)
            self.tableView.reloadData()
//
        }))
        deleteAlert.addAction(UIAlertAction(title: "No", style: .default, handler: nil ))
        self.present(deleteAlert, animated: true, completion: nil)
        
    }
    
}
