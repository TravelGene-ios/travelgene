//
//  DetailTableViewController.m
//  PushingTableView
//
//  Created by 刘智月 on 2/15/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import "FlightDetailTableViewController.h"

@interface FlightDetailTableViewController ()

@end

@implementation FlightDetailTableViewController{
    NSArray *dogs;
    NSArray *cats;
    NSArray *frogs;
    
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
    dogs = [NSArray arrayWithObjects:@"Golden Retriever", @"lab", nil];
    cats = [NSArray arrayWithObjects:@"Scrub1", @"Punk 2",@"meanie", nil];
    frogs = [NSArray arrayWithObjects:@"Fly", @"Buzz", nil];
    
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
    if([_animalName isEqualToString:@"Delta"]){
        return [dogs count];
    }else if([_animalName isEqualToString:@"American Airline"]){
        return [cats count];
    }else if([_animalName isEqualToString:@"JetBlue"]){
        return [frogs count];
    }else{
        return [frogs count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Animal2Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if([_animalName isEqualToString:@"Delta"]){
        cell.textLabel.text = [dogs objectAtIndex:indexPath.row];
    }else if([_animalName isEqualToString:@"American Airline"]){
        cell.textLabel.text = [cats objectAtIndex:indexPath.row];
    }else if([_animalName isEqualToString:@"JetBlue"]){
        cell.textLabel.text = [frogs objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [frogs objectAtIndex:indexPath.row];
    }

    return cell;
    
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
