//
//  IdentityProvider.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-10-27.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import Foundation
import AWSCore
import AWSCognito


class IdentityProvider:  AWSAbstractCognitoCredentialsProviderHelper {
    var _token: String!
    var _logins: [ NSObject : AnyObject ]!
    var email: String!
    var password: String!
    
   override var token: String {
        get {
            return _token
        }
    }
    
    override var logins: [ NSObject : AnyObject ]! {
        get {
            return _logins
        }
        set {
            _logins = newValue!
        }
    }
    
    override func getIdentityId() -> AWSTask<String> {
        
        if self.identityId != nil {
            return AWSTask(result: self.identityId)
        }else{
            return AWSTask(result: nil).continueWithBlock({ (task) -> AnyObject! in
                if self.identityId == nil {
                    return self.refresh()
                }
                return AWSTask(result: self.identityId)
            })
        }
    }
    
    override func refresh() -> AWSTask<String> {
        let task = AWSTaskCompletionSource<AnyObject>()
        let request = AFHTTPRequestOperationManager()
        request.requestSerializer.setValue(email, forHTTPHeaderField: "email")
        request.requestSerializer.setValue(password, forHTTPHeaderField: "password")
        request.GET(Constants.loginUrl.value, parameters: nil, success: { (request: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            // The following 3 lines are required as referenced here: http://stackoverflow.com/a/26741208/535363
            self.logins = [self.developerProvider: self.email]
            
            // Get the properties from my server response
            let identityId = response.objectForKey("identityId")as! String
            let token = response.objectForKey("token")as! String
            
            // Set the identityId and token
            self.identityId = identityId
            self._token = token
            
            task.setResult(self.identityId)
            }, failure: { (request: AFHTTPRequestOperation?, error: NSError!) -> Void in
                task.setError(error)
        })
        return task.task
    }
    
}
