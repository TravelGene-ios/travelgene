//
//  ProfileViewController.m
//  TabMain
//
//  Created by Qiankun Zhuang on 2/15/16.
//  Copyright © 2016 Qiankun Zhuang. All rights reserved.
//

#import "ProfileViewController.h"
#import "TripDetailViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
{
    UIView* userView;
    UIImage* userImage;
    UIImageView* userImageView;
    
    NSArray *detail;
    NSMutableArray * imageViewsArray;
    NSArray* travelImages;
    NSInteger recordNum;
}


- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    return recordNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Profile";
    detail = [NSArray arrayWithObjects: @"Trip to Seattle",
              @"Went to Chicago", @"Trip to Boston", @"Trip to New York", nil];
    recordNum = [detail count];
    /************Display user profile image***************/
    CGRect viewRect = CGRectMake(10, 80, 100, 100);
    // creating the UIView object
    userView = [[UIView alloc] initWithFrame:viewRect];
    
    // loading my image (a red square) into a UIImage object..
    userImage = [UIImage imageNamed:@"user1.jpeg"];
    
    // creating a UIImageView object that will hold my myImage..
    userImageView = [[UIImageView alloc] initWithImage:userImage];
    
    // trying to make my Image load to the screen by adding the object that is
    // encapsulating it to the UIView I created..
    
    [userView addSubview:userImageView];
    [self.view addSubview:userView];
    
    /**************Display user stats**********************/
    UILabel *tripNum = [[UILabel alloc] initWithFrame:CGRectMake(105, 70, 120, 60)];
    tripNum.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleBottomMargin;
    tripNum.lineBreakMode = NSLineBreakByWordWrapping;
    tripNum.numberOfLines = 0;
    tripNum.text = [NSString stringWithFormat:@"Trips\n   6"]; // Make use of the exposed data property
    [self.view addSubview:tripNum];
    
    UILabel *followerNum = [[UILabel alloc] initWithFrame:CGRectMake(155, 70, 120, 60)];
    followerNum.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleBottomMargin;
    followerNum.lineBreakMode = NSLineBreakByWordWrapping;
    followerNum.numberOfLines = 0;
    followerNum.text = [NSString stringWithFormat:@"Followers\n     60"]; // Make use of the exposed data property
    [self.view addSubview:followerNum];
    
    
    UILabel *followingNum = [[UILabel alloc] initWithFrame:CGRectMake(240, 70, 120, 60)];
    followingNum.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleBottomMargin;
    followingNum.lineBreakMode = NSLineBreakByWordWrapping;
    followingNum.numberOfLines = 0;
    followingNum.text = [NSString stringWithFormat:@"Following\n      16"]; // Make use of the exposed data property
    [self.view addSubview:followingNum];
    
    /************Display follow button*******************/
    UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect btn = CGRectMake(120, 130, 170, 30);
    [followBtn setFrame:btn];
    [[followBtn layer] setBorderWidth:1.0f];
    [[followBtn layer] setCornerRadius:10.0f];
    [[followBtn layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [followBtn setTitle:@"Follow" forState:UIControlStateNormal];
    [followBtn setTitle:@"Unfollow" forState:UIControlStateHighlighted];
//    [button addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: followBtn];
    
    /**********************************************/
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ProfileTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [detail objectAtIndex:indexPath.row];
    cell.indentationLevel = 2;
    cell.imageView.image = [UIImage imageNamed:@"test.jpg"];
    return cell;
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UIAlertView *messageAlert = [[UIAlertView alloc]
    //                              initWithTitle:@"Row Selected" message:[detail objectAtIndex:indexPath.row] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    //    [messageAlert show];
    NSLog(@"Did select, Passed Row index:%d",indexPath.row);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
