//
//  InterestTableViewController.m
//  TravelGeneqiqi
//
//  Created by shiqiqi on 2/11/16.
//  Copyright © 2016 shiqiqi. All rights reserved.
//

#import "InterestTableViewController.h"
#import "InterestDetailViewController.h"

@interface InterestTableViewController ()
@property (nonatomic) int count;
@end

@implementation InterestTableViewController{
    NSMutableArray *interest;
    NSMutableArray *rate;
    NSMutableArray *address;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    interest=[[NSMutableArray alloc] init];
    rate=[[NSMutableArray alloc] init];
    address=[[NSMutableArray alloc] init];

    
   // load data from database by query
    NSString* path=[NSString stringWithFormat:@"%@%@%@", @"http://ec2-52-90-95-189.compute-1.amazonaws.com:5000/mongodb_connection_test?city=", _destination, @"&category=spot&count=2"];
    NSLog(path);
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSData* jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSArray* arrayResult =[dic objectForKey:@"result"];
   
   
    // to attach each details to each part
    for (int i=0;i<[arrayResult count];i++){
            NSDictionary* resultDic = [arrayResult objectAtIndex:i];
        
        
        // add title
            NSString *tmp=[resultDic objectForKey:@"title"];
            NSArray *t=[[tmp componentsSeparatedByString:@","] objectAtIndex:0];
           [interest addObject: t];
        
        NSLog(@"add rate");
        //add rate
        NSString *rt=[resultDic objectForKey:@"rating_string"];
        [rate addObject: rt];
        
        NSLog(@"add address");

        
        // add address
        NSString *at=[resultDic objectForKey:@"address"];
        [address addObject: at];
        
        NSLog(@"add review");

        // add review
        NSDictionary* review_list = [resultDic objectForKey:@"review_list"];
    }
    

    
    
    //interest=[NSArray arrayWithObjects:@"Golden Gate Park", @"Golden Gate Bridge", nil];
    self.title = @"Interests";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [interest count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier=@"InterestCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text=[interest objectAtIndex:indexPath.row];
    
    return cell;
}


- (IBAction)touchNextBtn:(id)sender {
    self.count++;
    NSLog(@"count = %d",self.count);
    [self performSegueWithIdentifier:@"FlightViewController" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"arrayDetail"]){

        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        NSLog(@"row%@",indexPath);
        InterestDetailViewController *destViewController=segue.destinationViewController;
        destViewController.interestName=[interest objectAtIndex:indexPath.row];
        destViewController.localrate=[rate objectAtIndex:indexPath.row];
        destViewController.localaddress=[address objectAtIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"arrayDetail" sender:indexPath];
    
}

@end
