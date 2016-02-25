//
//  RootTableViewController.m
//  PushingTableView
//
//  Created by 刘智月 on 2/15/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import "RootTableViewController.h"
#import "DetailTableViewController.h"
#import "FlightTableViewCell.h"

#import "HotelTableViewController.h"

@interface RootTableViewController ()

@end

@implementation RootTableViewController{
    NSMutableArray * flights;
    NSMutableArray * selectedFlights;
}

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
    
    flights = [NSMutableArray arrayWithObjects:@"Delta", @"American Airline", @"JetBlue", nil];
    if(!selectedFlights){
        selectedFlights = [[NSMutableArray alloc] init];
    }
    //navigationItem edit button
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
//    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
//    self.navigationItem.rightBarButtonItem = addButton;
//    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) insertNewObject{
    // display a UIalertView
    NSString * tmp = @"Panda";
    if(!flights){
        flights = [[NSMutableArray alloc] init];
    }

    [flights addObject:tmp];
    [self.tableView reloadData];
//    [animals insertObject: tmp atIndex:[animals count]-1];
//    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[animals count]-1 inSection:1];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
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
    return [flights count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"AnimalCell";
    FlightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier ];//forIndexPath:indexPath];
    
    // Configure the cell...
//    if (cell == nil) {
//        cell = [[FlightTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
    cell.flight_cell_label.text = [flights objectAtIndex:indexPath.row];
    cell.likedBtn.tag = indexPath.row; // starts from 0
    [cell.likedBtn addTarget: self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];//listener, and run method likeBtnClick
    // should read from database
    [cell.likedBtn setBackgroundImage:[UIImage imageNamed:@"unlike.png"] forState:UIControlStateNormal];
    cell.likedBtn.titleLabel.text=@"unlike";
    cell.likedBtn.titleLabel.hidden=YES;
    
    return cell;
}

-(void) likeBtnClick:(id) sender
{
    UIButton *senderButton = (UIButton *) sender;
    NSLog(@"current row=%d", senderButton.tag); // index path row
//    UIImage *image = senderButton.currentBackgroundImage;
    NSLog(@"img: %@", senderButton.titleLabel.text);
    if([senderButton.titleLabel.text isEqualToString: @"unlike"] ){
            [senderButton setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal ];
        senderButton.titleLabel.text=@"like";

        [selectedFlights addObject:[flights objectAtIndex:senderButton.tag]];

        
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
//        NSLog(@"%@", selectedFlights);
        [selectedFlights removeObject:[flights objectAtIndex:senderButton.tag]];
//        NSLog(@"%@", selectedFlights);
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [flights removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showArrayDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailTableViewController *destController = segue.destinationViewController;
        destController.animalName = [flights objectAtIndex:indexPath.row];
        destController.title = destController.animalName;
    }else if([segue.identifier isEqualToString:@"passSelectedFlight2Hotel"]){
        UINavigationController *navController = segue.destinationViewController;
        HotelTableViewController *dest =(HotelTableViewController*) navController.topViewController;
        NSLog(@"%@", selectedFlights);
        dest.selectedFlights = selectedFlights;

    }
}


@end
