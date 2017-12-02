//
//  GoogleCredentialsProviderHelper.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-11-05.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import Foundation
import GoogleSignIn
import Google
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import PromiseKit
import EVReflection
import SwiftyJSON

public enum LoginType {
    case EMAIL, GOOGLE, FACEBOOK, NONE
}

class CustomIdentityProvider : NSObject {
    public var loginType : LoginType = LoginType.EMAIL
    public var isAuthenticated : Bool = false;
    var avDelegate: AuthViewDelegate?
    let AD = UIApplication.shared.delegate as! AppDelegate
    let googleSignIn = GIDSignIn.sharedInstance()
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    var loginDictionary = [LoginType : String]()
    var currentAccessToken : String?
    var currentIdentityId : String?
    var currentAuthorizationToken : String?
    let LOCALHOST = "http://localhost:54321"
    var currentToken : Token?
    let tokenDG = DispatchGroup()
    
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
    
    func printEmailUser() {
        
        //omg, the user persists between app starts
        //gets information from cognito about the current user
        //here, the current user has not been attached to the identity pool
        if (self.isAuthenticated && self.loginType == LoginType.EMAIL) {
            
            
            //Printcurrent User
            
        }else{
            print("There is no current user")
        }
    }
    
    
    func token( _ with: LoginType, email: String, password : String) -> Promise<Any> {
        let url = "\(AD.BASE_URL)/connect/token"
        print("email \(email)  password: \(password)")
        switch AD.customIdentityProvider?.loginType {
        case .EMAIL?:
            let headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let parameters  = [
                "grant_type": "password",
                "password": password,
                "username": email,
                "response_type" : "code"
            ]
            //test paramas
            
            return Alamofire.request(url, method: .post, parameters: parameters, headers: headers ).responseJSON()
                .then { resp in
                    print(resp)
                    let json = JSON(resp)
                    if json["error_description"] == JSON.null {
                        self.currentToken = Token(json: json.rawString()!)
                        print("Current Access Token \(self.currentToken?.access_token ?? "No current Access Token")")
                        self.isAuthenticated = true
                        return Promise(value: "EMAIL_LOGIN_SUCCESS")
                    }else{
                        return Promise(value: "EMAIL_LOGIN_FAILURE")
                    }
                }.catch{ error in
                    print(error)
                }
            case .GOOGLE? :
                let parameters: Parameters = [
                    "response_type": "code",
                    "scope": "openid profile email",
                    "grant_type": "urn:ietf:params:oauth:grant-type:google_identity_token",
                    "assertion" : googleSignIn?.currentUser.authentication.idToken ?? "error",
                    ]
                return Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding() ).responseString()
                    .then { json in
                        let tokenResponse = Token(json : json)
                        self.currentToken = tokenResponse
                        print("Current Access Token \(self.currentToken?.access_token ?? "No current Access Token")")
                        self.isAuthenticated = true
                        return Promise(value: "GOOGLE_LOGIN_SUCCESS")
                    }.catch{ error in
                        print(error)
                    }
            case .FACEBOOK? :
                let parameters: Parameters = [
                    "response_type": "code",
                    "scope": "openid profile email",
                    "grant_type": "urn:ietf:params:oauth:grant-type:facebook_access_token",
                    "assertion" : FBSDKAccessToken.current().tokenString ?? "error",
                    ]
                return Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding() ).responseString()
                    .then { json in
                        let tokenResponse = Token(json : json)
                        self.currentToken = tokenResponse
                        print("Current Access Token \(self.currentToken?.access_token ?? "No current Access Token")")
                        self.isAuthenticated = true
                        return Promise(value: "FACEBOOK_LOGIN_SUCCESS")
                    }.catch{ error in
                        print(error)
                    }
            default :
                return Promise(value: "error")
        }
    }
    
    public func printCurrentToken() {
        let obj = self.currentToken
        let aMirror = Mirror(reflecting: obj!)
        for (label, value) in aMirror.children {
            print(label ?? "label is null", value)
        }
    }
    
    func signUp(email: String, password: String, username : String) -> Promise<String> {
        let url = "\(AD.BASE_URL)/api/register"
        let parameters: Parameters = [
            "email": email,
            "password": password,
            "username" : username
            ]
        return Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding() ).responseJSON()
            .then { resp in
                let json = JSON(resp)
                if json["succeeded"] == true {
                    return Promise(value: "SUCCESS" )
                }else{
                    if let first_error = json["errors"].array?[0] {
                        return Promise(value : first_error["description"].stringValue)
                    }
                    return Promise(value : "wtf")
                }
            }
    }
        /*
        return firstly {
            Alamofire.request(url, method: .post).responseData()
            }.then(on: q) { (data : Data) in
                //convertToUser(data)
                //token is data
                if !data.isEmpty {
                        print(data.startIndex.description)
                    //this won't actually work, must fix
                        self.currentAccessToken = data.startIndex.description
                    return Promise<String>(value: self.currentAccessToken!)
                }else{
                    return Promise(error: NSError(domain: "Couldn't get token", code: 404))
                }
            }.always {
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
         }
         */
    /*
    func signUp(type: LoginType, params: String) -> Promise<String> {
        let q = DispatchQueue.global()
        let url = "http://localhost:54321"
        //UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return firstly {
            Alamofire.request(url, method: .post).responseData()
            }.then(on: q) { (data : Data) in
                //convertToUser(data)
                //token is data
                if !data.isEmpty {
                    print(data.startIndex.description)
                    //this won't actually work, must fix
                    self.currentAccessToken = data.startIndex.description
                    return Promise<String>(value: self.currentAccessToken!)
                }else{
                    return Promise(error: NSError(domain: "Couldn't get token", code: 404))
                }
            }.always {
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
 */

    
    
}
