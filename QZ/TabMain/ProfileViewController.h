//
//  ProfileViewController.h
//  TabMain
//
//  Created by Qiankun Zhuang on 2/15/16.
//  Copyright © 2016 Qiankun Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end
