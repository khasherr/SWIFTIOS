//
//  RegisterViewController.swift
//  ks_assignment1
//
//  Created by Xcode User on 2020-02-02.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    lazy var mesg:String = "thank you for signing up" + " " + myNameText.text! + " " + myEmailText.text! 

    @IBOutlet var myBackButton: UIButton!
    
    @IBOutlet var genderSwitch: UISwitch!
    @IBOutlet var mySubmitButton: UIButton!
    
    @IBOutlet var genderText: UILabel!
    
    @IBOutlet var myName: UILabel!
    
    @IBOutlet var myEmail: UILabel!
    
    @IBOutlet var myNameText: UITextField!

    
    @IBOutlet var myEmailText: UITextField!

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()

    }
    
    @IBAction func updateLabel(sender: Any){
        
        
        let alert = UIAlertController(title: "Congrats", message: mesg , preferredStyle: .alert)
        
        let thankYouAction = UIAlertAction(title: "Thanks", style: .default, handler: nil)
        
        alert.addAction(thankYouAction)
        present(alert, animated: true)
    }
    
    
    
    //choosing gender methjod
    @IBAction func buttonClicked(_ sender: Any) {
        if genderSwitch.isOn {
            genderText.text = "Female"
            genderSwitch.setOn(false, animated:true)
        } else {
            genderText.text = "Male"
            genderSwitch.setOn(true, animated:true)
        }
    }
    
    @objc func stateChanged(switchState: UISwitch) {
        if genderSwitch.isOn {
            genderText.text = "Male"
        } else {
            genderText.text = "Female"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mySubmitButton.layer.cornerRadius = 10
        myBackButton.layer.cornerRadius = 10
        
        genderSwitch.addTarget(self, action: #selector(stateChanged), for: .valueChanged)
        
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
