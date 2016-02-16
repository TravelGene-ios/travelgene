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
    
    datePicker=[[UIDatePicker alloc] init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.departDate setInputView:datePicker];
    
    seconddata=[[UIDatePicker alloc] init];
    seconddata.datePickerMode=UIDatePickerModeDate;
    [self.returnDate setInputView:seconddata];
    
    
    UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor redColor]];
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(ShowSelectedDate)];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                        target:nil
                                                                        action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneButton,nil]];
    
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


-(void)ShowSelectedDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/mm/yyyy"];
    self.departDate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.departDate resignFirstResponder];
    
    self.returnDate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:seconddata.date]];
    [self.returnDate resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitClicked:(UIButton *)sender {
}

@end
