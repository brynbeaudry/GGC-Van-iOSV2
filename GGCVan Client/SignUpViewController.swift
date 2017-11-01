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
import AWSCognitoIdentityProvider

class SignUpViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var user : AWSCognitoIdentityUser!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    @IBAction func signupPressed(_ sender: Any) {
        // Get a reference to the user pool
        let userPool = appDelegate.pool
        // Collect all of the attributes that should be included in the signup call
        let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: email.text!)
        let userNameAttribute = AWSCognitoIdentityUserAttributeType(name: "preferred_username", value: userName.text!)
        //check password
        if(password.text == passwordConfirm.text){
        // Actually make the signup call passing in those attributes
            userPool?.signUp(email.text!, password: password.text!, userAttributes: [emailAttribute, userNameAttribute], validationData: nil)
            .continueWith { (response) -> Any? in
                if response.error != nil {
                    // Error in the signup process
                    let alert = UIAlertController(title: "Error", message: response.error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.user = response.result!.user
                    // Does user need verification?
                    if (!Bool(truncating: (response.result?.userConfirmed)!)) {
                        print("User Not confirmed")
                        // User needs confirmation, so we need to proceed to the verify view controller
                        DispatchQueue.main.async {
                            //self.performSegue(withIdentifier: "VerifySegue", sender: self)
                        }
                    } else {
                        // User signed up but does not need verification
                        print("User Debug no verification: \(self.user.debugDescription)")
                        DispatchQueue.main.async {
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                            //performSegue(withIdentifier: "unwindToMain", sender: self)
                        }
                    }
                }
                return nil
            }
        }
        
    }
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
