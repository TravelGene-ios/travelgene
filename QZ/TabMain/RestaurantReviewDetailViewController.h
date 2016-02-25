//
//  RestaurantReviewDetailViewController.h
//  PushingTableView
//
//  Created by 刘智月 on 2/23/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantReviewDetailViewController : UIViewController
@property(nonatomic, strong) NSString * review_text;

@property (weak, nonatomic) IBOutlet UITextView *review_text_view;

@end
