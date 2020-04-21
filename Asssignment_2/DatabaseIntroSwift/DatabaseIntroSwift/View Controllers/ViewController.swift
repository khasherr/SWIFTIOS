//
//  ViewController.swift
//  DatabaseIntroSwift
//
//  Created by Sher on 2020-03-26.
//  Copyright © 2020 Sher Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // step 8 create and connect label outlets, add above delegate
    @IBOutlet var lblTable : UILabel!
    @IBOutlet var lbPicker : UILabel!
    
    // step 17 - add textfield variables - connect to storyboard
    @IBOutlet var tbName : UITextField!
    @IBOutlet var tbEmail : UITextField!
    @IBOutlet var tbFood : UITextField!
    @IBOutlet var avatarOne: UIImageView!
    @IBOutlet var avatarTwo: UIImageView!
    @IBOutlet var avatarThree: UIImageView!
    var selection = 1
    // step 18 - create event handler to insert new row
    @IBAction func avatarOneTap()
    {
        select(selection: 1)
    }
    @IBAction func avatarTwoTap()
    {
        select(selection: 2)
    }
    @IBAction func avatarThreeTap()
    {
        select(selection: 3)
    }
    func select(selection:Int)
    {
        avatarOne.borderWidth = 0
        avatarTwo.borderWidth = 0
        avatarThree.borderWidth = 0
        self.selection = selection
        switch selection {
        case 1:
            avatarOne.borderWidth = 2
            break
        case 2:
            avatarTwo.borderWidth = 2
            break
        default:
            avatarThree.borderWidth = 2
        }
    }
    @IBAction func addPerson(sender : Any)
    {
        // step 18b - instantiate Data object and add textfield data
        let person : Data = Data.init()
        person.initWithData(theRow: 0, theName: tbName.text!, theEmail: tbEmail.text!, theFood: tbFood.text!,theAvatar: "\(selection)")
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // step 18c - do the insert into db
        let returnCode : Bool = mainDelegate.insertIntoDatabase(person: person)
        
        // step 18d - show alert box to indicate success/fail
        var returnMSG : String = "Person Added"
        
        if returnCode == false
        {
            returnMSG = "Person Add Failed"
        }
        
        let alertController = UIAlertController(title: "SQLite Add", message: returnMSG, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
        // move on to step 19
        
    }
    
    // step 8b - create unwind segue method
    @IBAction func unwindToHomeViewController(sender : UIStoryboardSegue)
    {
        
    }
    
    // step 8c - create textFieldShouldReturn for clearing keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // step 9 - create touch method for navigating to sub pages
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
    // this is an alternative way to touching the screen.
    // we could have just used buttons and created a segue and avoided this,
    // however, I wanted to illustrate how to use a touch event
    
    // this method is executed when a user touches the screen
    // at which point a set of touches are returned - each containing pixel locations
    // grab 1 pixel out of the bunch
        let touch : UITouch = touches.first!
    // convert it to an x,y location -> CGPoint type
        let touchPoint : CGPoint = touch.location(in: self.view!)
     
    // get rectangles of both labels on screen that were touchable
        let tableFrame : CGRect = lblTable.frame
        let pickerFrame : CGRect = lbPicker.frame
     
    // check and see if point is within either rectangle
    // call segue to either page.
        if tableFrame.contains(touchPoint)
        {
            // step 19b - save data before segue
            rememberEnteredData()
            performSegue(withIdentifier: "HomeSegueToTable", sender: self)
            
        }
        
        if pickerFrame.contains(touchPoint)
        {
            // step 19b - save data before segue
            rememberEnteredData()
            performSegue(withIdentifier: "HomeSegueToPicker", sender: self)
            
        }
    // move on to TableViewController.swift
    }
    
    // step 19 - lets remember previously entered info
    func rememberEnteredData(){
        let defaults = UserDefaults.standard
        defaults.set(tbName.text, forKey: "lastName")
        defaults.set(tbEmail.text, forKey:"lastEmail")
        defaults.set(tbFood.text, forKey:"lastFood")
        defaults.set("\(selection)", forKey:"lastAvatar")

        defaults.synchronize()
    
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // step 19c - remember previously entered info:
        let defaults = UserDefaults.standard
        
        if let name = defaults.object(forKey: "lastName") as? String {
            tbName.text = name
        }
        if let email = defaults.object(forKey: "lastEmail") as? String {
            tbEmail.text = email
        }
        if let food = defaults.object(forKey: "lastFood") as? String {
            tbFood.text = food
        }
        if let avatar = defaults.object(forKey: "lastAvatar") as? String {
            select(selection: Int(avatar) ?? 1)
        }
        // done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

