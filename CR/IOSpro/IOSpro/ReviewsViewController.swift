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
        myalert.title = "准备好了吗"
        myalert.message = "准备好开始了吗？"
        myalert.addButtonWithTitle("Ready, go!")
        myalert.show()
    }
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let newController = segue.destinationViewController as TestViewController
    newController.astring = "aaa"
    }*/
    
    
    
}

