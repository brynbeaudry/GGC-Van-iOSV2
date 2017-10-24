//
//  SignUpViewController.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-22.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognito

class SignUpViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func backToMain(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        print("Debug pool in Vc \(appDelegate.pool?.debugDescription)")
        
        // Do any additional setup after loading the view.
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
