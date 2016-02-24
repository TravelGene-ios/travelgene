//
//  TableViewController.m
//  TabMain
//
//  Created by Qiankun Zhuang on 2/9/16.
//  Copyright © 2016 Qiankun Zhuang. All rights reserved.
//

#import "TableViewController.h"
#import "TripDetailViewController.h"

@interface TableViewController ()

@end




@implementation TableViewController
{
    NSArray *userName;
    NSArray *detail;
    NSInteger recordNum;
}
//@synthesize tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Called here\n");
    return recordNum;
}

- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil]; // ios 6
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    userName = [NSArray arrayWithObjects:@"Qiankun", @"Yancheng", @"Tina", @"Qiqi", nil];
    detail = [NSArray arrayWithObjects: @"Went to Chicago with my Zhenzhen!",
              @"Went to Orlando",
              @"Went to Boston",
              @"Went to Mexico", nil];
    recordNum = [userName count];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStyleBordered target:self action:@selector(Back)];
//    self.navigationItem.leftBarButtonItem = backButton;

    self.title = @"TravelGene";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // UIAlertView *messageAlert = [[UIAlertView alloc]
   //                              initWithTitle:@"Row Selected" message:[detail objectAtIndex:indexPath.row] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
//    [messageAlert show];
//    NSLog(@"Did select, Passed Row index:%d",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Store Selection
//    [self setSelection:indexPath];
    
    // Perform the segue with identifier: updateToDoViewController
    [self performSegueWithIdentifier:@"checkDetail" sender:indexPath];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"checkDetail"])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TripDetailViewController *destViewController = segue.destinationViewController;
        destViewController.data = [detail objectAtIndex:indexPath.row];
        NSLog(@"Prepare, Passed Row index:%d",indexPath.row);
        
    }
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MainPageTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [userName objectAtIndex:indexPath.row];
    cell.indentationLevel = 2;
    cell.detailTextLabel.text = [detail objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"test.jpg"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 5;
//}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
