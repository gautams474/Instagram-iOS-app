//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Gautam Sadarangani on 1/27/16.
//  Copyright © 2016 Gautam Sadarangani. All rights reserved.
//B

import UIKit
import AFNetworking

class PhotosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var feed: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.feed = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                            print (self.feed)
                    }
                }
        });
        task.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       if let rows = feed{
            return rows.count
        }
       else{
        return 0
        }
       
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
     
        let feedCell = feed![indexPath.row]
        let user = feedCell["user"]!["username"] as? String!
        let path = feedCell.valueForKeyPath("images.standard_resolution.url") as? String    //"profile_picture"
       // let path = feedCell["images"]!["low_resolution"]!!["url"] as? String
        let imageUrl = NSURL(string: path!)
       // let imageURL = NSURL( string: feed![indexPath.row].valueForKeyPath("images.standard_resolution.url") as! String)
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PrototypeCell", forIndexPath: indexPath) as! PrototypeCell
        
        cell.nameLabel.text = user
        if let imageUrl = imageUrl {
            cell.pictureView.setImageWithURL(imageUrl)
        }
      // cell.pictureView.setImageWithURL(imgUrl!)
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
