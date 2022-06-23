//
//  LastScreenViewController.swift
//  findRecipe
//
//  Created by Administrator on 08/02/22.
//

import UIKit

class RecipeInformationViewController: UIViewController {
    
    deinit {
        print("Deinit of RecipeInformationViewController")
    }
    
    
    
    //to avoid duplicate ingredients
    var ingredientSet = Set<String>()
    @IBOutlet weak var tableView: UITableView!
    var selectedRecipeIngredients = [String]()
    var selectedRecipeInstructions = [String]()
    
    let tableSectionHeaders = ["Ingredients", "Instructions"]
    var selectedRecipeID : Int?
    var selecetedRecipeTitle: String?
    var selectedRecipeImage: String?
    
    func completeURL() -> String {
        return "https://api.spoonacular.com/recipes/\(selectedRecipeID!)/analyzedInstructions?apiKey=\(Constants.apiKey1Kun)"
    }
    
    //recipe info => image + ingredients + instructions
    func generateRecipeInfoTable(completionHandler: @escaping ([Steps])->Void) {
        
        let url = URL(string: completeURL())!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            print("receivde url response")
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                print("reached safedata")
                let decoder = JSONDecoder()
                do{
                    print("reached here")
                    let decodedData = try decoder.decode([FinalInformationScreenDetails].self, from: safeData)
                    if(decodedData.count != 0){
                        for i in 0...decodedData.count-1 {
                                completionHandler(decodedData[i].steps)
                        }
                    }
                }
                catch{
                    print("here is the error :------------------------- \(error)")
                }
            }
        }
        task.resume()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        //first cell
        tableView.register(imageTableViewCell.nib(), forCellReuseIdentifier: imageTableViewCell.identifier)
       
        generateRecipeInfoTable(completionHandler: { [self]
            (stepArray) in
            
            for i in 0...stepArray.count-1 {
                self.selectedRecipeInstructions.append(stepArray[i].step)
                if stepArray[i].ingredients.count != 0{
                    for j in 0...stepArray[i].ingredients.count - 1 {
                        self.ingredientSet.insert(stepArray[i].ingredients[j].localizedName)
                    }
                }
                
            }
            for item in self.ingredientSet{
                self.selectedRecipeIngredients.append(item)
            }
            
            for item in self.selectedRecipeIngredients{
                print(item)
            }
            print("--------------")
            for item in self.selectedRecipeInstructions{
                    print(item)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
            self.navigationItem.title = "Enjoy !"
    }
}

extension RecipeInformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: headerView.frame.width - 10, height: 20))
        if section == 0 {
            headerLabel.text = selecetedRecipeTitle
            headerView.backgroundColor =  UIColor.white
            headerLabel.textColor = UIColor.init(named: "myGreen")
            headerLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            headerLabel.numberOfLines = 2
            
            headerLabel.textAlignment = NSTextAlignment.center
            headerLabel.sizeToFit()
        }
        else {
            headerLabel.text = tableSectionHeaders[section-1]
            headerView.backgroundColor =  UIColor.init(named: "myGreen")
            headerLabel.textColor = UIColor.systemBackground
        }
        
        headerLabel.font = UIFont.boldSystemFont(ofSize: 15)
        headerLabel.center = headerView.center
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
             return selectedRecipeIngredients.count
        }
        else {
            return selectedRecipeInstructions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {     //first cell should display imageCell
            let cell = tableView.dequeueReusableCell(withIdentifier: imageTableViewCell.identifier, for: indexPath) as! imageTableViewCell
            cell.configure(selectedRecipeImage!)
            cell.sizeToFit()
            return cell
        }
        
        //else display text cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelfSizingCell",for: indexPath) as! MultiLineInfoTableViewCell
        
        //for 2nd section, return ingredients
        if(indexPath.section == 1){
            cell.instructionLabel.text = "\(indexPath.row+1). \(selectedRecipeIngredients[indexPath.row])"
        }
        
        //for 3nd section, return ingredients
        if(indexPath.section == 2){
            cell.instructionLabel.text = "\(indexPath.row+1). \(selectedRecipeInstructions[indexPath.row])"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UITableView.automaticDimension
        }
        return 45.0

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }
        return UITableView.automaticDimension
    }
    
}

