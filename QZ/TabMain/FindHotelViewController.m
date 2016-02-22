//
//  FindHotelViewController.m
//  ZYL
//
//  Created by 刘智月 on 2/9/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import "FindHotelViewController.h"

@interface FindHotelViewController ()

@end

@implementation FindHotelViewController

{
    NSArray *userName;
    NSArray *detail;
    NSInteger recordNum;
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
	// Do any additional setup after loading the view, typically from a nib.
    userName = [NSArray arrayWithObjects:@"Westin", @"Sheraton", @"Quarter Club", @"Holiday Inn", nil];
    detail = [NSArray arrayWithObjects: @"3.5 stars",
              @"4 stars",
              @"3.5 stars",
              @"3 stars", nil];
    recordNum = [userName count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return recordNum;
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FindHotelTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [userName objectAtIndex:indexPath.row];
    cell.indentationLevel = 2;
    cell.detailTextLabel.text = [detail objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"hotel.jpg"];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)confirm:(id)sender {
//    [self dismissViewControllerAnimated:(YES) completion:nil];
    [self performSegueWithIdentifier:@"confirmTrip" sender:self];
}
@end
