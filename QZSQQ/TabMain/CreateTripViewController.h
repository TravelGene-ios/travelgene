//
//  FirstViewController.h
//  TravelGeneqiqi
//
//  Created by shiqiqi on 2/10/16.
//  Copyright © 2016 shiqiqi. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CreateTripViewController : UIViewController<UITextFieldDelegate>
{
    UIDatePicker *datePicker;
    UIDatePicker *returnDatePicker;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITextField *destination;
@property (weak, nonatomic) IBOutlet UITextField *departDate;
@property (weak, nonatomic) IBOutlet UITextField *returnDate;
@end