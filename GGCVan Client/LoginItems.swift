//
//  LoginItems.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-11-02.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import Foundation

public class LoginItems {
    var email : String?
    var password : String?
    public func setEmail(email:String) {
        self.email = email
    }
    public func setPassword(pass: String){
        self.password = pass
    }
    static let sharedInstance = LoginItems(email: "", password: "")
    private init(email: String, password: String) {} //This prevents others from using the default '()' initializer for this class.
}
