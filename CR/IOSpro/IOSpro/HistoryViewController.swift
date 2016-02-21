//
//  HistoryViewController.swift
//  IOSpro
//
//  Created by Tony on 16/2/17.
//  Copyright (c) 2016年 Tony. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    var place: [String] = ["Seattle","New York","Pittsburgh"];
    var review: [String] = ["Public","Public","Private"];
    var img: [String] = ["seattle","Newyourk","Pittsburgh"];

    @IBOutlet weak var items: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items.rowHeight = 88
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let initIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier( "Item", forIndexPath: indexPath) as UITableViewCell
        //下面两个属性对应subtitle
        cell.textLabel?.text = place[indexPath.row]
        cell.detailTextLabel?.text = review[indexPath.row]
        cell.imageView?.image=UIImage(named:img[indexPath.row])
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place.count
    }

}
