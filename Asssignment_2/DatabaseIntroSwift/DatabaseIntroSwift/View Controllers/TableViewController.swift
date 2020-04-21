//
//  TableViewController.swift
//  DatabaseIntroSwift
//
//  Created by Sher on 2020-03-26
//  Copyright © 2020 Sher Khan. All rights reserved.
//

import UIKit
// step 10 - add delegate methods to support table
class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // step 11 instantiate app delegate object, we will need it throughout the class.
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // step 11b - refresh data from database
        mainDelegate.readDataFromDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // step 12 - add table methods
    // step 12a - for number of table cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.people.count
    }

    // step 12b - how thick each cell is
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // step 12c - what should go in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.people[rowNum].name
        tableCell.secondaryLabel.text = mainDelegate.people[rowNum].email
        tableCell.foodLabel.text = mainDelegate.people[rowNum].food
        tableCell.myImageView.image = UIImage(named: mainDelegate.people[rowNum].avatar ?? "1")
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    // step 12d - what should happen when you press on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNum = indexPath.row
        let alertController = UIAlertController(title: mainDelegate.people[rowNum].name, message: mainDelegate.people[rowNum].food, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
        // move on to PickerViewController.swift
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
