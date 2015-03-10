//
//  UserViewController.m
//  Restaurant
//
//  Created by IMAC05 on 20/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "UserViewController.h"
#import "Constants.h"

#import "MembershipPlanView.h"


@interface UserViewController ()

@end

@implementation UserViewController


-(void)setTabBarView
{
    
    TabBarView *detailsView = [[TabBarView alloc]init];
    detailsView.frame=CGRectMake(0, DEVICE_HEIGHT-kTabbarHeight, DEVICE_WIDTH, kTabbarHeight);
    [self.view addSubview:detailsView];
    
    [detailsView setTabSelection:3];
    
    detailsView.tabFirstSelected =^()
    {
        SearchViewController *search = [[SearchViewController alloc]init];
        [self.navigationController pushViewController:search animated:NO];
        
    };
    
    detailsView.tabSecondSelected =^()
    {
        NearbyViewController *nearby = [[NearbyViewController alloc]init];
        [self.navigationController pushViewController:nearby animated:NO];
        
    };
    
    detailsView.tabThirdSelected =^()
    {
        CategoryViewController *category = [[CategoryViewController alloc]init];
        [self.navigationController pushViewController:category animated:NO];
        
    };
    
    detailsView.tabFourthSelected =^()
    {
        UserViewController *user = [[UserViewController alloc]init];
        [self.navigationController pushViewController:user animated:NO];
        
    };
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
        isEnglish = YES;
    else
        isEnglish = NO;

    [self setTabBarView];
    
    arrayOptions = [[NSMutableArray alloc]init];
    
    [arrayOptions addObject:LocalizedString(@"edit_profile")];
    [arrayOptions addObject:LocalizedString(@"change_pass")];
    [arrayOptions addObject:LocalizedString(@"account_setting")];
    [arrayOptions addObject:LocalizedString(@"news_pref")];
    [arrayOptions addObject:LocalizedString(@"member_plan")];

    
    labelTopHeader.text = LocalizedString(@"account");
    
    imageUserProfile.image = [UIImage imageNamed:@"profile"];
    imageUserProfile.layer.cornerRadius = imageUserProfile.frame.size.height/2;
    imageUserProfile.layer.masksToBounds = YES;
    
    labelUserName.font = [UIFont fontWithName:_roboto_light size:18];
    labelUserName.text = @"James Bond";
    
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 450);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ----
#pragma mark ----  TABLE VIEW DELEGATE -----


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayOptions count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

    UILabel *labelOptions =[[UILabel alloc] init];
    labelOptions.frame = CGRectMake(isEnglish ? 15 : 45, 10, DEVICE_WIDTH-60, 30);
    labelOptions.TextAlignment =  isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelOptions.text = [arrayOptions objectAtIndex:indexPath.row];
    labelOptions.backgroundColor = [UIColor clearColor];
    labelOptions.font = [UIFont fontWithName:_roboto_light size:15];
    labelOptions.textColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:labelOptions];

    
    UIImageView *imageArrow = [[UIImageView alloc]init];
    imageArrow.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-45 : 15, 10, 30, 30);
    imageArrow.image = [UIImage imageNamed:isEnglish ? @"next" : @"next_ar"];
    //imageArrow.backgroundColor  = [UIColor redColor];
    imageArrow.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageArrow];

    UIView *seperater = [[UIView alloc]init];
    seperater.frame = CGRectMake(15, 49, DEVICE_WIDTH-30, 1);
    seperater.backgroundColor = kGrayTextColor;
    [cell.contentView addSubview:seperater];

    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(indexPath.row == 4)
    {
        MembershipPlanView *plan = [[MembershipPlanView alloc]init];
        [self.navigationController pushViewController:plan animated:YES];
        
    }
    
    
}



@end
