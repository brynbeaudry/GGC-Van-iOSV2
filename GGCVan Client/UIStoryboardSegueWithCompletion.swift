//
//  UIStoryboardSegueWithCompletion.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-11-02.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import Foundation
import UIKit

class UIStoryboardSegueWithCompletion: UIStoryboardUnwindSegueSource {
    var completion: (() -> Void)?
    
    init(){
        super.init()
    }
    
    override func perform() {
        super.perform()
        if let completion = completion {
            completion()
        }
    }
}
