//
//  JLViewController.m
//  TravelGene
//
//  Created by Tina on 1/31/16.
//  Copyright (c) 2016 TravelGene. All rights reserved.
//

#import "JLViewController.h"
#import "KeychainItemWrapper.h"

@interface JLViewController ()

@end

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"registered"]) {
        NSLog(@"No user registered");
        //_signinBtn.hidden = YES;
    }
    else {
        NSLog(@"user is registered");
        //_txtRepeatPassword.hidden = YES;
        //_registerBtn.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// function to react if register button is clicked
- (IBAction)registerClicked:(id)sender {
    // if any of the fields is empty, give error
    if ([_txtUsername.text isEqualToString:@""] || [_txtPassword.text isEqualToString:@""] || [_txtRepeatPassword.text isEqualToString:@""]) {
        NSLog(@"All fields should be filled for registration");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You should fill out all fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
    else {
        [self checkPasswordMatch];
    }
}

// check whether the password entered match, if yes, register the user
- (void)checkPasswordMatch {
    if ([_txtPassword.text isEqualToString:_txtRepeatPassword.text]) {
        NSLog(@"passwords matched");
        // if the passwords matched successfully, register
        [self registerNewUser];
    }
    else {
        NSLog(@"passwords do not match");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"The passwords do not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
}

// more logic should be considered in the future after the database set up
// such as, check whether the entered user name exists in the DB or not
- (void) registerNewUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_txtUsername.text forKey:@"username"];
    [defaults setObject:_txtPassword.text forKey:@"password"];
    [defaults setBool:YES forKey:@"registered"];
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
    [keychainItem setObject:_txtPassword.text forKey:@"password"];
    [keychainItem setObject:_txtUsername.text forKey:@"username"];

    /**
     NSString *password = [keychainItem objectForKey:@"password"];
     NSString *username = [keychainItem objectForKey:@"username"];
     */
    
    [defaults synchronize];
    
    UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have registered as a new user" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [success show];
    
    // login the registered new user
    [self performSegueWithIdentifier:@"register_success" sender:self];
}

- (IBAction)signinClicked:(id)sender {
    [self performSegueWithIdentifier:@"signin_page" sender:self];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
