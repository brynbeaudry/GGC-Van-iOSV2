//
//  ViewController.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-20.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import GoogleSignIn
import Google
import FBSDKCoreKit
import FBSDKLoginKit;
import Alamofire;
import EVReflection
import PromiseKit

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
    var login = FBSDKLoginManager()
    var result: FBSDKLoginManagerLoginResult?
    let fbLoginDspGrp = DispatchGroup()
   // var NSError = FBSDKLoginManagerLoginResult()
    
    @IBOutlet weak var FbButton: UIButton!
    
    @IBAction func FbSignInBtnPress(_ sender: Any) {
        self.appDelegate.customIdentityProvider?.loginType = LoginType.FACEBOOK
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginDspGrp.enter()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self, handler: { (result, error) -> Void in
            if (error == nil) {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    print("Facebook is logged in")
                    print("App Id : \n\(fbloginresult.token.appID)\n Token String Id : \n\(fbloginresult.token.tokenString) \nUserId Id : \n\(fbloginresult.token.userID)")
                    print("Granted permissions")
                    for granted in fbloginresult.grantedPermissions {
                        print("\(granted)")
                    }
                }
                //get token from the server
                firstly {
                    self.appDelegate.customIdentityProvider!.token(LoginType.FACEBOOK, email: nil, password: nil)
                    }.then { message in
                        self.fbLoginDspGrp.leave()
                    }.catch { error in
                        print(error)
                        self.fbLoginDspGrp.leave()
                }
            }
        })
        self.fbLoginDspGrp.notify(queue: .main, execute: {
            self.mainDealwAuthSucess()
        })
    }

    
    
    
    @IBAction func googleSignInBtnPress(_ sender: UIButton) {
        appDelegate.customIdentityProvider?.loginType = LoginType.GOOGLE
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
            let userinfo = ["accessibleScopes": user.accessibleScopes, "authentication":user.authentication, "user.serverAuthCode":user.serverAuthCode, "user.userID":user.userID, "user.hostedDomain":user.hostedDomain, "user.authentication.clientID":user.authentication.clientID, "user.authentication.idToken":user.authentication.idToken, "user.authentication.accessToken":user.authentication.accessToken] as [String : Any]
            for item in userinfo {
                print("\(item.key) : \(item.value)")
            }
        } else {
            print("\(error.localizedDescription)")
        }
        firstly {
            appDelegate.customIdentityProvider!.token(LoginType.GOOGLE, email: nil, password: nil)
            }.then { message in
                self.mainDealwAuthSucess()
            }.catch { error in
                print(error)
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
        self.appDelegate.customIdentityProvider?.loginType = LoginType.EMAIL
        //LoginItems.sharedInstance.setEmail(email: tfEmail.text!)
        //LoginItems.sharedInstance.setPassword(pass: tfPassword.text!)
        let _ = [tfEmail.text!, tfPassword.text!]
        let test = ["a@a.a", "qwerty"]
        //  TODO: LOGIN HERE  BY EMAIL
        //let tokenDG = DispatchGroup()
        //tokenDG.enter()
        print("Paarams \(test[0]) \(test[1])")
        firstly {
            appDelegate.customIdentityProvider!.token(LoginType.EMAIL, email: test[0], password: test[1])
        }.then { message -> Void in
            //success message and deal with success
            //tokenDG.leave()
            print(message)
            self.mainDealwAuthSucess()
        }.catch { error in
            print(error)
        }
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

