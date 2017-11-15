//
//  MainViewController.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-22.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit;
import Alamofire;


class MainViewController: UIViewController, AuthViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var credentialsProvider : AWSCognitoCredentialsProvider!
    
    
    func authViewDidClose() {
        print("\(self.debugDescription) : \(#function)")
        print("In Main after Auth did close delegation")
        if(appDelegate.customIdentityProvider.loginType==LoginType.EMAIL)
        {
            printCurrentUser()
        }
        if(appDelegate.customIdentityProvider.loginType==LoginType.GOOGLE)
        {
            appDelegate.customIdentityProvider.printGoogleUser()
            
        }
        if(appDelegate.customIdentityProvider.loginType==LoginType.FACEBOOK)
        {
            appDelegate.customIdentityProvider.getFBUserData()
            appDelegate.customIdentityProvider.fbLoginManager.logOut()
        }
        
        
        //is authorized
   
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    if let result = result as? [String:Any] {
                        print(result)
                    }
                }
            })
        }
    }
    
    @IBAction func backToMain(segue: UIStoryboardSegue) {
        print("Unwind to Root View Controller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self.debugDescription) : \(#function)")
        
        //without this, it looks like the pool somehow caches the last know user.
        //you should remove this in production
        appDelegate.pool?.clearAll()
        if GIDSignIn.sharedInstance().currentUser != nil {
            GIDSignIn.sharedInstance().disconnect()
        }
        print("after clear")
        //printCurrentUser()
        
        
        // Do any additional setup after loading the view.
        //checkAuthHere
        //not authorized
        if (!isAuth()){
            DispatchQueue.global().sync{
                
            }
            DispatchQueue.main.async{
                self.performSegue(withIdentifier: "modalAuthWall", sender: self)
            }
        }else{
            //is authorized!
            //let cognitoId = credentialsProvider.identityProvider.identityId
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalAuthWall" {
            //_ = nav.topViewController as! UINavigationController
            
            //data
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        //network requests
    }
    
    
    //?? is nil coalescing operator. (returned if not nil) ?? (else return when first term nil)
    func isAuth()-> Bool {
        return appDelegate.customIdentityProvider.isAuthenticated
    }
    
    func printEmailUser() {
        
        //omg, the user persists between app starts
        //gets information from cognito about the current user
        //here, the current user has not been attached to the identity pool
        if (appDelegate.customIdentityProvider.isAuthenticated) {
            
            
            //Printcurrent User
            
        }else{
            print("There is no current user")
        }
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
