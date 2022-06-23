//
//  LastScreenStruct.swift
//  findRecipe
//
//  Created by Administrator on 09/02/22.
//

import UIKit

struct FinalInformationScreenDetails: Codable {
    var steps: [Steps]
}

struct Steps: Codable {
    var step: String
    var ingredients: [Ingredients]
}

struct Ingredients: Codable {
    var localizedName: String
}
