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

class LoginViewController: UIViewController, AWSCognitoIdentityPasswordAuthentication {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var avDelegate: AuthViewDelegate?
    var user : AWSCognitoIdentityUser!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    public var email : String?
    public var password : String = ""
    //var passwordAuthenticationCompletion: AWSTaskCompletionSource = AWSTaskCompletionSource()
    
    func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        //using inputs from login UI create an AWSCognitoIdentityPasswordAuthenticationDetails object.
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

    @IBAction func navigateToSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "NavigateToSignUp", sender: self)
    }
    /*
    @IBAction func dismissSelf(_ sender: Any) {
        //login shouldn't be able to dismiss self
        self.dismiss(animated: true, completion: nil)
    }
     */

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
            //user logged in because success complete run, dismiss login view controller.
            DispatchQueue.main.async{
                self.dismiss(animated: true, completion: {
                    self.avDelegate = self.appDelegate.window?.rootViewController as? AuthViewDelegate
                    self.avDelegate?.authViewDidClose()
                })
            }
            return nil
        })
    }
    
    func performSegueWithCompletion(id: String, sender: UIViewController, completion: ()->()?){
        self.performSegue(withIdentifier: id, sender: self)
        completion()
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

