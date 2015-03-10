//
//  SearchViewController.m
//  Restaurant
//
//  Created by IMAC05 on 20/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "SearchViewController.h"
#import "Constants.h"

@interface SearchViewController ()

@end

@implementation SearchViewController


-(void)setTabBarView
{
    
    TabBarView *detailsView = [[TabBarView alloc]init];
    detailsView.frame=CGRectMake(0, DEVICE_HEIGHT-kTabbarHeight, DEVICE_WIDTH, kTabbarHeight);
    [self.view addSubview:detailsView];
    
    //[detailsView.btnTabThird setImage:[UIImage imageNamed:@"tab_selected"] forState:UIControlStateNormal];
    
    [detailsView setTabSelection:0];
    
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

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
        isEnglish = YES;
    else
        isEnglish = NO;
    

    [self setTabBarView];

    [self setUIAsPerLanguage];
    
}


-(void)setUIAsPerLanguage
{
    btnBack.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-45, 25, 35, 34);
    [btnBack setImage:[UIImage imageNamed:isEnglish ? @"back" : @"back_ar"] forState:UIControlStateNormal];
    
    
    labelTopHeader.text = LocalizedString(@"search");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];
    
    [btnSearch setTitle:LocalizedString(@"search") forState:UIControlStateNormal];
    btnSearch.titleLabel.font = [UIFont fontWithName:_roboto size:18];
    
    textArea.font = [UIFont fontWithName:_roboto size:14];
    textFoodType.font = [UIFont fontWithName:_roboto size:14];
    textKeyword.font = [UIFont fontWithName:_roboto size:14];
    textCategory.font = [UIFont fontWithName:_roboto size:14];
    
    textArea.placeholder = LocalizedString(@"by_area");
    textFoodType.placeholder = LocalizedString(@"by_foodtype");
    textCategory.placeholder = LocalizedString(@"by_category");
    textKeyword.placeholder = LocalizedString(@"by_keyword");
    
    textArea.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textFoodType.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textCategory.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textKeyword.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    
    if(isEnglish)
    {
        UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textArea.leftViewMode = UITextFieldViewModeAlways;
        textArea.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textFoodType.leftViewMode = UITextFieldViewModeAlways;
        textFoodType.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textKeyword.leftViewMode = UITextFieldViewModeAlways;
        textKeyword.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textCategory.leftViewMode = UITextFieldViewModeAlways;
        textCategory.leftView = paddingUserName;
        
        
    }
    else
    {
        UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textArea.leftViewMode = UITextFieldViewModeAlways;
        textArea.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textFoodType.leftViewMode = UITextFieldViewModeAlways;
        textFoodType.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textKeyword.leftViewMode = UITextFieldViewModeAlways;
        textKeyword.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textCategory.leftViewMode = UITextFieldViewModeAlways;
        textCategory.leftView = paddingUserName;
        
    }
    
   
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)btnSearchTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Search --");
#endif
    
}

#pragma mark -------- -----------
#pragma mark ---- TEXT FIELD DELEGATE -----


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}



@end
