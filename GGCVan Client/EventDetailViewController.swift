//
//  EventDetailViewController.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-12-04.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import EVReflection
import SwiftyJSON

class EventDetailViewController: UIViewController {
    @IBOutlet weak var uiHeader: UILabel!
    @IBOutlet weak var uiImage: UIImageView!
    @IBOutlet weak var uiStartTime: UILabel!
    @IBOutlet weak var uiEndTime: UILabel!
    @IBOutlet weak var uiLatitude: UILabel!
    @IBOutlet weak var uiLongitude: UILabel!
    @IBOutlet weak var uiDescription: UILabel!
    @IBOutlet weak var uiLocationDescription: UILabel!
    @IBOutlet weak var uiNumberOfJoinedUsers: UILabel!
    let dgHaveEventDetails = DispatchGroup()
    let eventsApi = EventsAPI()
    var event : Event?
    
    var eventId : Int32?
    
    func getImageFromWeb(_ urlString: String, closure: @escaping (Data?) -> ()) {
        guard let url = URL(string: urlString) else {
            return closure(nil)
        }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("error: \(String(describing: error))")
                return closure(nil)
            }
            guard response != nil else {
                print("no response")
                return closure(nil)
            }
            guard data != nil else {
                print("no data")
                return closure(nil)
            }
            DispatchQueue.main.async {
                closure(data)
            }
        }; task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if eventId != nil {
            dgHaveEventDetails.enter()
            firstly {
                eventsApi.getEventDetails(id: eventId!)
                }.then { event -> Void in
                    self.event = event
                    //self.dgHaveEventDetails.leave()
                }.then { () -> Void in
                    self.getImageFromWeb(self.event!.game.imageUrl) { (data) in
                        if let data = data {
                            let scale : CGFloat = 1
                            let image = UIImage(data: data, scale: scale)
                            self.uiImage.image = image
                        } // if you use an Else statement, it will be in background
                    }
                    self.dgHaveEventDetails.leave()
                } .catch { error in
                    print(error)
                    self.dgHaveEventDetails.leave()
            }
            dgHaveEventDetails.notify(queue: .main, execute: {
                self.uiHeader.text = "\(self.event!.title) Hosted By \(self.event!.host)"
                self.uiStartTime.text = "Start Time : \(String(describing: self.event!.startTime))"
                self.uiEndTime.text = "End Time : \(String(describing: self.event!.endTime))"
                self.uiLatitude.text = "Latitude : \(String(describing: self.event!.latitude))"
                self.uiLongitude.text = "Longitude : \(String(describing: self.event!.longitude))"
                self.uiDescription.text = "Description : \(self.event!.eventDescription)"
                self.uiLocationDescription.text = "Description : \(self.event!.locationDescription)"
                self.uiNumberOfJoinedUsers.text = "Number of Guests : \(self.event!.eventGuests.count)"
            })
        }
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {-
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
