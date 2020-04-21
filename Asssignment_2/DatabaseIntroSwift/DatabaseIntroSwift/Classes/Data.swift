//
//  Data.swift
//  DatabaseIntroSwift
//
//  Created by Jawaad Sheikh on 2018-09-26.
//  Copyright © 2018 Jawaad Sheikh. All rights reserved.
//

import UIKit

// step 4 - create variables name, email and food,
// step 4b - create constructor initWithData()
// move back to AppDelegate
class Data: NSObject {
    var id : Int?
    var name : String?
    var email : String?
    var food : String?
    var avatar: String?
    func initWithData(theRow i:Int, theName n:String, theEmail e:String, theFood f:String,theAvatar: String="1")
    {
        id = i
        name = n
        email = e
        food = f
        avatar = theAvatar
    }
    
    
}
