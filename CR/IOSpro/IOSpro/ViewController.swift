//
//  ViewController.swift
//  IOSpro
//
//  Created by Tony on 16/2/15.
//  Copyright (c) 2016年 Tony. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var index = 0;
    var name: [String] = ["Tina Li","QiQi Shi","Yancheng Liu"];
    var review: [String] = ["This place is great! I love it","This place is great! I also love it","This place is bullshit"];
    @IBOutlet weak var pic: UIImageView!

    @IBOutlet weak var reviews: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(vImg);
        // Do any additional setup after loading the view, typically from a nib.
        /*var nsd = NSData(contentsOfURL:NSURL.URLWithString("http://ww2.sinaimg.cn/bmiddle/632dab64jw1ehgcjf2rd5j20ak07w767.jpg"))
        
        var img = UIImage(data: nsd,scale:1.5);
        var pic = UIImageView(image: img);
        pic.frame.origin = CGPoint(x:0,y:20);
        //vImg.frame.size.height = 100//self.view.bounds.width;
        //vImg.frame = CGRect(x:0,y:20,width:120,height:120);
        pic.contentMode = UIViewContentMode.ScaleAspectFit;
        
        self.view.addSubview(pic);*/
        //self.reviews.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let newController = segue.destinationViewController as TestViewController
        newController.astring = "aaa"
    }*/

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let initIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier( "Cell", forIndexPath: indexPath) as UITableViewCell
        //下面两个属性对应subtitle
        cell.textLabel?.text = name[indexPath.row]
        cell.detailTextLabel?.text = review[indexPath.row]
        
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    

}

