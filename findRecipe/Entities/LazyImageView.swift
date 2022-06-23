//
//  LazyImageView.swift
//  findRecipe
//
//  Created by Administrator on 21/02/22.
//

import Foundation
import UIKit

class LazyImageView: UIImageView {
    func loadImage(fromUrl imageURL: URL, placeholder: String ) {
        self.image = UIImage(named: placeholder)
        DispatchQueue.global().async {
            [weak self] in
            if let imageData = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
