//
//  TokenResponse.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-11-18.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import Foundation
import EVReflection

public class Token : EVObject {
    //self.PrintOptions.Active = .All
    var scope: String = ""
    var token_type: String = ""
    var access_token: String = ""
    var expires_in: Int = 0
    var refresh_token: String = ""
    var id_token: String = ""
    var resource: String = ""
}
