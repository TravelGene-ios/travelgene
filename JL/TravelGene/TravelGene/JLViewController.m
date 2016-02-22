//
//  JLViewController.m
//  TravelGene
//
//  Created by Tina on 1/31/16.
//  Copyright (c) 2016 TravelGene. All rights reserved.
//

#import "JLViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface JLViewController ()

@end

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"1");
	// Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"registered"]) {
        NSLog(@"No user registered");
    }
    else {
        NSLog(@"user is registered");
    }
    // facebook login part
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"email", @"user_friends"];
    
    loginButton.center = CGPointMake((self.view.frame.size.width)/2, (self.view.frame.size.height) - 80);

    [self.view addSubview:loginButton];
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [self performSegueWithIdentifier:@"register_success" sender:self];
        [self performSelector:@selector(loadAuthenticateViewController) withObject:nil afterDelay:0.0];
        NSLog(@"Transfer to the load authentication VC");
    }
}



-(void)viewDidAppear {
    NSLog(@"2");
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        [self performSegueWithIdentifier:@"register_success" sender:self];
        [self performSelector:@selector(loadAuthenticateViewController) withObject:nil afterDelay:1.0];
        NSLog(@"Transfer to the load authentication VC in did appear");
    }
}

//-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView
//                            user:(id<FBGraphUser>)user {
//    [self performSegueWithIdentifier:@"SuccessIfValid" sender:self];
//}


-(void)loadAuthenticateViewController
{
    NSLog(@"3");
    [self performSegueWithIdentifier:@"register_success" sender:self];
    NSLog(@"Facebook logined in segue performed");
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"4");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// function to react if register button is clicked
- (IBAction)registerClicked:(id)sender {
    NSLog(@"5");
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
    NSLog(@"6");
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
    NSLog(@"7");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_txtUsername.text forKey:@"username"];
    [defaults setObject:_txtPassword.text forKey:@"password"];
    [defaults setBool:YES forKey:@"registered"];
    
    // save the password and username to keychain
//    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
//    [keychainItem setObject:_txtPassword.text forKey:@"password"];
//    [keychainItem setObject:_txtUsername.text forKey:@"username"];
    
    // save the password and username to MySQL database
    NSString *password = [defaults objectForKey:@"password"];
    NSString *username = [defaults objectForKey:@"username"];
    
    NSLog(@"mySQL database sumbited!");
    NSLog(@"username: %@", username);
    NSString *urlString = [NSString stringWithFormat:@"http://ec2-52-90-95-189.compute-1.amazonaws.com/adduser2.php?email=%@&password=%@", username, password];
    NSLog(@"url: %@", urlString);
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlString]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
            }] resume];
    NSLog(@"Done!");
    
    [defaults synchronize];
    
    // give the button as alert, indicating the user was registered into system successfully
    UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have registered as a new user" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [success show];
    
    // login the registered new user
    [self performSegueWithIdentifier:@"register_success" sender:self];
}

- (IBAction)signinClicked:(id)sender {
    NSLog(@"8");
    [self performSegueWithIdentifier:@"signin_page" sender:self];
}

- (IBAction)backgroundTap:(id)sender {
    NSLog(@"9");
    [self.view endEditing:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"10");
    [textField resignFirstResponder];
    return YES;
}
@end
