//
//  CategoryViewController.m
//  Restaurant
//
//  Created by IMAC05 on 24/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "CategoryViewController.h"
#import "Constants.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController


-(void)setTabBarView
{
    
    TabBarView *detailsView = [[TabBarView alloc]init];
    detailsView.frame=CGRectMake(0, DEVICE_HEIGHT-kTabbarHeight, DEVICE_WIDTH, kTabbarHeight);
    [self.view addSubview:detailsView];
    
    [detailsView setTabSelection:2];
    
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
        //[self btnSeeAllTapped:nil];
        
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
    
    arrayCategoryData = [[NSMutableArray alloc]init];
    
    [arrayCategoryData addObject:@"Category 1"];
    [arrayCategoryData addObject:@"Category 2"];
    [arrayCategoryData addObject:@"Category 3"];
    [arrayCategoryData addObject:@"Category 4"];
    [arrayCategoryData addObject:@"Category 5"];
    [arrayCategoryData addObject:@"Category 6"];
    [arrayCategoryData addObject:@"Category 7"];
    [arrayCategoryData addObject:@"Category 8"];
    [arrayCategoryData addObject:@"Category 9"];
    [arrayCategoryData addObject:@"Category 10"];
    [arrayCategoryData addObject:@"Category 11"];
    [arrayCategoryData addObject:@"Category 12"];
    [arrayCategoryData addObject:@"Category 13"];
    [arrayCategoryData addObject:@"Category 14"];
    [arrayCategoryData addObject:@"Category 15"];
    
    
    [self setCategoryView];
    
    [self setUIAccordingLanguage];
    
}



-(void)setUIAccordingLanguage
{
    labelTopHeader.text = LocalizedString(@"category");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];

    
    btnBack.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-45, 25, 35, 34);
    [btnBack setImage:[UIImage imageNamed:isEnglish ? @"back" : @"back_ar"] forState:UIControlStateNormal];
    
    textSearch.placeholder = LocalizedString(@"search_placeholder");
    textSearch.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textSearch.font = [UIFont fontWithName:_roboto_light size:14];
    
    btnSearch.frame = CGRectMake(isEnglish ? textSearch.frame.origin.x + textSearch.frame.size.width -30 : textSearch.frame.origin.x + 5, 72, 26, 26);
    
    
    if(isEnglish)
    {
        UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
        textSearch.leftViewMode = UITextFieldViewModeAlways;
        textSearch.leftView = paddingUserName;
        
        UIView *padding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 32)];
        textSearch.rightViewMode = UITextFieldViewModeAlways;
        textSearch.rightView = padding;
        
    }
    else
    {
        UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
        textSearch.rightViewMode = UITextFieldViewModeAlways;
        textSearch.rightView = paddingUserName;
        
        UIView *padding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 32)];
        textSearch.leftViewMode = UITextFieldViewModeAlways;
        textSearch.leftView = padding;
        
    }
    
}



-(void)setCategoryView
{
    int xPos = 10;
    int yPos = 10;
    
    int kCategoryButtonWidth = (DEVICE_WIDTH-30)/2;
    int kCategoryButtonHeight = 140;
    
    
    for(int i=0; i<[arrayCategoryData count]; i++)
    {
        btnCategory = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCategory.frame = CGRectMake(xPos, yPos, kCategoryButtonWidth, kCategoryButtonHeight);
        //[btnCategory setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        //[btnCategory setTitle:@"Forgot Password?" forState:UIControlStateNormal];
        btnCategory.titleLabel.font = [UIFont fontWithName:_roboto size:18];
        btnCategory.titleLabel.textAlignment = NSTextAlignmentRight;
        btnCategory.backgroundColor = [UIColor clearColor];
        [btnCategory addTarget:self action:@selector(btnCategoryTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnCategory];
        
        
        UIImageView *imageCategory = [[UIImageView alloc]init];
        imageCategory.frame = CGRectMake(0, 0, btnCategory.frame.size.width, kCategoryButtonHeight-30);
        imageCategory.image = [UIImage imageNamed:@"dummy"];
        [btnCategory addSubview:imageCategory];
        
        UILabel *labelCategory = [[UILabel alloc]init];
        labelCategory.frame = CGRectMake(0, kCategoryButtonHeight - 30, kCategoryButtonWidth, 30);
        labelCategory.textColor = [UIColor darkGrayColor];
        labelCategory.backgroundColor = [UIColor clearColor];
        labelCategory.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
        labelCategory.font = [UIFont fontWithName:_roboto_light size:16];
        labelCategory.text = [arrayCategoryData objectAtIndex:i];
        labelCategory.contentMode = UIViewContentModeScaleAspectFit;
        
        [btnCategory addSubview:labelCategory];
        
        xPos+= kCategoryButtonWidth+10;
        
        if((i+1)%2 == 0)
        {
            xPos = 10;
            yPos+= kCategoryButtonHeight + 10;
            
        }
        
        
    }
    
    if([arrayCategoryData count]%2 != 0)
        yPos+= kCategoryButtonHeight + 10;
    
    //scrollCategory.backgroundColor = [UIColor blueColor];
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, yPos);
    
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

-(void)btnCategoryTapped:(id)sender
{
    
}

@end
