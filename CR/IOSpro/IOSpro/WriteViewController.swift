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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var textField: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @IBAction func startGame(){
        self.index++
        let myalert = UIAlertView()
        myalert.title = "Comment Summited"
        //myalert.message = "Comment Summited"
        let msg = textField.text
        myalert.message = msg
        myalert.addButtonWithTitle("OK")
        myalert.show()
        let session = NSURLSession.sharedSession()
        let url = "http://ec2-52-90-95-189.compute-1.amazonaws.com:8888/insertreview?count=1&spot=card2&city=newyork&name=peter4&content="+msg
        let request = NSURLRequest(URL: NSURL(string: url))
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            var err: NSError
            let jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            
        })
        task.resume()
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let newController = segue.destinationViewController as TestViewController
    newController.astring = "aaa"
    }*/
    
    
    
}

