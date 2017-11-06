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
/*
class GoogleOIDCProvider: NSObject, AWSIdentityProviderManager {
    func logins() -> AWSTask<NSDictionary> {
        let completion = AWSTaskCompletionSource<NSString>()
        getToken(tokenCompletion: completion)
        return completion.task.continueOnSuccessWith { (task) -> AWSTask<NSDictionary>? in
            //login.provider.name is the name of the OIDC provider as setup in the Cognito console
            return AWSTask(result:["accounts.google.com":task.result!])
            } as! AWSTask<NSDictionary>
    }
    
    func getToken(tokenCompletion: AWSTaskCompletionSource<NSString>) -> Void {
        //get a valid oidc token from your server, or if you have one that hasn't expired cached, return it
        
        //TODO code to get token from your server
        //...
        
        //if error getting token, set error appropriately
        tokenCompletion.set(error:NSError(domain: "OIDC Login", code: -1 , userInfo: ["Unable to get OIDC token" : "Details about your error"]))
        //else
        tokenCompletion.set(result:"result from server id token")
    }
}
 */


class LoginViewController: UIViewController, AWSCognitoIdentityPasswordAuthentication, GIDSignInDelegate, GIDSignInUIDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var avDelegate: AuthViewDelegate?
    let googleSignIn = GIDSignIn.sharedInstance()
    var user : AWSCognitoIdentityUser!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    public var email : String?
    public var password : String = ""
    //var passwordAuthenticationCompletion: AWSTaskCompletionSource = AWSTaskCompletionSource()
    
    @IBAction func googleSignInBtnPress(_ sender: UIButton) {
        appDelegate.customIdentityProvider?.loginType = "GOOGLE"
        googleSignIn?.signIn()
    }
    
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    
    
    //did disconnect, maybe for legacy, probably for logout
    func sign(_ signIn: GIDSignIn, didDisconnectWith user: GIDGoogleUser) throws {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    /*
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        actIndicator?.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the sign in with Google view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
 */
    
    //Google's Sign In
    //Enter this function when google comes back
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            //possible put into static user object here
            //to later upload to the server
            //facebook's key is graph.facebook.com
            //Store the token
            appDelegate.customIdentityProvider?.loginType = "GOOGLE"
            
            appDelegate.customIdentityProvider?.logins().continueOnSuccessWith(block: {(task : AWSTask<NSDictionary>) -> Any? in
                if((task.error) != nil){
                    self.mainDealwAuthSucess()
                    return nil
                }else{
                    return self.appDelegate.customIdentityProvider?.token()
                }
            })

            /*
            credentialsProvider.logins().continueOnSuccessWith(block: {() -> AWSTask<NSDictionary>! in
                return AWSTask<NSDictionary>(result: NSDictionary(dictionary: ["accounts.google.com":idToken]))
            }).waitUntilFinished()
             */
            //self.mainDealwAuthSucess()
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    //for regular sign in
    func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        //using inputs from login UI create an AWSCognitoIdentityPasswordAuthenticationDetails object.
        print("username: \(LoginItems.sharedInstance.email ?? "none entered"), password: \(LoginItems.sharedInstance.password ?? "none entered")")
        if(LoginItems.sharedInstance.email != nil){
            passwordAuthenticationCompletionSource.set(result: AWSCognitoIdentityPasswordAuthenticationDetails(username: LoginItems.sharedInstance.email!, password: LoginItems.sharedInstance.password!))
        }
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
                self.mainDealwAuthSucess()
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
    
    //for regular email
    @IBAction func loginPressed(_ sender: Any) {
        LoginItems.sharedInstance.setEmail(email: tfEmail.text!)
        LoginItems.sharedInstance.setPassword(pass: tfPassword.text!)
        appDelegate.customIdentityProvider?.loginType = "EMAIL"
        appDelegate.pool?.getUser().getDetails().continueOnSuccessWith(block: {(task : AWSTask<AWSCognitoIdentityUserGetDetailsResponse>) -> Void in
            //appDelegate.customIdentityProvider?.token()
                print(task.result ?? "no result!")
        })
    }
    
    func mainDealwAuthSucess(){
        DispatchQueue.main.async{
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
        actIndicator.stopAnimating()
        
        //LoginCtrl asks google object to remind it to do something
        googleSignIn?.delegate = self
        googleSignIn?.uiDelegate = self
        googleSignIn?.scopes = ["profile"]
        //pool = appDelegate.pool
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

