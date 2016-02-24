//
//  InterestDetailViewController.h
//  TravelGeneqiqi
//
//  Created by shiqiqi on 2/11/16.
//  Copyright © 2016 shiqiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterestDetailViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSString *interestName;
@property (weak, nonatomic) IBOutlet UICollectionView *myPictureCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *rate;
@property (weak, nonatomic) IBOutlet UITextField *address;

@end
