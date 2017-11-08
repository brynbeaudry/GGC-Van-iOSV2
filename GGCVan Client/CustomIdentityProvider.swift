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

class CustomIdentityProvider : AWSCognitoCredentialsProviderHelper {
    public var loginType : String = "EMAIL"
    var avDelegate: AuthViewDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let googleSignIn = GIDSignIn.sharedInstance()
    var loginDictionary = [String: String]()
    var currentAWSUser : AWSCognitoIdentityUser?
    var currentAccessToken : String?
    //could just create own user, and store the token
    //but, pool, comes with its own current user. Idenitty provider should have access to the pool
    //yes, its initialized with a poolId

    
    //get contacts service for token
    override func token() -> AWSTask<NSString> {
        //Write code to call your backend:
        /*
         return isCurrentUser.getSession().continue(withSuccessBlock: {(_ task: AWSTask<AWSCognitoIdentityUserSession>) -> Any in
         return AWSTask(result: task.result.idToken.tokenString)
         })
         */
        //pass username/password to backend or some sort of token to authenticate user, if successful,
        switch self.loginType {
        //getUser, gets blank user.
        case "EMAIL":
            return appDelegate.pool?.getUser().getSession(LoginItems.sharedInstance.email ?? " ", password: LoginItems.sharedInstance.password ?? " ", validationData: nil).continueOnSuccessWith(block: {(_ task: AWSTask<AWSCognitoIdentityUserSession>) -> AWSTask<NSString>?  in
                if task.error != nil {
                    return AWSTask(result: "ERROR")
                }else{
                    let response: AWSCognitoIdentityUserSession? = task.result
                    print("Access Token : \(response!.accessToken) \n Id Token : \(response!.idToken) \n Refresh Token : \n \(response!.refreshToken)")
                    self.identityId = response!.idToken?.tokenString
                    return AWSTask<NSString>(result: response!.accessToken!.tokenString as NSString)
                }
            }) as! AWSTask<NSString>
                case "GOOGLE":
                    //I'm expecting get session to get the token from logins
                return appDelegate.pool?.getUser().getSession().continueOnSuccessWith(block: {(task : AWSTask<AWSCognitoIdentityUserSession>) -> AWSTask<NSString>? in
                    if task.error != nil {
                        return AWSTask(result: "ERROR")
                    }else{
                        let response: AWSCognitoIdentityUserSession? = task.result
                        print("Access Token : \(response!.accessToken) \n Id Token : \(response!.idToken) \n Refresh Token : \n \(response!.refreshToken)")
                        self.identityId = response!.idToken?.tokenString
                        return AWSTask<NSString>(result: response!.accessToken!.tokenString as NSString)
                    }
                }) as! AWSTask<NSString>
                    case "FACEBOOK":
                    print("You are choosing Facebook")
                    return super.token()
                    default:
                    print("something ain't right")
                    return super.token()
        }
    }
        
        //get the token the first time and set logins information, calls token probably
        //pass in the token here
        override func logins () -> AWSTask<NSDictionary> {
            switch self.loginType {
            case "EMAIL":
                if let token = self.currentAccessToken {
                    return AWSTask(result:[AWSIdentityProviderAmazonCognitoIdentity:token])
                }
                return AWSTask(error:NSError(domain: "Facebook Login", code: -1 , userInfo: ["Facebook" : "No current Facebook access token"]))
            case "GOOGLE":
                if let token = self.currentAccessToken {
                    return AWSTask(result: [AWSIdentityProviderGoogle:token])
                }
                return AWSTask(error:NSError(domain: "Facebook Login", code: -1 , userInfo: ["Facebook" : "No current Facebook access token"]))
            case "FACEBOOK":
                if let token = self.currentAccessToken {
                    return AWSTask(result: [AWSIdentityProviderFacebook:token])
                }
                return AWSTask(error:NSError(domain: "Facebook Login", code: -1 , userInfo: ["Google" : "No current Google access token"]))
            default:
                print("You reachdefault")
            }
            return super.logins()
            
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
}
