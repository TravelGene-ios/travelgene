//
//  ViewController.m
//  LYC_MYSQL
//
//  Created by Charles on 2/21/16.
//  Copyright © 2016 TravelGene. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateDB {
    NSString *email = @"john@gamil.com";
    NSString *password = @"123456";
    
    NSString *url = [NSString stringWithFormat:@"http://ec2-52-90-95-189.compute-1.amazonaws.com/adduser2.php?email=%@&password=%@", email, password];
    
    // build the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body= [NSMutableData data];
    [request setHTTPBody:body];
    
    // getting answer from the server.
    // you can echo message from the server let's say :"Update finish" or something like that...
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:nil];
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"returned: %@", returnString);

}

- (IBAction)submitBtn:(id)sender {
    NSLog(@"sumbited!");
    NSString *email = @"john3333@gamil.com";
    NSString *password = @"123456";
    NSLog(@"email: %@", email);
    NSString *urlString = [NSString stringWithFormat:@"http://ec2-52-90-95-189.compute-1.amazonaws.com/adduser2.php?email=%@&password=%@", email, password];
    NSLog(@"url: %@", urlString);
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlString]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
            }] resume];
    NSLog(@"Done!");
}


@end
