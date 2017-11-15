//
//  GoogleCredentialsProviderHelper.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-11-05.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import Foundation
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider
import GoogleSignIn
import Google
import FBSDKCoreKit
import FBSDKLoginKit;
import Alamofire;

public enum LoginType {
    case EMAIL, GOOGLE, FACEBOOK, NONE
}

class CustomIdentityProvider : NSObject {
    public var loginType : LoginType = LoginType.EMAIL
    public var isAuthenticated : Bool = false;
    var avDelegate: AuthViewDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let googleSignIn = GIDSignIn.sharedInstance()
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    var loginDictionary = [LoginType : String]()
    var currentAWSUser : AWSCognitoIdentityUser?
    var currentAccessToken : String?
    var currentIdentityId : String?
    var currentAuthorizationToken : String?
    
    private override init(){}
    static let sharedInstance = CustomIdentityProvider()
    
    //get contacts service for token
    //tokenForTheServer
    func token() -> [LoginType : String] {
        
        switch self.loginType {
        //getUser, gets blank user.
            case LoginType.EMAIL:
                return [LoginType.EMAIL: currentAccessToken!]
            case LoginType.GOOGLE:
                return [LoginType.GOOGLE: currentAccessToken!]
            case LoginType.FACEBOOK:
                return [LoginType.FACEBOOK: currentAccessToken!]
            default:
                return [LoginType.NONE: ""]
        }
    }
    
        
        //Google's Sign In
        //Enter this function when google comes back
        func printGoogleUser() {
            if googleSignIn?.currentUser?.userID != nil {
                //Store the token
                let user = googleSignIn!.currentUser!
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
                    print("Google User Key : \(name)   Value: \(value)")
                }
               
                //possible put into static user object here
                //to later upload to the server
                
            } else {
                print("no google user")
            }
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
}
