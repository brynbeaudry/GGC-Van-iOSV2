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
import GoogleSignIn
import Google

#if !Bridge_header_h
    //#define Bridge_header_h
#endif


class LoginViewController: UIViewController, AWSCognitoIdentityPasswordAuthentication, GIDSignInDelegate {
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var avDelegate: AuthViewDelegate?
    let signIn = GIDSignIn.sharedInstance()
    var user : AWSCognitoIdentityUser!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    public var email : String?
    public var password : String = ""
    //var passwordAuthenticationCompletion: AWSTaskCompletionSource = AWSTaskCompletionSource()
    
    @IBAction func googleSignInBtnPress(_ sender: UIButton) {
        signIn?.shouldFetchBasicProfile = true
    }
    
    //Google's Sign In
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            let userId: String = user.userID
            // For client-side use only!
            let idToken: String = user.authentication.idToken
            // Safe to send to the server
            let fullName: String = user.profile.name
            let givenName: String = user.profile.givenName
            let familyName: String = user.profile.familyName
            let email: String = user.profile.email
            let d : [String:String] = [
                "userId":userId,
                "idToken":idToken,
                "fullName":fullName,
                "givenName":givenName,
                "familyName":familyName,
                "email":email
            ]
            //appearantly signed iat this point
            for (name, value) in d {
                print("Back from google Name : \(name)   Value: \(value)")
            }
            
            
            let credentialsProvider = appDelegate.credentialsProvider
            
            //facebook's key is graph.facebook.com
            credentialsProvider?.identityProvider.logins().continueWith(block: {(task) -> AWSTask<NSDictionary>! in
                return AWSTask<NSDictionary>(result: NSDictionary(object: idToken, forKey:"accounts.google.com" as NSCopying))
            }).waitUntilFinished()
            
            
            //credentialsProvider.identityProviderManager.logins = AWSCognitoIdentityGetOpenIdTokenInput.init(dictionary: [idToken], error: )
            self.mainDealwAuthSucess()
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        //using inputs from login UI create an AWSCognitoIdentityPasswordAuthenticationDetails object.
        print("username: \(LoginItems.sharedInstance.email!), password: \(LoginItems.sharedInstance.password!)")
        passwordAuthenticationCompletionSource.set(result: AWSCognitoIdentityPasswordAuthenticationDetails(username: LoginItems.sharedInstance.email!, password: LoginItems.sharedInstance.password!))
    }
    
    //For Email login
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
        self.performSegue(withIdentifier: "navigateToSignUp", sender: self)
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
            self.mainDealwAuthSucess()
            return nil
        })
    }
    
    func mainDealwAuthSucess(){
        DispatchQueue.main.async{
            self.dismiss(animated: true, completion: {
                self.avDelegate = self.appDelegate.window?.rootViewController as? AuthViewDelegate
                self.avDelegate?.authViewDidClose()
            })
    }
    
    func performSegueWithCompletion(id: String, sender: UIViewController, completion: ()->()?){
        self.performSegue(withIdentifier: id, sender: self)
        completion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //LoginCtrl asks google object to remind it to do something
        signIn?.delegate = self;
        signIn?.scopes = ["profile"]
        //pool = appDelegate.pool
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

}
