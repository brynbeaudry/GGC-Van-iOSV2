//
//  MainViewController.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-22.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit;
import Alamofire;


class MainViewController: UIViewController, AuthViewDelegate {
    
    let AD = UIApplication.shared.delegate as! AppDelegate
    
    
    func authViewDidClose() {
        print("\(self.debugDescription) : \(#function)")
        print("In Main after Auth did close delegation")
        if(AD.customIdentityProvider?.loginType==LoginType.EMAIL)
        {
            
            AD.customIdentityProvider?.printEmailUser()
            //lgout
        }
        if(AD.customIdentityProvider?.loginType==LoginType.GOOGLE)
        {
            if GIDSignIn.sharedInstance().currentUser != nil {
                AD.customIdentityProvider?.printGoogleUser()
                
                //disable when real
                GIDSignIn.sharedInstance().disconnect()
            }
            print("after clear")
            //printCurrentUser()
            
        }
        if(AD.customIdentityProvider?.loginType==LoginType.FACEBOOK)
        {
            if(FBSDKAccessToken.current().userID != nil){
                AD.customIdentityProvider?.getFBUserData() //waits
                
                //disable when real
                AD.customIdentityProvider?.fbLoginManager.logOut()
            }
        }
        
        //Print token
        if(AD.customIdentityProvider?.currentToken != nil){
            print("Attempting to print current token :")
            AD.customIdentityProvider?.printCurrentToken()
        }
        
        //reset token, reset auth wall
        /*
        //set unautheticated
        self.AD.customIdentityProvider?.isAuthenticated = false
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        //put the auth wall back up for testing
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.performSegue(withIdentifier: "modalAuthWall", sender: self)
        }
        */
        
        //is authorized, goto User Area
        if (AD.customIdentityProvider?.isAuthenticated)! {
            self.performSegue(withIdentifier: "GotoUserArea", sender: self)
        }
        
        
   
    }
    
    func getFBUserData(){
        DispatchQueue.global().sync {
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
    }
    
    @IBAction func backToMain(segue: UIStoryboardSegue) {
        print("Unwind to Root View Controller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self.debugDescription) : \(#function)")
        
        
        //clear credentials
        //you should remove this in production
        self.AD.customIdentityProvider?.isAuthenticated = false
        if GIDSignIn.sharedInstance().currentUser != nil {
            GIDSignIn.sharedInstance().disconnect()
        }
        let fbAccessToken = FBSDKAccessToken.current() ?? nil
        if fbAccessToken != nil {
            AD.customIdentityProvider?.fbLoginManager.logOut()
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
        return AD.customIdentityProvider?.isAuthenticated ?? false
    }
    
    func printEmailUser() {
        
        //omg, the user persists between app starts
        //gets information from cognito about the current user
        //here, the current user has not been attached to the identity pool
        if (AD.customIdentityProvider?.isAuthenticated)! {
            
            
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
