//
//  TripOverviewViewController.m
//  PushingTableView
//
//  Created by 刘智月 on 2/24/16.
//  Copyright (c) 2016 zhiyue. All rights reserved.
//

#import "TripOverviewViewController.h"
#import "RestaurantTableViewController.h"

@interface TripOverviewViewController ()

@end

@implementation TripOverviewViewController
@synthesize delegate, name, selectedFlights, selectedHotels, selectedRestaurants;
//@synthesize test_label;

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
    
    NSMutableString * flightResult = [[NSMutableString alloc] init];

    NSMutableString * hotelResult = [[NSMutableString alloc] init];

    NSMutableString * restaurantResult = [[NSMutableString alloc] init];
    for (NSObject * obj in selectedFlights)
    {
        [flightResult appendString:[obj description]];
        [flightResult appendString:@"  "];
    }
    for (NSObject * obj in selectedHotels)
    {
        [hotelResult appendString:[obj description]];
        [hotelResult appendString:@"  "];
    }
    for (NSObject * obj in selectedRestaurants)
    {
        [restaurantResult appendString:[obj description]];
        [restaurantResult appendString:@"  "];
    }

    // Do any additional setup after loading the view from its nib.
    _test_label.text = name;
    _flight_label.text = flightResult;
    _hotel_label.text = hotelResult;
    _restaurant_label.text = restaurantResult;
//    NSLog(@"text: %@", _flight_label.text);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
