//
//  ResultTableViewCell.swift
//  findRecipe
//
//  Created by Administrator on 07/02/22.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {

    @IBOutlet weak var dishImage: LazyImageView!
    
    @IBOutlet weak var dishName: UILabel!
    
    @IBOutlet weak var otherInfo: UILabel!
    
    @IBOutlet weak var tryButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
            
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //setting cell for "recipes by ingredient" list
    func setCellFromStruct(_ recipe: RecipeByIngredients) {
        DispatchQueue.main.async { [self] in
            self.dishName.text = recipe.title
            self.otherInfo.text = "Matched ingredients: \(recipe.usedIngredientCount)"
            let imageURL = URL(string: recipe.image)!
            self.dishImage.loadImage(fromUrl: imageURL, placeholder: "loadingImage")
            if RecipesStore.isBookmarked(id: recipe.id, key: Constants.keyForBookmarkedRecipes) {
                let img = UIImage(systemName: "bookmark.fill")
                saveButton.setImage(img, for: .normal)
            }
            else {
                let img = UIImage(systemName: "bookmark")
                saveButton.setImage(img, for: .normal)
            }
        }
    }
    
    //setting cell for "random recipe List"
    func setCellFromStruct(_ recipe: RandomRecipe) {
        DispatchQueue.main.async { [self] in
            self.dishName.text = recipe.title
            self.otherInfo.text = (recipe.vegetarian == true) ? "Vegetarian" : "Non-Vegetarian"
            let imageURL = URL(string: recipe.image)!
                self.dishImage.loadImage(fromUrl: imageURL, placeholder: "loadingImage")
            if RecipesStore.isBookmarked(id: recipe.id,  key: Constants.keyForBookmarkedRecipes) {
                let img = UIImage(systemName: "bookmark.fill")
                saveButton.setImage(img, for: .normal)
            }
            else {
                let img = UIImage(systemName: "bookmark")
                saveButton.setImage(img, for: .normal)
            }
        }
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
