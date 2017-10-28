//
//  ViewController.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-20.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider

class LoginViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var user : AWSCognitoIdentityUser!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    @IBAction func gotoSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUp", sender: self)
    }
    @IBAction func dismissSelf(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func loginPressed(_ sender: Any) {
        // Get a reference to the user pool
        let userPool = appDelegate.pool
        // Collect all of the attributes that should be included in the signup call
        let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: tfEmail.text!)
        let userNameAttribute = AWSCognitoIdentityUserAttributeType(name: "preferred_username", value: tfPassword.text!)
        //check password
            // Actually make the signup call passing in those attributes
            userPool?.signUp(UUID().uuidString, password: tfPassword.text!, userAttributes: [emailAttribute, userNameAttribute], validationData: nil)
                .continueWith { (response) -> Any? in
                    if response.error != nil {
                        // Error in the signup process
                        let alert = UIAlertController(title: "Error", message: response.error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.user = response.result!.user
                        // Does user need verification?
                        if (Int(truncating: (response.result?.userConfirmed)!) != (AWSCognitoIdentityUserStatus.confirmed.rawValue)) {
                            // User needs confirmation, so we need to proceed to the verify view controller
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "VerifySegue", sender: self)
                            }
                        } else {
                            // User signed up but does not need verification
                            print("User : \(self.user.debugDescription)")
                            DispatchQueue.main.async {
                                self.presentingViewController?.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                    return nil
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

