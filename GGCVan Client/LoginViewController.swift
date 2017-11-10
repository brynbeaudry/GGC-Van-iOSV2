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


class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var avDelegate: AuthViewDelegate?
    let googleSignIn = GIDSignIn.sharedInstance()
    var user : AWSCognitoIdentityUser!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    
    @IBAction func googleSignInBtnPress(_ sender: UIButton) {
        appDelegate.customIdentityProvider?.loginType = "GOOGLE"
        googleSignIn?.signIn()
    }
    
    
    //did disconnect, maybe for legacy, probably for logout
    func sign(_ signIn: GIDSignIn, didDisconnectWith user: GIDGoogleUser) throws {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    //Enter this function when google comes back
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("\(self.debugDescription) : \(#function)")
        print("In Signin after Google")
        if error == nil {
            
            
            /*   REGISTERATION WITH USERNAME AND PASSWORD WORKS TO SIGN IN USER  */
            /*   LOGIN WITH USERNAME AND PASSWORD WORKS TO SIGN IN USER  */
            /*   IT GETS */
            
            
            //No errors after google signin
            //identity provider get the google token
            
            
            //here is our google user.
            
            
            //this is the pool object
            
            appDelegate.customIdentityProvider?.currentAccessToken = user.authentication.accessToken!
            
            print("AccessToken in google \(String(describing: signIn.currentUser?.authentication.accessToken)) Decription \(signIn.currentUser.authentication.description )")
            appDelegate.pool?.getUser(signIn.currentUser.userID).getSession().continueWith(block: {(task:AWSTask<AWSCognitoIdentityUserSession>) -> Any? in
                if((task.error) == nil){
                    let response: AWSCognitoIdentityUserSession? = task.result
                    print("Access Token : from pool \(String(describing: response!.accessToken)) \n Id Token from pool: \(String(describing: response!.idToken)) \n Refresh Token from pool : \n \(String(describing: response!.refreshToken))")
                        self.appDelegate.credentialsProvider?.getIdentityId()
                        self.mainDealwAuthSucess()
                }else{
                    print("Didn't get token from pool session")
                }
                return nil
            })
            self.mainDealwAuthSucess()
        } else {
            print("\(error.localizedDescription)")
        }
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
    
    //for regular email
    @IBAction func loginPressed(_ sender: Any) {
        LoginItems.sharedInstance.setEmail(email: tfEmail.text!)
        LoginItems.sharedInstance.setPassword(pass: tfPassword.text!)
        appDelegate.customIdentityProvider?.loginType = "EMAIL"
        appDelegate.customIdentityProvider?.token().continueOnSuccessWith(block: {(task : AWSTask<NSString>) -> Void in
            //appDelegate.customIdentityProvider?.token() This will print a string
            print("Result Token :  \(task.result ?? "no result!")" )
            self.appDelegate.customIdentityProvider?.currentAccessToken = task.result as String?
            self.mainDealwAuthSucess()
        })
    }
    
    func mainDealwAuthSucess(){
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
                self.avDelegate = self.appDelegate.window?.rootViewController as? AuthViewDelegate
                self.avDelegate?.authViewDidClose()
            })
        }
    }
    
    func performSegueWithCompletion(id: String, sender: UIViewController, completion: ()->()?){
        self.performSegue(withIdentifier: id, sender: self)
        completion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //LoginCtrl asks google object to remind it to do something
        //googleSignIn?.delegate = self
        googleSignIn?.uiDelegate = self
        googleSignIn?.scopes = ["profile"]
        //pool = appDelegate.pool
        googleSignIn?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

