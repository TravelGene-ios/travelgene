//
//  HotelDetailsViewController.m
//  PushingTableView
//
//  Created by 刘智月 on 2/17/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import "HotelDetailsViewController.h"

@interface HotelDetailsViewController ()

@end

@implementation HotelDetailsViewController{
    NSMutableArray * hotelReviews;
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
    hotelReviews = [NSMutableArray arrayWithObjects:@"Claire", @"Jing", @"Qiqi", nil];
    reviewDetails = [NSMutableArray arrayWithObjects:
              @"comportable night",
              @"nice price",
              @"good location", nil];
    // Do any additional setup after loading the view.
//    UIImageView *hotelImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    NSURL *image_url = [NSURL URLWithString:self.hotelImg];
    NSData *img_data = [[NSData alloc] initWithContentsOfURL:image_url];
    UIImage *hotelImage = [[UIImage alloc] initWithData:img_data];
    
    self.hotel_image_view.image = hotelImage;
    self.hotel_address_label.text = self.hotelAddr;
    self.rating_label.text = self.hotelRating;
    self.review_cnt_label.text = self.reviewCnt;
//    NSLog(@"%@",self.hotel_address_label.text);
    
    
//    hotelImage.image = [UIImage data:[self.hotelImg]];
//    [self.view addSubview:hotelImage];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Reviews";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [hotelReviews count];
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"HotelReviewTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [hotelReviews objectAtIndex:indexPath.row];
//    cell.indentationLevel = 2;
    cell.detailTextLabel.text = [reviewDetails objectAtIndex:indexPath.row];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
