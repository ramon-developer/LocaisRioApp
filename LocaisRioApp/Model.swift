//
//  Model.swift
//  LocaisRioApp
//
//  Created by Ramon dos Santos on 14/05/17.
//  Copyright © 2017 Ebix American Latin. All rights reserved.
//

import Foundation
import UIKit




//place
class Place: NSObject {
    
    let name: String!
    let district: String!
    let imageStr: String!
    let descript: String!
    
    init(name:String,district:String,img:String,description:String) {
        self.name = name
        self.district = district
        self.imageStr = img
        self.descript = description
    }
}

struct Place2 {
    
    let name: String!
    let district: String!
    let imageStr: String!
    let descript: String!
    
    init(name:String,district:String,img:String,description:String) {
        self.name = name
        self.district = district
        self.imageStr = img
        self.descript = description
    }
}



//access
class Access: NSObject {
    
    let email: String!
    let password: String!
    
    init(email:String,password:String) {
        self.email = email
        self.password = password
    }
}

struct Access2 {
    
    let email: String!
    let password: String!
    
    init(email:String,password:String) {
        self.email = email
        self.password = password
    }
}
