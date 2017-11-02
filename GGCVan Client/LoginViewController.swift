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

public class LoginItems {
    var email : String?
    var password : String?
    public func setEmail(email:String) {
        self.email = email
    }
    public func setPassword(pass: String){
        self.password = pass
    }
    static let sharedInstance = LoginItems()
    private init() {} //This prevents others from using the default '()' initializer for this class.
}

class LoginViewController: UIViewController, AWSCognitoIdentityPasswordAuthentication {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var user : AWSCognitoIdentityUser!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    public var email : String?
    public var password : String = ""
    //var passwordAuthenticationCompletion: AWSTaskCompletionSource = AWSTaskCompletionSource()
    
    func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        //using inputs from login UI create an AWSCognitoIdentityPasswordAuthenticationDetails object.
        //These values are hardcoded for this example.
        //print("username: \(tfEmail.text!), password: \(tfPassword.text!)")
        print("username: \(LoginItems.sharedInstance.email!), password: \(LoginItems.sharedInstance.password!)")
        passwordAuthenticationCompletionSource.set(result: AWSCognitoIdentityPasswordAuthenticationDetails(username: LoginItems.sharedInstance.email!, password: LoginItems.sharedInstance.password!))
        //self.passwordAuthenticationCompletion.set(result: result)
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
                DispatchQueue.main.async{
                   self.dismiss(animated: true)
                }
            }
        })
    }

    @IBAction func gotoSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUp", sender: self)
    }
    @IBAction func dismissSelf(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func loginPressed(_ sender: Any) {
        LoginItems.sharedInstance.setEmail(email: tfEmail.text!)
        LoginItems.sharedInstance.setPassword(pass: tfPassword.text!)
        appDelegate.pool?.getUser().getDetails().continueOnSuccessWith(block: {(_ task: AWSTask<AWSCognitoIdentityUserGetDetailsResponse>) -> Any?  in
            let response: AWSCognitoIdentityUserGetDetailsResponse? = task.result
            print("response: \(response.debugDescription)")
            for attribute in (response?.userAttributes)! {
                //print the user attributes
                print("Attribute: \(attribute.name ?? "none") Value: \(attribute.value ?? "none")")
            }
            return nil
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //pool = appDelegate.pool
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

