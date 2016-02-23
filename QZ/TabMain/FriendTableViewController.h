//
//  TableViewController.h
//  LYCFriendList
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 TravelGene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *jsonArray;
@property (nonatomic, strong) NSMutableArray *friendsArray;

- (void) retrieveData;

@end
