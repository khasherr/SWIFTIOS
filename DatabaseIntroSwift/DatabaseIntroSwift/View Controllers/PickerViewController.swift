

import UIKit

// step 13 - add picker view delegates
class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // step 14 - add app delegate as we will need it throughout the class
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var tbName : UITextField!
    @IBOutlet var tbAge : UITextField!
    @IBOutlet var avatarOne: UIImageView!
    @IBOutlet var avatarTwo: UIImageView!
    @IBOutlet var avatarThree: UIImageView!
    @IBOutlet var picker: UIPickerView!
    var selection = 1
    var selectedPerson:DataC?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainDelegate.readDataFromDatabase()
        selectedPerson = mainDelegate.people.first
        self.hideKB()
        // step 19c - remember previously entered info:
        let defaults = UserDefaults.standard
        
        if let name = defaults.object(forKey: "lastName") as? String {
            tbName.text = name
        }
        if let email = defaults.object(forKey: "lastEmail") as? String {
            tbAge.text = email
        }
        
        if let avatar = defaults.object(forKey: "lastAvatar") as? String {
            select(selection: Int(avatar) ?? 1)
        }
        // done
    }
    func reload()
    {
        mainDelegate.readDataFromDatabase()
        picker.reloadAllComponents()
    }
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
    @IBAction func insert()
    {
       // step 18b - instantiate Data object and add textfield data
        
        // let person = DataC(id: 0, name: tbName.text!, email: tbEmail.text!, food: tbFood.text!, avatar: "\(selection)")
       addPerson()
       reload()
        // move on to step 19
    }
    func addPerson()
    {
        let person = DataC.init(id: 0, name: tbName.text!, age:Int32(tbAge.text!) ?? 0, avatar: "\(selection)")
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // step 18c - do the insert into db
        let returnCode : Bool = mainDelegate.insertIntoDatabase(person: person!)
        
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
    }
    @IBAction func update()
    {
        if let person = selectedPerson
        {
            updatePerson()
        }
        else
        {
            self.addPerson()
        }
        reload()
    }
    func updatePerson()
    {
        let person = DataC.init(id: selectedPerson!.id, name: tbName.text!, age:Int32(tbAge.text!) ?? 0, avatar: "\(selection)")
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // step 18c - do the insert into db
        let returnCode : Bool = mainDelegate.updateDB(person: person!)
        
        // step 18d - show alert box to indicate success/fail
        var returnMSG : String = "Person Updated"
        
        if returnCode == false
        {
            returnMSG = "Person update Failed"
        }
        
        let alertController = UIAlertController(title: "SQLite Update", message: returnMSG, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
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
  
    
    // step 19 - lets remember previously entered info
    func rememberEnteredData(){
        let defaults = UserDefaults.standard
        defaults.set(tbName.text, forKey: "lastName")
        defaults.set(tbAge.text, forKey:"lastEmail")
        defaults.set("\(selection)", forKey:"lastAvatar")
        
        defaults.synchronize()
        
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
        
        let alertController = UIAlertController(title: mainDelegate.people[row].name, message: "\(mainDelegate.people[row].age)", preferredStyle: .alert)
        selectedPerson = mainDelegate.people[row]
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
