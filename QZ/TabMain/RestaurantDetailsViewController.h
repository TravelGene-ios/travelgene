//
//  RestaurantDetailsViewController.h
//  PushingTableView
//
//  Created by 刘智月 on 2/23/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantDetailsViewController : UIViewController

@property(nonatomic, strong) NSString * restaurant_title;
@property(nonatomic, strong) NSString * restaurant_address;
@property(nonatomic, strong) NSString * restaurant_img_url;
@property(nonatomic, strong) NSString * restaurant_review_count;
@property(nonatomic, strong) NSString * restaurant_rating;
@property(nonatomic, strong) NSNumber * restaurant_price_range;
@property(nonatomic, strong) NSString * restaurant_open_hour;
@property(nonatomic, strong) NSArray * restaurant_reviews;
@property (weak, nonatomic) IBOutlet UIImageView *restaurant_image_view;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_address_label;

@property (weak, nonatomic) IBOutlet UILabel *restaurant_open_hour_label;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_price_range_label;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_rating_label;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_review_count_label;


@property (weak, nonatomic) IBOutlet UITableView *restaurant_reviews_table_view;

@end
