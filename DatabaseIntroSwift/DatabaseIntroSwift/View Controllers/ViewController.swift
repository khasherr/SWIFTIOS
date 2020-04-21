
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBAction func unwindToHomeViewController(sender : UIStoryboardSegue)
    {
        
    }
    
    // step 8c - create textFieldShouldReturn for clearing keyboard
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return textField.resignFirstResponder()
//    }
//
    // step 9 - create touch method for navigating to sub pages
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//    // this is an alternative way to touching the screen.
//    // we could have just used buttons and created a segue and avoided this,
//    // however, I wanted to illustrate how to use a touch event
//    
//    // this method is executed when a user touches the screen
//    // at which point a set of touches are returned - each containing pixel locations
//    // grab 1 pixel out of the bunch
//        let touch : UITouch = touches.first!
//    // convert it to an x,y location -> CGPoint type
//        let touchPoint : CGPoint = touch.location(in: self.view!)
//     
//    // get rectangles of both labels on screen that were touchable
//        let tableFrame : CGRect = lblTable.frame
//        let pickerFrame : CGRect = lbPicker.frame
//     
//    // check and see if point is within either rectangle
//    // call segue to either page.
//        if tableFrame.contains(touchPoint)
//        {
//            // step 19b - save data before segue
//            rememberEnteredData()
//            performSegue(withIdentifier: "HomeSegueToTable", sender: self)
//            
//        }
//        
//        if pickerFrame.contains(touchPoint)
//        {
//            // step 19b - save data before segue
//            rememberEnteredData()
//            performSegue(withIdentifier: "HomeSegueToPicker", sender: self)
//            
//        }
//    // move on to TableViewController.swift
//    }



}

extension UIViewController
{
    
    //hide keyboard with gesture
    func hideKB()
    {
        var tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(hide))
        self.view.addGestureRecognizer(tapGes)
    }
    @objc func hide()
    {
        self.view.endEditing(true)
    }
}
