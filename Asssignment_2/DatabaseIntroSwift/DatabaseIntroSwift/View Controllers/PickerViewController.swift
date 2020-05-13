//
//  PickerViewController.swift
//  DatabaseIntroSwift
//
//  Created by Sher on 2020-03-26.
//  Copyright © 2020 Sher Khan. All rights reserved.
//

import UIKit

// step 13 - add picker view delegates
class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // step 14 - add app delegate as we will need it throughout the class
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // step 14b - refresh data from database
        mainDelegate.readDataFromDatabase()

    }

    // step 15 - create the support methods for displaying a picker view
    // step 15a - number of rows in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainDelegate.people.count
    }
    
    // step 15b - how many "wheels" in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // step 15c - what should be displayed in each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mainDelegate.people[row].name
    }
    
    // step 15d - what to do when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let alertController = UIAlertController(title: mainDelegate.people[row].name, message: mainDelegate.people[row].email, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
        // move on to AppDelegate.swift
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
