//
//  ViewController.swift
//  IOSpro
//
//  Created by Tony on 16/2/15.
//  Copyright (c) 2016年 Tony. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    let url = "http://ec2-52-90-95-189.compute-1.amazonaws.com:8888/searchcyr?count=3&spot=card&city=newyork"
    var index = 0;
    var name: [String] = ["Tina Li","QiQi Shi","Yancheng Liu"];
    var review: [String] = ["This place is great! I love it","This place is great! I also love it","This place is bullshit"];
    //var yourArray = [String]();
    var tag = 0;
    
    var name2 = [String]();
    var review2 = [String]();
    
    @IBOutlet weak var pic: UIImageView!

    @IBOutlet weak var reviews: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        getData()
        
        while (tag == 0) {continue}
        //println("aaa")
        //println(yourArray)
        
        //let initIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier( "Cell", forIndexPath: indexPath) as UITableViewCell

        //cell.textLabel?.text = name[indexPath.row]
        println(indexPath.row)
        cell.textLabel?.text = name2[indexPath.row]
        cell.detailTextLabel?.text = review2[indexPath.row]
        /*
        let cell = tableView.dequeueReusableCellWithIdentifier( "Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = name[indexPath.row]
        //println(indexPath.row)
        //cell.textLabel?.text = yourArray[indexPath.row]
        cell.detailTextLabel?.text = review[indexPath.row]
        */
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        getData()
        
        while (tag == 0) {continue}
        //return yourArray.count
        
        return name2.count
    }
    
    func getData(){
        if (self.tag == 1) {
            return
        }
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: NSURL(string: "http://ec2-52-90-95-189.compute-1.amazonaws.com:8888/searchreviews?count=4&spot=card2&city=newyork"))
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            var err: NSError
            let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            if let json = jsonResult as? NSDictionary{
                if let results = json["result"] as? NSArray{
                    for var index = 0; index < results.count; ++index {
                        if let result = results[index] as? NSDictionary{
                            //println(result)
                            if let name = result["name"] as? String{
                                println(name)
                                self.name2.append(name)
                                
                            }
                            if let rev = result["content"] as? String{
                                println(rev)
                                self.review2.append(rev)
                                
                            }
                        }
                    }
                    self.tag = 1
                    
                    
                }
            }
        })
        task.resume()
    }

}

