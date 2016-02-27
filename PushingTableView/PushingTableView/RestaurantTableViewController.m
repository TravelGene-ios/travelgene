//
//  RestaurantTableViewController.m
//  PushingTableView
//
//  Created by 刘智月 on 2/23/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import "RestaurantTableViewController.h"
#import "RestaurantDetailsViewController.h"


@interface RestaurantTableViewController ()

@end

@implementation RestaurantTableViewController{
        NSMutableArray * selected_restaurants;
    
    NSMutableArray * restaurant_titles;
    NSMutableArray * restaurant_addresses;
    NSMutableArray * restaurant_imgs;
    NSMutableArray * restaurant_review_cnts;
    NSMutableArray * restaurant_ratings;
    NSMutableArray * restaurant_review_list;
    
    NSMutableArray * restaurant_price_ranges;
    NSMutableArray * restaurant_open_hours;
}
@synthesize msg;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    int retrievalSize = 10;
    
    NSString* path  = [NSString stringWithFormat:@"%@%@%@", @"http://ec2-52-90-95-189.compute-1.amazonaws.com:8888/searchrestaurant?count=",[NSString stringWithFormat:@"%i", retrievalSize], @"&city=newyork"];
    
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSData* jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSArray* arrayResult =[dic objectForKey:@"result"];
    if(!restaurant_titles){
        restaurant_titles = [[NSMutableArray alloc] init];
    }
    if(!restaurant_addresses){
        restaurant_addresses = [[NSMutableArray alloc] init];
    }
    if(!restaurant_imgs){
        restaurant_imgs = [[NSMutableArray alloc] init];
    }
    if(!restaurant_review_cnts){
        restaurant_review_cnts = [[NSMutableArray alloc] init];
    }
    if(!restaurant_ratings){
        restaurant_ratings = [[NSMutableArray alloc] init];
    }
    if(!restaurant_review_list){
        restaurant_review_list  = [[NSMutableArray alloc] init];
    }
    if(!restaurant_price_ranges){
        restaurant_price_ranges  = [[NSMutableArray alloc] init];
    }
    if(!restaurant_open_hours){
        restaurant_open_hours  = [[NSMutableArray alloc] init];
    }
    if(!selected_restaurants){
        selected_restaurants = [[NSMutableArray alloc] init];
    }
    for (int i=0; i<retrievalSize; i++) {
        NSDictionary* resultDic = [arrayResult objectAtIndex:i];
        
        [restaurant_titles addObject:[resultDic objectForKey:@"title"]];
        [restaurant_addresses addObject:[resultDic objectForKey:@"address"]];
        [restaurant_imgs addObject:[resultDic objectForKey:@"img_url"]];
        [restaurant_review_cnts addObject:[resultDic objectForKey:@"review_count"]];
        [restaurant_ratings addObject:[resultDic objectForKey:@"rating_string"]];
        [restaurant_review_list addObject: [resultDic objectForKey:@"review_list"]];
        [restaurant_price_ranges addObject: [resultDic objectForKey:@"price_range"]];
        [restaurant_open_hours addObject: [resultDic objectForKey:@"open_hour"]];
        
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [restaurant_titles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RestaurantCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
//
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
//    cell.textLabel.text = [restaurant_titles objectAtIndex:indexPath.row];
    SelectedItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    // Configure the cell...
    //    if (cell == nil) {
    //        cell = [[FlightTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    //    }
    cell.item_label.text = [restaurant_titles objectAtIndex:indexPath.row];
    cell.likeBtn.tag = indexPath.row; // starts from 0
    [cell.likeBtn addTarget: self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];//listener, and run method likeBtnClick
    // should read from database
    [cell.likeBtn setBackgroundImage:[UIImage imageNamed:@"unlike.png"] forState:UIControlStateNormal];
    cell.likeBtn.titleLabel.text=@"unlike";
    cell.likeBtn.titleLabel.hidden=YES;
    return cell;
}

-(void) likeBtnClick:(id) sender{
    UIButton *senderButton = (UIButton *) sender;
    NSLog(@"current row=%d", senderButton.tag); // index path row
    //    UIImage *image = senderButton.currentBackgroundImage;
    NSLog(@"img: %@", senderButton.titleLabel.text);
    if([senderButton.titleLabel.text isEqualToString: @"unlike"] ){
        [senderButton setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal ];
        senderButton.titleLabel.text=@"like";
        [selected_restaurants addObject:[restaurant_titles objectAtIndex:senderButton.tag]];
        // add the logic of recommendation
        //        NSString * tmp = @"Panda";
        //        if(!flights){
        //            flights = [[NSMutableArray alloc] init];
        //        }
        //        [flights addObject:tmp];
        //        [self.tableView reloadData];
        
    }else{
        [senderButton setBackgroundImage:[UIImage imageNamed:@"unlike.png"] forState:UIControlStateNormal ];
        senderButton.titleLabel.text=@"unlike";
        [selected_restaurants removeObject:[restaurant_titles objectAtIndex:senderButton.tag]];
    }
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showRestaurantDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RestaurantDetailsViewController *destController = segue.destinationViewController;
        destController.restaurant_title = [restaurant_titles objectAtIndex:indexPath.row];
        destController.restaurant_address = [restaurant_addresses objectAtIndex:indexPath.row];
        destController.restaurant_img_url = [restaurant_imgs objectAtIndex:indexPath.row];
        destController.restaurant_review_count= [restaurant_review_cnts objectAtIndex:indexPath.row];
        destController.restaurant_rating = [restaurant_ratings objectAtIndex:indexPath.row];
        destController.restaurant_price_range = [restaurant_price_ranges objectAtIndex:indexPath.row];
        destController.restaurant_open_hour = [restaurant_open_hours objectAtIndex:indexPath.row];
        destController.restaurant_reviews = [restaurant_review_list objectAtIndex:indexPath.row];
        destController.title = destController.restaurant_title;
    }
    else if([segue.identifier isEqualToString:@"showOverviewPage"]){
        UINavigationController *navController = segue.destinationViewController;
        TripOverviewViewController *dest =(TripOverviewViewController*) navController.topViewController;
        dest.name = @"test string";
        dest.title = @"Trip Overview";
        dest.selectedFlights = self.selectedFlights;
        dest.selectedHotels = self.selectedHotels;
        dest.selectedRestaurants = selected_restaurants;
        NSLog(@"%@", dest.selectedRestaurants);
        [dest setDelegate:self];
    }
}

#pragma mark - Protocol Methods
-(void) setLabel:(NSString *) label{
    msg = label;
}

@end
