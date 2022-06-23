//
//  RecipesFetched.swift
//  findRecipe
//
//  Created by Administrator on 17/02/22.
//
struct RecipesByIngredientsList: Codable {
    var results: [RecipeByIngredients]
    var totalResults: Int
}
