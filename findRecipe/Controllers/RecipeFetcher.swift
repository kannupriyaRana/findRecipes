//
//  RecipeFetcher.swift
//  findRecipe
//
//  Created by Administrator on 23/02/22.
//

import UIKit

class RecipeFetcher {
    
    deinit {
        print("Deinit of RecipeFetcher")
    }
    
    
    var tableView: UITableView!
    var recipeResultsFromIngredients = [RecipeByIngredients]()          //recipes returned when ingredients are passed
    var randomRecipeResults = [RandomRecipe]()                          //recipes returned for random list
    var savedRecipes = [RandomRecipe]()                                //recipes returned for saved list
    var isRandomScreen = false
    var offset = 0                                                      //no. of results to skip during API request
    let number = 10                                                     //no. of results returned in a call
    var idOfSavedRecipes = [Int]()
    var ingredientsPassed = [String]()
    
    var tryRecipeID: Int = 0
    var tryRecipeTitle: String = ""
    var tryRecipeImage: String = ""
    var savedRecipeTitle: String = ""
    var handlerForSegue: ((Int, String, String)-> Void)? = nil
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
    }
    
    func loadMoreData() {
        updateRecipeResultList(completionHandler: { (status) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    func completeURL(_ idOfRecipe: Int = -1) -> String {
        var urlString = ""
        
        if idOfRecipe != -1 {
            urlString = "https://api.spoonacular.com/recipes/\(idOfRecipe)/information?apiKey=\(Constants.apiKey1Kun)"
        }
        
        //url to fetch recipes according to ingredients passed
        else if(ingredientsPassed.count != 0){
            urlString = "https://api.spoonacular.com/recipes/complexSearch?offset=\(offset)&number=10&apiKey=\(Constants.apiKey1Kun)&sort=max-used-ingredients&includeIngredients="
            for i in 0...ingredientsPassed.count-1 {
                urlString.append("\(ingredientsPassed[i]),")
            }
            offset += number + 1
        }
        
        //url to get random recipes
        else {
            urlString = "https://api.spoonacular.com/recipes/random?number=10&apiKey=\(Constants.apiKey1Kun)"
            offset += number + 1
        }
        return urlString
    }
    
    func decode(_ safeData: Data) throws {
        let decoder = JSONDecoder()
        do{
            if(ingredientsPassed.count != 0) {
                let decodedData = try decoder.decode(RecipesByIngredientsList.self, from: safeData)
                for item in decodedData.results {
                    recipeResultsFromIngredients.append(item)
                }
            }
            else{
                let decodedData = try decoder.decode(RandomRecipeListDetails.self, from: safeData)
                for item in decodedData.recipes {
                    randomRecipeResults.append(item)
                }
            }
            offset += number + 1
        }
    }
    
    func updateRecipeResultList(completionHandler: @escaping (_ status: String)->Void) {
        let url = URL(string: completeURL())!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [self] (data, response, error) in
            print("receivde url response")
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
//                print("printing safedata")
//                print(safeData)
                let dataString = String(data: safeData, encoding: .utf8)
//                print("printing datastring")
//                print(dataString)
//                print("reached safedata")
                do {
                    try decode(safeData)
                    completionHandler("passed")
                }
                catch{
                    print(error)
                    completionHandler("failed")
                }
            }
        }
        task.resume()
    }
    
    
    func updateLikedRecipeResultList(completionHandler: @escaping (_ status: String)->Void) {
        if idOfSavedRecipes.count == 0 {
            return
        }
        for i in 0...idOfSavedRecipes.count-1 {
            let url = URL(string: completeURL(idOfSavedRecipes[i]))!
            let session = URLSession.shared
            let task = session.dataTask(with: url) { [self] (data, response, error) in
                print("receivde url response")
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    print("reached safedata")
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(RandomRecipe.self, from: safeData)
                        savedRecipes.append(decodedData)
                        completionHandler("passed")
                    }
                    catch{
                        print(error)
                        completionHandler("failed")
                    }
                }
            }
            task.resume()
        }
    }
}
