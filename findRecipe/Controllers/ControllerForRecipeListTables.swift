//
//  RecipeViewController.swift
//  findRecipe
//
//  Created by Administrator on 11/02/22.
//

import UIKit

//used for tables of three screens : Screen1 - Recipes by ingredients, Screen2 -  Random recipes, Screen3 -  Liked recipes
            
class ControllerForRecipeListTables: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    deinit {
        print("Deinit of ControllerForRecipeListTables")
    }
    
    var tableView = UITableView()
    var recipeFetcherObject: RecipeFetcher!
    
    //required for "random recipes" query
    init(_ tableView: UITableView) {
        self.tableView = tableView
        recipeFetcherObject = RecipeFetcher(tableView)
        recipeFetcherObject.isRandomScreen = true
        super.init()
    }
    
    //required for "search by ingredient" query
    init(_ ingredientsPassed: [String], _ tableView: UITableView) {
        self.tableView = tableView
        recipeFetcherObject = RecipeFetcher(tableView)
        recipeFetcherObject.ingredientsPassed = ingredientsPassed
        recipeFetcherObject.isRandomScreen = false
        super.init()
    }
    
    //required for saved recipe table
    init(id idOfRecipes: [Int], _ tableView: UITableView) {
        self.tableView = tableView
        recipeFetcherObject = RecipeFetcher(tableView)
        recipeFetcherObject.idOfSavedRecipes = idOfRecipes
        recipeFetcherObject.isRandomScreen = false
        super.init()
    }
    
    //if ingredients are passed => require recipes according to ingredients => recipeResultsFromIngredients array is used
    //else if the screen contains Random Recipes => randomRecipeResults array is used
    //else show saved recipes
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(recipeFetcherObject.ingredientsPassed.count != 0){
            return recipeFetcherObject.recipeResultsFromIngredients.count
        }
        else if recipeFetcherObject.isRandomScreen{
            return recipeFetcherObject.randomRecipeResults.count
        }
        else {
            return recipeFetcherObject.savedRecipes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as! RecipeListTableViewCell
        if(recipeFetcherObject.ingredientsPassed.count != 0){
            cell.setCellFromStruct(recipeFetcherObject.recipeResultsFromIngredients[indexPath.row])
        }
        else if recipeFetcherObject.isRandomScreen {
            cell.setCellFromStruct(recipeFetcherObject.randomRecipeResults[indexPath.row])
        }
        else{
            cell.setCellFromStruct(recipeFetcherObject.savedRecipes[indexPath.row])
        }
        
        //save row no. with each try button as its tag
        cell.tryButton.tag = indexPath.row
        cell.tryButton.addTarget(self, action: #selector(showRecipeDetailsOfSelectedCell), for: .touchUpInside)
        cell.saveButton.tag = indexPath.row
        cell.saveButton.addTarget(self, action: #selector(updateSavedRecipeList), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
      
    //keeping a limit that of 50 recipes to be shown in a list
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if recipeFetcherObject.ingredientsPassed.count == 0 && recipeFetcherObject.isRandomScreen {
            if recipeFetcherObject.randomRecipeResults.count < 50 && indexPath.row == recipeFetcherObject.randomRecipeResults.count-3 {
                recipeFetcherObject.loadMoreData()
            }
        }
        else if recipeFetcherObject.ingredientsPassed.count != 0{
            if recipeFetcherObject.recipeResultsFromIngredients.count < 50 && indexPath.row == recipeFetcherObject.recipeResultsFromIngredients.count-3 {
                recipeFetcherObject.loadMoreData()
            }
        }
    }
    
    @objc func updateSavedRecipeList(_ sender: UIButton) {
        let indexOfSavedButtonPressed = sender.tag
        var recipeIdOfSavedButtonPressed : Int = 0

        if(recipeFetcherObject.ingredientsPassed.count != 0){
            recipeIdOfSavedButtonPressed = recipeFetcherObject.recipeResultsFromIngredients[indexOfSavedButtonPressed].id
            recipeFetcherObject.savedRecipeTitle = recipeFetcherObject.recipeResultsFromIngredients[indexOfSavedButtonPressed].title
        }
        else if recipeFetcherObject.isRandomScreen {
            recipeIdOfSavedButtonPressed = recipeFetcherObject.randomRecipeResults[indexOfSavedButtonPressed].id
            recipeFetcherObject.savedRecipeTitle = recipeFetcherObject.randomRecipeResults[indexOfSavedButtonPressed].title
        }
        else {
            recipeIdOfSavedButtonPressed = recipeFetcherObject.savedRecipes[indexOfSavedButtonPressed].id
            recipeFetcherObject.savedRecipeTitle = recipeFetcherObject.savedRecipes[indexOfSavedButtonPressed].title
        }

        print("savedID is : \(recipeIdOfSavedButtonPressed)")
        if RecipesStore.isBookmarked(id: recipeIdOfSavedButtonPressed, key: Constants.keyForBookmarkedRecipes) {
            RecipesStore.removeBookmark(id: recipeIdOfSavedButtonPressed,  key: Constants.keyForBookmarkedRecipes)
        }
        else {
            RecipesStore.addBookmark(id: recipeIdOfSavedButtonPressed, savedRecipeTitle: recipeFetcherObject.savedRecipeTitle, key: Constants.keyForBookmarkedRecipes)
        }
        tableView.reloadData()
    }

    @objc func showRecipeDetailsOfSelectedCell(_ sender: UIButton){
        let index = sender.tag
        if(recipeFetcherObject.ingredientsPassed.count != 0){
            recipeFetcherObject.tryRecipeID = recipeFetcherObject.recipeResultsFromIngredients[index].id
            recipeFetcherObject.tryRecipeTitle = recipeFetcherObject.recipeResultsFromIngredients[index].title
            recipeFetcherObject.tryRecipeImage = recipeFetcherObject.recipeResultsFromIngredients[index].image
            recipeFetcherObject.handlerForSegue!(recipeFetcherObject.tryRecipeID, recipeFetcherObject.tryRecipeTitle, recipeFetcherObject.tryRecipeImage)

        }
        else if recipeFetcherObject.isRandomScreen{
            recipeFetcherObject.tryRecipeID = recipeFetcherObject.randomRecipeResults[index].id
            recipeFetcherObject.tryRecipeTitle = recipeFetcherObject.randomRecipeResults[index].title
            recipeFetcherObject.tryRecipeImage = recipeFetcherObject.randomRecipeResults[index].image
            recipeFetcherObject.handlerForSegue!(recipeFetcherObject.tryRecipeID, recipeFetcherObject.tryRecipeTitle, recipeFetcherObject.tryRecipeImage)
        }
        else {
            recipeFetcherObject.tryRecipeID = recipeFetcherObject.savedRecipes[index].id
            recipeFetcherObject.tryRecipeTitle = recipeFetcherObject.savedRecipes[index].title
            recipeFetcherObject.tryRecipeImage = recipeFetcherObject.savedRecipes[index].image
            recipeFetcherObject.handlerForSegue!(recipeFetcherObject.tryRecipeID, recipeFetcherObject.tryRecipeTitle, recipeFetcherObject.tryRecipeImage)
        }
        print(recipeFetcherObject.tryRecipeID)
        print("from showrecipe : \(sender.tag) ")
        print(recipeFetcherObject.tryRecipeTitle)
    }

    
  }
