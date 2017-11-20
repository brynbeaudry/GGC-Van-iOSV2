//
//  User.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-28.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import Foundation

class User {
    var username : String?
    var password : String?
    var emailId : String?
    var googleId : String?
    public func setUsername(username:String) {
        self.username = username
    }
    
    public func setPassword(pass: String){
        self.password = pass
    }
    public func setGoogleId(id: String){
        self.googleId = id
    }
    
    public func setEmailId(id : String){
        self.emailId = id
    }
    
    static let sharedInstance = User()
    private init() {} //This prevents others from using the default '()' initializer for this class.
}
