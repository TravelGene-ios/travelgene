//
//  TableViewController.h
//  TabMain
//
//  Created by Qiankun Zhuang on 2/9/16.
//  Copyright © 2016 Qiankun Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tripArray;

-(void) retrieveData;

@end
