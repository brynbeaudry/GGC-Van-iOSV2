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
    var avDelegate: AuthViewDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        //using inputs from login UI create an AWSCognitoIdentityPasswordAuthenticationDetails object.
        //These values are hardcoded for this example.
        print("username: \(LoginItems.sharedInstance.email!), password: \(LoginItems.sharedInstance.password!)")
        passwordAuthenticationCompletionSource.set(result: AWSCognitoIdentityPasswordAuthenticationDetails(username: LoginItems.sharedInstance.email!, password: LoginItems.sharedInstance.password!))
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
                //we are logged in
                print("LOGGED IN")
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
                    //if the user needs verification
                    if (!Bool(truncating: (response.result?.userConfirmed)!)) {
                        print("User Not confirmed")
                        // User needs confirmation, so we need to proceed to the verify view controller
                        DispatchQueue.main.async {
                            //self.performSegue(withIdentifier: "VerifySegue", sender: self)
                        }
                    } else {
                        // User signed up but does not need verification
                        // basically, you signed up sucessfully
                        print("User Debug no verification: \(response.result!.user)")
                        
                        //set login items
                        LoginItems.sharedInstance.setEmail(email: self.email.text!)
                        LoginItems.sharedInstance.setPassword(pass: self.password.text!)
                        
                        //authenticate user
                        
                    self.appDelegate.pool?.getUser().getDetails().continueOnSuccessWith(block: {(_ task: AWSTask<AWSCognitoIdentityUserGetDetailsResponse>) -> Any? in
                            //continue with success operation for signin
                            let response: AWSCognitoIdentityUserGetDetailsResponse? = task.result
                            print("response: \(response.debugDescription)")
                            for attribute in (response?.userAttributes)! {
                                //print the user attributes
                                print("Attribute: \(attribute.name ?? "none") Value: \(attribute.value ?? "none")")
                            }
                            //unwind to main area
                            DispatchQueue.main.async {
                                print("Self view controller. \(self.debugDescription)")
                                //performuniwnd segue
                                
                                //self.performSegue(withIdentifier: "unwindToMain", sender: self)
                                let completion = {
                                    self.avDelegate = self.appDelegate.window?.rootViewController as? AuthViewDelegate
                                    self.avDelegate?.authViewDidClose()
                                }
                                self.performSegueWithCompletion(id: "unwindToMain", sender: self, completion: completion)
                            }
                            return nil
                        })
                    }
                }
                return nil
            }
        }
        
    }
    
    func performSegueWithCompletion(id: String, sender: UIViewController, completion: ()->()?){
        self.performSegue(withIdentifier: id, sender: self)
        completion()
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
