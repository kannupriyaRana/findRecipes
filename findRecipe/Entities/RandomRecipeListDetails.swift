//
//  RandomRecipeStruct.swift
//  findRecipe
//
//  Created by Administrator on 10/02/22.
//

import UIKit

struct RandomRecipeListDetails: Codable {
    var recipes: [RandomRecipe]
}

struct RandomRecipe: Codable {
    var vegetarian: Bool
    var title: String
    var image: String
    var id: Int
}
