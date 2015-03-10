//
//  MembershipPlanView.m
//  Restaurant
//
//  Created by IMAC05 on 25/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MembershipPlanView.h"
#import "Constants.h"

#define  kRowHeight 50


@interface MembershipPlanView ()

@end

@implementation MembershipPlanView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    arrayMembershipPlan = [[NSMutableArray alloc]init];
    
    [arrayMembershipPlan addObject:@"4.99"];
    [arrayMembershipPlan addObject:@"9.99"];
    [arrayMembershipPlan addObject:@"19.99"];
    [arrayMembershipPlan addObject:@"29.99"];

    
    labelTopHeader.text = LocalizedString(@"member_plan");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
    //[appDelegate setNavigationController];
    
}


#pragma mark ----
#pragma mark ----  TABLE VIEW DELEGATE -----


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayMembershipPlan count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    
    UILabel *labelPlanName =[[UILabel alloc] init];
    labelPlanName.frame = CGRectMake(23 , 10, DEVICE_WIDTH-130, 30);
    labelPlanName.TextAlignment =  NSTextAlignmentLeft;
    labelPlanName.numberOfLines = 0;
    labelPlanName.backgroundColor = [UIColor clearColor];
    labelPlanName.font = [UIFont fontWithName:_roboto size:15];
    labelPlanName.textColor = kGrayTextColor;
    [cell.contentView addSubview:labelPlanName];
    
    if(indexPath.row == 0)
        labelPlanName.text = @"1 Month";
    else if(indexPath.row == 1)
        labelPlanName.text = @"3 Months";
    else if(indexPath.row == 2)
    labelPlanName.text = @"6 Months";
    else if(indexPath.row == 3)
        labelPlanName.text = @"1 Year";

    UILabel *labelPlanRate =[[UILabel alloc] init];
    labelPlanRate.frame = CGRectMake(DEVICE_WIDTH-80, 10, 60, 30);
    labelPlanRate.TextAlignment =  NSTextAlignmentCenter;
    labelPlanRate.numberOfLines = 0;
    labelPlanRate.text = [NSString stringWithFormat:@"$ %@",[arrayMembershipPlan objectAtIndex:indexPath.row]];
    labelPlanRate.backgroundColor = [UIColor colorWithRed:148.0/255.0 green:236.0/255.0 blue:161.0/255.0 alpha:1];
    labelPlanRate.font = [UIFont fontWithName:_roboto_light size:15];
    labelPlanRate.textColor = kGrayTextColor;
    [cell.contentView addSubview:labelPlanRate];
    
    
    UIView *seperater = [[UIView alloc]init];
    seperater.frame = CGRectMake(20, kRowHeight-1, DEVICE_WIDTH-40, 1);
    seperater.backgroundColor = kGrayTextColor;
    [cell.contentView addSubview:seperater];
    
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
