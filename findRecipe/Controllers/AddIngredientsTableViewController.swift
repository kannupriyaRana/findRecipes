//
//  addIngrTableViewController.swift
//  findRecipe
//
//  Created by Administrator on 05/02/22.
//

import UIKit

class AddIngredientsTableViewController: UITableViewController, UITextFieldDelegate {
    
    deinit {
        print("Deinit of AddIngredientsTableViewController")
    }
    
    static let keyForUserDefaults = "defaultIngredients"
    var textField = UITextField()
    var addIngredientsModelObject = AddIngredientsModel(keyForUserDefaults)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addIngredientsModelObject.getIngredientAraay().count
    }
    
    //each cell has an ingredient value and a delete icon
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = addIngredientsModelObject.getIngredientAraay()[indexPath.row]
        let icon = UIImage(systemName:"delete.left")
        cell.accessoryView = UIImageView(image: icon)
        cell.tintColor = UIColor.black
        return cell
    }
    
    //selecting a row => ask for deletion and deselect the row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let removeAlert = UIAlertController(title: "Remove this item ?", message: "", preferredStyle: UIAlertController.Style.alert)

        removeAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] (action: UIAlertAction!) in
            addIngredientsModelObject.removeIngredient(indexPath.row, AddIngredientsTableViewController.keyForUserDefaults)
            self.tableView.reloadData()
            
        }))
        removeAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
            return
        }))
        present(removeAlert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        let deleteAlert = UIAlertController(title: "Remove all ingredients?", message: "", preferredStyle: UIAlertController.Style.alert)
        deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            self.addIngredientsModelObject.deleteAllIngredients(AddIngredientsTableViewController.keyForUserDefaults)
            self.tableView.reloadData()
            
        }))
        deleteAlert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    
    //add button pressed => ask for an ingredient through an alert and add it to the ingredient array if it is valid
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var tempTextField = UITextField()          //a temporary textField to store reference to other textFields
        let addAlert = UIAlertController(title: "Add ingredient", message: "", preferredStyle: UIAlertController.Style.alert)
        addAlert.addTextField { alertTextField in
            //storing a reference to alertTextField, so that its text can be used later in UIAlertAction
            tempTextField = alertTextField
            alertTextField.placeholder = "Write here"
        }
        addAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action: UIAlertAction!) in
            
            //what will happen once the user clicks the "add button on alert"
            if tempTextField.text != nil && tempTextField.text! != "" && tempTextField.text! != " "{
                self.addIngredientsModelObject.addIngredient(tempTextField.text!, AddIngredientsTableViewController.keyForUserDefaults)
            }
            self.tableView.reloadData()
            
        }))
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil ))
        self.present(addAlert, animated: true, completion: nil)
    }
    
    //go to next screen; do required initialisations for next screen ViewController
    @IBAction func fetchRecipesPressed(_ sender: UIBarButtonItem) {
        if addIngredientsModelObject.getIngredientAraay().count == 0 {
            let emptyArrayAlert = returnEmptyAlert()
            present(emptyArrayAlert, animated: true, completion: nil)
        }
        else{
            self.performSegue(withIdentifier: "goToRecipeResults", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRecipeResults" {
            let destinationVC = segue.destination as! RecipeResultsUsingIngredientsViewController
            //pass the ingredients to next screen ViewController
            for i in 0...self.addIngredientsModelObject.getIngredientAraay().count-1 {
                destinationVC.ingredient.append(self.addIngredientsModelObject.getIngredientAraay()[i])
            }
        }
    }
}
