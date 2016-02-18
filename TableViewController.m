//
//  TableViewController.m
//  LYCFriendList
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 TravelGene. All rights reserved.
//

#import "TableViewController.h"
#import "Friend.h"
#import "DetailViewController.h"

#define getDataURL @"http://ec2-52-90-95-189.compute-1.amazonaws.com/friendlist.php"

@interface TableViewController ()

@end

@implementation TableViewController
@synthesize jsonArray, friendsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Friends List";
    [self retrieveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return friendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Friend *friendObject;
    friendObject = [friendsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = friendObject.friendName;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Friend *object = [friendsArray objectAtIndex:indexPath.row];
    [[segue destinationViewController] getFriend:object];
}

- (void) retrieveData {
    NSURL *url = [NSURL URLWithString:getDataURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    friendsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < jsonArray.count; i++) {
        NSString *fId = [[jsonArray objectAtIndex:i] objectForKey:@"userid"];
        NSString *fName = [[jsonArray objectAtIndex:i] objectForKey:@"name"];
        NSString *fAge = [[jsonArray objectAtIndex:i] objectForKey:@"age"];
        NSString *fEmail = [[jsonArray objectAtIndex:i] objectForKey:@"email"];
        NSString *fGender = [[jsonArray objectAtIndex:i] objectForKey:@"gender"];
        NSString *fImg = [[jsonArray objectAtIndex:i] objectForKey:@"imgurl"];
        
        [friendsArray addObject:[[Friend alloc]initWithFriendName:fName andFriendId:fId andFriendEmail:fEmail andFriendGender:fGender andFriendAge:fAge andFriendImg:fImg]];
    }
    
    [self.tableView reloadData];
}

@end
