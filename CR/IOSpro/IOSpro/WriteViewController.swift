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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @IBAction func startGame(){
        self.index++
        let myalert = UIAlertView()
        myalert.title = "Comment Summited"
        myalert.message = "Comment Summited"
        myalert.addButtonWithTitle("OK")
        myalert.show()
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let newController = segue.destinationViewController as TestViewController
    newController.astring = "aaa"
    }*/
    
    
    
}

