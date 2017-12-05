//
//  EventsAPI.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-12-03.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import EVReflection
import SwiftyJSON

class EventsAPI : NSObject {
    let AD = UIApplication.shared.delegate as! AppDelegate
    let IP : CustomIdentityProvider?
    let BASE_URL : String?
    //let headers : [String:String]?
    public override init(){
        self.IP = AD.customIdentityProvider
        self.BASE_URL = "\(AD.BASE_URL)/api/events"
        //self.headers = ["Authorization":"Bearer \(IP?.currentToken?.access_token ?? "Something when wrong and there is no Token"))"]
    }
    
    func buildAuthenticatedRequest(url: String, method: String) -> URLRequest {
        //let headers = self.headers
        var request = URLRequest(url: NSURL(string:url)! as URL)
        request.httpMethod = method
        request.setValue("Bearer \(IP?.currentToken?.access_token ?? "Something went wrong")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func getEvents() -> Promise<[Event]>{
        
        let url = self.BASE_URL!
        //let headers = self.headers
        let request = buildAuthenticatedRequest(url: url, method: "GET")
        
        return Alamofire.request(request).responseJSON()
        .then { resp in
            print(resp)
            let json = JSON(resp)
            let events = [Event](json : json.rawString())
            return Promise(value : events)
            }.catch{ error in
                print(error)
            }
    }
    func getEventDetails(id: Int32) -> Promise<Event>{
        
        let url = "\(self.BASE_URL!)/\(id)"
        let request = buildAuthenticatedRequest(url: url, method: "GET")
        
        return Alamofire.request(request).responseJSON()
            .then { resp in
                print(resp)
                let json = JSON(resp)
                let events = Event(json : json.rawString())
                return Promise(value : events)
            }.catch{ error in
                print(error)
        }
    }
}
