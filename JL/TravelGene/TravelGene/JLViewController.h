//
//  JLViewController.h
//  TravelGene
//
//  Created by Tina on 1/31/16.
//  Copyright (c) 2016 TravelGene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *signinBtn;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtRepeatPassword;

- (IBAction)registerClicked:(id)sender;
- (IBAction)signinClicked:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end
