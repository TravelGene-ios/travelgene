//
//  RestaurantDetailsViewController.m
//  PushingTableView
//
//  Created by 刘智月 on 2/23/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import "RestaurantDetailsViewController.h"
#import "RestaurantReviewDetailViewController.h"

@interface RestaurantDetailsViewController ()

@end

@implementation RestaurantDetailsViewController{
    NSMutableArray * restaurantDetailReviews;
    NSMutableArray * reviewDetails;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *image_url = [NSURL URLWithString:self.restaurant_img_url];
    NSData *img_data = [[NSData alloc] initWithContentsOfURL:image_url];
    
    //TODO
    if (img_data || image_url) {
        NSLog(@"empty image");
        img_data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.comohotels.com/metropolitanbangkok/sites/default/files/styles/background_image/public/images/background/metbkk_bkg_nahm_restaurant.jpg"]];
    }
    
    self.restaurant_image_view.image = [[UIImage alloc] initWithData:img_data];
    self.restaurant_address_label.text = self.restaurant_address;
    
    self.restaurant_open_hour_label.text = self.restaurant_open_hour;
    self.restaurant_price_range_label.text =[self.restaurant_price_range stringValue];
    
    self.restaurant_rating_label.text = self.restaurant_rating;
    self.restaurant_review_count_label.text= self.restaurant_review_count;
    
    
    NSArray * reviewsArray = self.restaurant_reviews;
    if(!restaurantDetailReviews){
        restaurantDetailReviews = [[NSMutableArray alloc] init];
    }
    
    for (int i=0; i<[reviewsArray count]; i++) {
        [restaurantDetailReviews addObject:[reviewsArray objectAtIndex:i]];
    }

    
    // Do any additional setup after loading the view.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Reviews";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [restaurantDetailReviews count];
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RestaurantReviewTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [[restaurantDetailReviews objectAtIndex:indexPath.row] substringFromIndex:5 ]; //TODO
    
    //    NSLog(@"%@",[hotelDetailReviews objectAtIndex:indexPath.row]);
    
    //    cell.indentationLevel = 2;
    //    cell.detailTextLabel.text = [reviewDetails objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showRestaurantReviewDetails"]){
        NSIndexPath *indexPath = [self.restaurant_reviews_table_view indexPathForSelectedRow];
        RestaurantReviewDetailViewController *destController = segue.destinationViewController;
        destController.review_text = [restaurantDetailReviews objectAtIndex:indexPath.row];
        destController.title =  @"Review Details";
    }
}


@end
