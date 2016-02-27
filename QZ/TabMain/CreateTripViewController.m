//
//  CreateTripViewController.m
//  TabMain
//
//  Created by Qiankun Zhuang on 2/21/16.
//  Copyright © 2016 Qiankun Zhuang. All rights reserved.
//

//modify: Qiqi

#import "CreateTripViewController.h"
#import "InterestTableViewController.h"


@interface CreateTripViewController ()

@end

@implementation CreateTripViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Create Trip";
    [_destination setDelegate:self];
    
    
    //depart Date Picker
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker addTarget:self action:@selector(dateUpdated:) forControlEvents:UIControlEventValueChanged];
    self.departDate.inputView = datePicker;
    
    //return Date Picker
    returnDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    returnDatePicker.datePickerMode = UIDatePickerModeDate;
    
    returnDatePicker.backgroundColor = [UIColor whiteColor];
    [returnDatePicker addTarget:self action:@selector(returndateUpdated:) forControlEvents:UIControlEventValueChanged];
    self.returnDate.inputView = returnDatePicker;
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonWasPressed:)];
    UIBarButtonItem *flexibleSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[flexibleSeparator, doneButton];
    self.departDate.inputAccessoryView = toolbar;
    
    self.returnDate.inputAccessoryView=toolbar;
}


// when click return
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


//touch background to exit
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (void) dateUpdated:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.departDate.text = [formatter stringFromDate:datePicker.date];
}


//returnDate Update
- (void) returndateUpdated:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.returnDate.text = [formatter stringFromDate:datePicker.date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-  (IBAction)submit:(id)sender {
    NSLog(@"here here here");
    
    NSDate *today=[NSDate date];
    
    if ([_destination.text isEqualToString:@""]) {
        NSLog(@"All fields should be filled for registration");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You should fill out all fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }else if ([datePicker.date compare:today]==NSOrderedAscending) {
        NSLog(@"Depart Date should be after today");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You should change your depart date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }else if([returnDatePicker.date compare:datePicker.date]==NSOrderedAscending){
        NSLog(@"Return Date should be after depart Date");
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You should change your return date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }else{
        [self performSegueWithIdentifier:@"InterestViewController" sender:self];
    }
    NSLog(@"submit end");
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"InterestViewController"]){
        InterestTableViewController *destViewController=segue.destinationViewController;
        destViewController.destination=_destination.text;
        destViewController.startDate=datePicker.date;
        destViewController.endDate=returnDatePicker.date;
        if ([[_segment titleForSegmentAtIndex:_segment.selectedSegmentIndex] isEqualToString:@"3+"]){
            destViewController.groupnumber=3;
        }else{
        destViewController.groupnumber=[[_segment titleForSegmentAtIndex:_segment.selectedSegmentIndex] intValue];
        }
    }
    NSLog(@"prepare end");
}

@end
