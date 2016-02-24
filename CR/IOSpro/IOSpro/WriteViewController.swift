//
//  ViewController.swift
//  IOSpro
//
//  Created by Tony on 16/2/15.
//  Copyright (c) 2016年 Tony. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var textField: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func submitReview(){
        self.index++
        let myalert = UIAlertView()
        myalert.title = "Comment Summitted"
        //get user input
        let msg = textField.text
        //show alert
        myalert.message = msg
        myalert.addButtonWithTitle("OK")
        myalert.show()
        //send data to mongodb
        let session = NSURLSession.sharedSession()
        let url = "http://ec2-52-90-95-189.compute-1.amazonaws.com:8888/insertreview?count=1&spot=card2&city=newyork&name=peter4&content="+msg
        let request = NSURLRequest(URL: NSURL(string: url))
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            var err: NSError
            let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            
        })
        task.resume()
        //dismiss the view
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}

