//
//  FirstViewController.m
//  TravelGeneqiqi
//
//  Created by shiqiqi on 2/10/16.
//  Copyright © 2016 shiqiqi. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

//departDate Update
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


- (IBAction)submitClicked:(UIButton *)sender {
}

@end
