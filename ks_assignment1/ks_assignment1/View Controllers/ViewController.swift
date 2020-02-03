//
//  ViewController.swift
//  ks_assignment1
//
//  Created by Xcode User on 2020-02-02.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var myWebkitButton: UIButton!
    @IBOutlet weak var myAboutButton: UIButton!
    @IBOutlet weak var myRegisterButton: UIButton!
    
    
    @IBAction func unwindToHomeView (sender : UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myRegisterButton.layer.cornerRadius = 10
        myAboutButton.layer.cornerRadius = 10
        
        myWebkitButton.layer.cornerRadius = 10
    }


}

