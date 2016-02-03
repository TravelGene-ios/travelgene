//
//  ViewController.m
//  TestTable
//
//  Created by Qiankun Zhuang on 16-2-1.
//  Copyright (c) 2016年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *userName;
    NSArray *detail;
    NSInteger recordNum;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    userName = [NSArray arrayWithObjects:@"Qiankun", @"Yancheng", @"Tina", @"Qiqi", nil];
    detail = [NSArray arrayWithObjects: @"Went to Chicago with my Zhenzhen!",
              @"Went to Orlando",
              @"Went to Boston",
              @"Went to Mexico", nil];
    recordNum = [userName count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return recordNum;
}

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [userName objectAtIndex:indexPath.row];
    cell.indentationLevel = 2;
    cell.detailTextLabel.text = [detail objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"test.jpg"];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
