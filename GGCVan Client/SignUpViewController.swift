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

class SignUpViewController: UIViewController, AWSCognitoIdentityPasswordAuthentication {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    var passwordAuthenticationCompletion : AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>!
    
    func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        //using inputs from login UI create an AWSCognitoIdentityPasswordAuthenticationDetails object.
        //These values are hardcoded for this example.
        let result = AWSCognitoIdentityPasswordAuthenticationDetails(username: email.text!, password: password.text!)
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource;
        self.passwordAuthenticationCompletion.set(result: result)
    }
    
    func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async(execute: {() -> Void in
            //present error to end user
            if error != nil {
                let alert = UIAlertController.init(title: (error?.localizedDescription)!, message: (error?.localizedDescription)!, preferredStyle: .alert)
                self.present(alert, animated: true)
            }
            else {
                //dismiss view controller
                self.dismiss(animated: true)
            }
        })
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        // Get a reference to the user pool
        // Collect all of the attributes that should be included in the signup call
        let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: email.text!)
        let userNameAttribute = AWSCognitoIdentityUserAttributeType(name: "preferred_username", value: userName.text!)
        //check password
        if(password.text == passwordConfirm.text){
        // Actually make the signup call passing in those attributes
            appDelegate.pool?.signUp(email.text!, password: password.text!, userAttributes: [emailAttribute, userNameAttribute], validationData: nil)
            .continueWith { (response) -> Any? in
                if response.error != nil {
                    // Error in the signup process
                    let alert = UIAlertController(title: "Error", message: response.error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // Does user need verification?
                    print("Response Result : \(String(describing: response.result))")
                    if (!Bool(truncating: (response.result?.userConfirmed)!)) {
                        print("User Not confirmed")
                        // User needs confirmation, so we need to proceed to the verify view controller
                        DispatchQueue.main.async {
                            //self.performSegue(withIdentifier: "VerifySegue", sender: self)
                        }
                    } else {
                        // User signed up but does not need verification
                        //basically, you signed in
                        print("User Debug no verification: \(response.result!.user)")
                        
                        //authenticate user
                        
                        
                        DispatchQueue.main.async {
                            print("Self view controller. \(self.debugDescription)")
                            self.performSegue(withIdentifier: "unwindToMain", sender: self)
                            //self.performSegue(withIdentifier: "unwindToMain", sender: self)
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
