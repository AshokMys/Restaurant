//
//  AddRestaurantView.m
//  Restaurant
//
//  Created by IMAC05 on 23/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "AddRestaurantView.h"
#import "AddRestaurantPhotos.h"
#import "Constants.h"
#import "MapViewController.h"

@interface AddRestaurantView ()

@end

@implementation AddRestaurantView

@synthesize isEditable;


-(void)setTabBarView
{
    
    TabBarView *detailsView = [[TabBarView alloc]init];
    detailsView.frame=CGRectMake(0, DEVICE_HEIGHT-kTabbarHeight, DEVICE_WIDTH, kTabbarHeight);
    [self.view addSubview:detailsView];
    
    //[detailsView.btnTabThird setImage:[UIImage imageNamed:@"tab_selected"] forState:UIControlStateNormal];
    
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

    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 550);

    [self setUIAsPerLanguage];

    if(isEditable)
    {
        labelTopHeader.text = LocalizedString(@"edit_restaurant");

        textRestName.text = @"Yash Palace";
        textAddress.text = @" Yerwad, Pune";
        textSpecification.text = @"Pure Veg";
        textFBLink.text = @"www.google.com";
        textTwitterLink.text = @"www.google.com";
        
    }
}


-(void)setUIAsPerLanguage
{
    labelTopHeader.text = LocalizedString(@"add_restaurant");

    
    labelCategory.text = LocalizedString(@"category");
    textAddress.placeholder = LocalizedString(@"address");

    textRestName.placeholder = LocalizedString(@"rest_name");
    textSpecification.placeholder = LocalizedString(@"specification");
    textFBLink.placeholder = LocalizedString(@"fb_link");
    textTwitterLink.placeholder = LocalizedString(@"twitter_link");
    
    labelMapPlaceholder.text = LocalizedString(@"map");
    [btnNext setTitle:LocalizedString(@"next") forState:UIControlStateNormal];
    
    labelSocialMediaPlaceholder.text = LocalizedString(@"social_media");
    
    textAddress.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    textRestName.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textSpecification.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textFBLink.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textTwitterLink.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    labelSocialMediaPlaceholder.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelMapPlaceholder.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];
    
    
    [btnMap addSubview:labelMapPlaceholder];
    labelMapPlaceholder.frame = CGRectMake(5, 0, btnMap.frame.size.width-10, btnMap.frame.size.height);
    [btnMap addSubview:imageMapNext];
    imageMapNext.frame = CGRectMake(isEnglish ? btnMap.frame.size.width -25 : 5, 5, 20, btnMap.frame.size.height-10);
    imageMapNext.contentMode = UIViewContentModeScaleAspectFit;
    
    
    textAddress.layer.cornerRadius = 5.0;
    textAddress.layer.masksToBounds = YES;
    textAddress.layer.borderColor = [[UIColor colorWithRed:222.0/255.0 green:221.0/255.0 blue:216.0/255.0 alpha:1] CGColor];
    textAddress.layer.borderWidth = 1.0;
    
    
    textRestName.font = [UIFont fontWithName:_roboto_light size:15];
    textSpecification.font = [UIFont fontWithName:_roboto_light size:15];
    textAddress.font = [UIFont fontWithName:_roboto_light size:15];
    
    textFBLink.font = [UIFont fontWithName:_roboto_light size:15];
    textTwitterLink.font = [UIFont fontWithName:_roboto_light size:15];
    
    labelMapPlaceholder.font = [UIFont fontWithName:_roboto size:15];
    labelSocialMediaPlaceholder.font = [UIFont fontWithName:_roboto size:16];
    
    labelCategory.font = [UIFont fontWithName:_roboto size:16];
    btnMap.titleLabel.font = [UIFont fontWithName:_roboto size:16];
    btnNext.titleLabel.font = [UIFont fontWithName:_roboto size:16];

    
    if(isEnglish)
    {
        UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textRestName.leftViewMode = UITextFieldViewModeAlways;
        textRestName.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textSpecification.leftViewMode = UITextFieldViewModeAlways;
        textSpecification.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textFBLink.leftViewMode = UITextFieldViewModeAlways;
        textFBLink.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textTwitterLink.leftViewMode = UITextFieldViewModeAlways;
        textTwitterLink.leftView = paddingUserName;

        imageMapNext.image  = [UIImage imageNamed:@"next"];

    }
    else
    {
        
        UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textRestName.rightViewMode = UITextFieldViewModeAlways;
        textRestName.rightView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textSpecification.rightViewMode = UITextFieldViewModeAlways;
        textSpecification.rightView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textFBLink.rightViewMode = UITextFieldViewModeAlways;
        textFBLink.rightView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
        textTwitterLink.rightViewMode = UITextFieldViewModeAlways;
        textTwitterLink.rightView = paddingUserName;

        imageMapNext.image  = [UIImage imageNamed:@"next_ar"];

    }
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

-(IBAction)btnMapTapped:(id)sender
{
    
    MapViewController *map = [[MapViewController alloc]init];
    [self.navigationController pushViewController:map animated:YES];
    
}


-(IBAction)btnNextTapped:(id)sender
{
    AddRestaurantPhotos *photos = [[AddRestaurantPhotos alloc]init];
    photos.isEditable = isEditable;
    [self.navigationController pushViewController:photos animated:YES];
    
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
