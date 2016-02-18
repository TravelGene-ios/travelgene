//
//  DetailViewController.m
//  LYCFriendList
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 TravelGene. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize friendAgeLabel,friendEmailLabel,friendGenderLabel,friendIdLabel,friendImgLabel,friendNameLabel,currentFriend,friendImgPicture;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getFriend:(id)friendObject {
    currentFriend = friendObject;
}

- (void)setLabels {
    friendNameLabel.text = currentFriend.friendName;
    friendIdLabel.text = currentFriend.friendId;
    friendEmailLabel.text = currentFriend.friendEmail;
    friendAgeLabel.text = currentFriend.friendAge;
    friendGenderLabel.text = currentFriend.friendGender;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:currentFriend.friendImg]];
    friendImgPicture.image = [UIImage imageWithData:imageData];
}

@end
