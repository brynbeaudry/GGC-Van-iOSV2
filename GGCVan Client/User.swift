//
//  User.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-28.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import Foundation

class User {
    var email : String?
    var password : String?
    public func setEmail(email:String) {
        self.email = email
    }
    public func setPassword(pass: String){
        self.password = pass
    }
    
    static let sharedInstance = User(email: "", password: "")
    private init(email: String, password: String) {} //This prevents others from using the default '()' initializer for this class.
}
