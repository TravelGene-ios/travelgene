//
//  InterestDetailViewController.m
//  TravelGeneqiqi
//
//  Created by shiqiqi on 2/11/16.
//  Copyright © 2016 shiqiqi. All rights reserved.
//

#import "InterestDetailViewController.h"
#import "Cell.h"

@interface InterestDetailViewController ()

@end

@implementation InterestDetailViewController
{
    NSArray *arrayOfImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self myPictureCollectionView]setDataSource:self];
    [[self myPictureCollectionView]setDelegate:self];
    
    // Load data from database using json
    //Example: return the top 2 sopt in New York City
    NSString* path  = @"http://ec2-52-90-95-189.compute-1.amazonaws.com:5000/mongodb_connection_test?city=newyorks&category=spot&count=2";
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSData* jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSArray* arrayResult =[dic objectForKey:@"result"];
    //arrayResult is a NSArray saving the JSON data. Each element is one row in database. You could find the detail of arrayResult by using the commented code in the next line
    NSLog(@"%@", arrayResult);
    
    //Example: Get the first element of the JSON and print the title of it
    NSDictionary* resultDic = [arrayResult objectAtIndex:0];
    NSDictionary* review_list = [resultDic objectForKey:@"review_list"];
    NSLog(@"review_list in first element: %@", review_list);
    NSLog(@"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    NSLog(@"resultDic:%@", resultDic);
    
    arrayOfImages=[[NSArray alloc]initWithObjects:@"interestDetail.jpg",@"interestDetail.jpg", nil];
    
    // Do any additional setup after loading the view.
}

// datasource and delegate method

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrayOfImages count];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";

    Cell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [[cell cellImage]setImage:[UIImage imageNamed:[arrayOfImages objectAtIndex:indexPath.item]]];
    
    return cell;
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
