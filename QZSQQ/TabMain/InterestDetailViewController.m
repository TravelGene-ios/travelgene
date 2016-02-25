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
    
    NSLog(@"InterestDetails");
    
    _rate.text=_localrate;
    _address.text=_localaddress;
    self.title=_interestName;
    
    [[self myPictureCollectionView]setDataSource:self];
    [[self myPictureCollectionView]setDelegate:self];
    
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
