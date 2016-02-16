//
//  ViewController.swift
//  IOSpro
//
//  Created by Tony on 16/2/15.
//  Copyright (c) 2016年 Tony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var index = 0
    @IBOutlet weak var pic: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(vImg);
        // Do any additional setup after loading the view, typically from a nib.
        var nsd = NSData(contentsOfURL:NSURL.URLWithString("http://ww2.sinaimg.cn/bmiddle/632dab64jw1ehgcjf2rd5j20ak07w767.jpg"))
        
        var img = UIImage(data: nsd,scale:1.5);
        var pic = UIImageView(image: img);
        pic.frame.origin = CGPoint(x:0,y:20);
        //vImg.frame.size.height = 100//self.view.bounds.width;
        //vImg.frame = CGRect(x:0,y:20,width:120,height:120);
        pic.contentMode = UIViewContentMode.ScaleAspectFit;
        
        self.view.addSubview(pic);
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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: initIdentifier)
        //下面两个属性对应subtitle
        cell.textLabel?.text = "aaaa"
        cell.detailTextLabel?.text = "baby"
        
        
        return cell
    }
    

}

