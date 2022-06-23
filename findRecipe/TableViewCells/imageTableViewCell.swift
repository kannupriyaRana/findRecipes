//
//  imageTableViewCell.swift
//  findRecipe
//
//  Created by Administrator on 10/02/22.
//

import UIKit

class imageTableViewCell: UITableViewCell {

    @IBOutlet var imageOfRecipe : UIImageView!
    
    static var identifier = "imageTableViewCell"

    static func nib()-> UINib {
        return UINib(nibName: "imageTableViewCell", bundle: nil)
    }
    
    //to change image programatically
    public func configure(_ imageStringURL: String) {
        
        let imageURL = URL(string: imageStringURL)!
        let imageData = try? Data(contentsOf: imageURL)
        if let _ = imageData{
            self.imageOfRecipe.image = UIImage(data: imageData!)
        }
        else{
            self.imageOfRecipe.image = UIImage(named: "randRecipeImg.jpeg")
        }
        
        self.imageOfRecipe.layer.cornerRadius = 20.0
        self.imageOfRecipe.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
