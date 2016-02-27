//
//  HotelDetailReviewsViewController.h
//  PushingTableView
//
//  Created by 刘智月 on 2/22/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelDetailReviewsViewController : UIViewController

@property(nonatomic, strong) NSString * review_text;
@property (weak, nonatomic) IBOutlet UITextView *review_text_view;

@end
