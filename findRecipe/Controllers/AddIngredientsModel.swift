//
//  AddIngredientsController.swift
//  findRecipe
//
//  Created by Administrator on 23/02/22.
//

import UIKit

class AddIngredientsModel {
    
    deinit {
        print("Deinit of AddIngredientsModel")
    }
    
    var inputIngredientArray = [String]()
    
    init(_ key: String) {
        if let defaultIngredients = UserDefaults.standard.value(forKey: key) as? [String] {
            inputIngredientArray = defaultIngredients            
        }
    }
    
    func getIngredientAraay() -> [String] {
        return inputIngredientArray
    }
    
    func deleteAllIngredients(_ key: String) {
        inputIngredientArray.removeAll()
        RecipesStore.updateUserDefaults(key , self.inputIngredientArray)
    }
    
    func addIngredient(_ ingredient: String, _ key: String) {
        inputIngredientArray.append(ingredient)
        RecipesStore.updateUserDefaults(key , inputIngredientArray)
    }
    
    func removeIngredient(_ index: Int, _ key: String) {
        inputIngredientArray.remove(at: index)
        RecipesStore.updateUserDefaults(key, inputIngredientArray)
    }
    
    
}
