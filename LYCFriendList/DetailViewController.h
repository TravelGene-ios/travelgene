//
//  DetailViewController.h
//  LYCFriendList
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 TravelGene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *friendNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *friendIdLabel;
@property (nonatomic, strong) IBOutlet UILabel *friendEmailLabel;
@property (nonatomic, strong) IBOutlet UILabel *friendGenderLabel;
@property (nonatomic, strong) IBOutlet UILabel *friendAgeLabel;
@property (nonatomic, strong) IBOutlet UILabel *friendImgLabel;

@property (nonatomic, strong) IBOutlet UIImageView *friendImgPicture;

@property (nonatomic, strong) Friend *currentFriend;

- (void)getFriend:(id)friendObject;
- (void)setLabels;

@end
