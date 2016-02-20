//
//  ViewController.m
//  MongoDBConnectionExample
//
//  Created by Tony on 16/2/19.
//  Copyright (c) 2016年 Tony. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Example: return the top 2 sopt in New York City
    NSString* path  = @"http://ec2-52-90-95-189.compute-1.amazonaws.com:8888/testjson?count=2&category=spot&city=newyork";
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSData* jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSArray* arrayResult =[dic objectForKey:@"result"];
    //arrayResult is a NSArray saving the JSON data. Each element is one row in database. You could find the detail of arrayResult by using the commented code in the next line
    //NSLog(@"%@", arrayResult);
    
    //Example: Get the first element of the JSON and print the title of it
    NSDictionary* resultDic = [arrayResult objectAtIndex:0];
    NSDictionary* review_list = [resultDic objectForKey:@"review_list"];
    NSLog(@"review_list in first element: %@", review_list);
    NSLog(@"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    NSLog(@"resultDic:%@", resultDic);
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connectMongoDB {
    
}
@end
