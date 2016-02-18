//
//  SignInViewController.h
//  TravelGene
//
//  Created by Tina on 2/1/16.
//  Copyright (c) 2016 TravelGene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *signinBtn;

- (IBAction)signin:(id)sender;
- (IBAction)backgroupTap:(id)sender;

@end
