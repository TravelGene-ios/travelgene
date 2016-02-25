//
//  InterestTableViewController.h
//  TravelGeneqiqi
//
//  Created by shiqiqi on 2/11/16.
//  Copyright © 2016 shiqiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterestTableViewController : UITableViewController
   @property (nonatomic)  NSString *destination;
   @property (nonatomic) NSDate *startDate;
   @property (nonatomic) NSDate *endDate;
   @property (nonatomic) NSInteger *groupnumber;

- (IBAction)touchNextBtn:(id)sender;

@end
