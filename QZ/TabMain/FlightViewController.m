//
//  ViewController.m
//  ZYL
//
//  Created by 刘智月 on 2/9/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import "FlightViewController.h"

@interface FlightViewController ()
@property (nonatomic) int count;
@end

@implementation FlightViewController
{
    NSArray *userName;
    NSArray *detail;
    NSInteger recordNum;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    userName = [NSArray arrayWithObjects:@"Delta", @"American Airline", @"JetBlue", @"United Airline", nil];
    detail = [NSArray arrayWithObjects: @"PIT -> SEA",
              @"PIT -> SEA",
              @"PIT -> SEA",
              @"PIT -> SEA",
              @"PIT -> SEA", nil];
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
    static NSString *simpleTableIdentifier = @"FindFlightTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [userName objectAtIndex:indexPath.row];
    cell.indentationLevel = 2;
    cell.detailTextLabel.text = [detail objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"flight.png"];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchNextBtn:(id)sender {
    self.count++;
    NSLog(@"count = %d",self.count);
    [self performSegueWithIdentifier:@"hotelViewController" sender:self];
}
@end

