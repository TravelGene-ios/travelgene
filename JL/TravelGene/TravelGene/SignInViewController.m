//
//  SignInViewController.m
//  TravelGene
//
//  Created by Tina on 2/1/16.
//  Copyright (c) 2016 TravelGene. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

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
    // Do any additional setup after loading the view.
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

- (IBAction)signin:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([_txtUsername.text isEqualToString:@""] || [_txtPassword.text isEqualToString:@""]) {
        NSLog(@"All fields should be filled for registration");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You should fill out all fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
    else if ([_txtUsername.text isEqualToString:[defaults objectForKey:@"username"]] && [_txtPassword.text isEqualToString:[defaults objectForKey:@"password"]]) {
        NSLog(@"Username and password do not match");
        [self performSegueWithIdentifier:@"signin" sender:self];
    }
    else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Your username and password does not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [error show];
    }
}

- (IBAction)backgroupTap:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
