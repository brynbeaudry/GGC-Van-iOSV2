//
//  EventTableViewController.swift
//  GGCVan Client
//
//  Created by Bryn Beaudry on 2017-12-01.
//  Copyright © 2017 Bryn Beaudry. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import EVReflection
import SwiftyJSON

class EventTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let AD = UIApplication.shared.delegate as! AppDelegate
    let dgHaveInitialData = DispatchGroup();
    let eventsApi = EventsAPI()
    var events : [Event]?
    let eventCellIdentifier = "EventTableViewCell"
    let gotoEventDetailSegue = "GotoEventDetail"
    
    @IBOutlet var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, self.tabBarController!.tabBar.frame.height, 0)
        self.tableView.contentInset = adjustForTabbarInsets
        self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
        
        
    }
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getCells()
        
        
        //get the list of events from the api
        dgHaveInitialData.enter()
        firstly {
            eventsApi.getEvents()
            }.then { events -> Void in
                for event in events {
                    print(event.title)
                }
                self.events = events
                self.dgHaveInitialData.leave()
            } .catch { error in
                print(error)
                self.dgHaveInitialData.leave()
        }
        dgHaveInitialData.notify(queue: .main, execute: {
            self.tableView.reloadData()
        })
        

        //Uncomment the following line to preserve selection between presentations
        //self.tableView.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: eventCellIdentifier, for: indexPath) as? EventTableViewCell else{
            fatalError("The cell is not the intended type")
        }
        //self.tableView.rowHeight = UITableViewAutomaticDimension;
        //self.tableView.estimatedRowHeight = 50;
        let event = events![indexPath.row]
        //let dgHaveDownloadedImage = DispatchGroup()
        getImageFromWeb(event.game.imageUrl) { (data) in
            if let data = data {
                //let scale : CGFloat = 3
                let image = UIImage(data: data)
                self.scaleDownAndSetImage(image: image!, imageView: cell.uiImage)
                //cell.uiImage.image = image
                //self.view.addSubview(imageView)
            } // if you use an Else statement, it will be in background
        }
        // Configure the cell...
        cell.uiTitle.text = event.title

        return cell
    }
    
    func scaleDownAndSetImage(image: UIImage, imageView : UIImageView) {
        //titleLabel.text = title
        
        if image.size.width > imageView.frame.width {
            let size = CGSize(width: imageView.frame.width, height: max(110, imageView.frame.width * image.size.height / image.size.width))
            imageView.image = image.scaledAspectFit(to: size)
        } else {
            imageView.image = image
        }
    }
    

    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        _ = indexPath.row
        
        //print(swiftBlogs[row])
        self.performSegue(withIdentifier: gotoEventDetailSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == gotoEventDetailSegue,
            let destination = segue.destination as? EventDetailViewController,
            let eventIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.eventId = events![eventIndex].id
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

}
