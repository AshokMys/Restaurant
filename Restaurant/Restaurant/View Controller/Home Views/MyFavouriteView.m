//
//  MyFavouriteView.m
//  Restaurant
//
//  Created by IMAC05 on 23/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MyFavouriteView.h"

@interface MyFavouriteView ()

@end

@implementation MyFavouriteView


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

    
    arrayFavouritesData = [[NSMutableArray alloc]init];
    
    [arrayFavouritesData addObject:@"TEST 1"];
    //[arrayFavouritesData addObject:@"TEST 2"];
    //[arrayFavouritesData addObject:@"TEST 3"];
    //[arrayFavouritesData addObject:@"TEST 4"];
    //[arrayFavouritesData addObject:@"TEST 5"];
    //[arrayFavouritesData addObject:@"TEST 6"];
    
    [self setTabBarView];
    
    [self setFavouriteView];
    
    
    
    [self setUIAccordingLanguage];

    
}


-(void)setUIAccordingLanguage
{
    labelTopHeader.text = LocalizedString(@"my_fav");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];
    
    
    btnBack.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-45, 25, 35, 34);
    [btnBack setImage:[UIImage imageNamed:isEnglish ? @"back" : @"back_ar"] forState:UIControlStateNormal];
    
    //textSearch.placeholder = LocalizedString(@"search_placeholder");
    //textSearch.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    //textSearch.font = [UIFont fontWithName:_roboto_light size:14];
    
    //btnSearch.frame = CGRectMake(isEnglish ? textSearch.frame.origin.x + textSearch.frame.size.width -30 : textSearch.frame.origin.x + 5, 72, 26, 26);
    
    /*
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
    */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setFavouriteView
{
    int xPos = 0;
    int yPos = 0;
    
    int kCategoryButtonWidth = DEVICE_WIDTH;
    int kCategoryButtonHeight = 250;
    
    if([arrayFavouritesData count] != 0)
    {
        for(int i=0; i<[arrayFavouritesData count]; i++)
        {
            UIButton *btnCategory = [UIButton buttonWithType:UIButtonTypeCustom];
            btnCategory.frame = CGRectMake(xPos, yPos, kCategoryButtonWidth, kCategoryButtonHeight);
            //[btnCategory setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
            //[btnCategory setTitle:@"Forgot Password?" forState:UIControlStateNormal];
            btnCategory.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
            btnCategory.titleLabel.textAlignment = NSTextAlignmentRight;
            btnCategory.backgroundColor = [UIColor clearColor];
            [btnCategory addTarget:self action:@selector(btnCategoryTapped:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:btnCategory];
            
            
            UIImage *image = [UIImage imageNamed:@"dummy"];
            CGSize mySize = CGSizeMake(DEVICE_WIDTH, kCategoryButtonHeight-50);
            UIImage *temp = [appDelegate imageByScalingAndCroppingForSize:mySize SourceImage:image];
            
            UIImageView *imageCategory = [[UIImageView alloc]init];
            imageCategory.frame = CGRectMake(0, 0, btnCategory.frame.size.width, kCategoryButtonHeight-50);
            imageCategory.image = temp;
            imageCategory.contentMode = UIViewContentModeScaleAspectFit;
            [btnCategory addSubview:imageCategory];
            
            //----------
            
            UILabel *labelRestaurantName = [[UILabel alloc]init];
            labelRestaurantName.frame = CGRectMake(20, imageCategory.frame.size.height - 50, kCategoryButtonWidth-100, 20);
            labelRestaurantName.textColor = [UIColor whiteColor];
            labelRestaurantName.backgroundColor = [UIColor clearColor];
            labelRestaurantName.textAlignment = NSTextAlignmentLeft;
            labelRestaurantName.font = [UIFont fontWithName:_roboto_light size:18];
            labelRestaurantName.text = @"Restaurant Name";
            [btnCategory addSubview:labelRestaurantName];
            
            UILabel *labelRestaurantAdd = [[UILabel alloc]init];
            labelRestaurantAdd.frame = CGRectMake(20, imageCategory.frame.size.height - 27, kCategoryButtonWidth-100, 20);
            labelRestaurantAdd.textColor = [UIColor whiteColor];
            labelRestaurantAdd.backgroundColor = [UIColor clearColor];
            labelRestaurantAdd.textAlignment = NSTextAlignmentLeft;
            labelRestaurantAdd.font = [UIFont fontWithName:_roboto_light size:16];
            labelRestaurantAdd.text = @"Address";
            [btnCategory addSubview:labelRestaurantAdd];
            
            
            UILabel *labelRestaurantRating = [[UILabel alloc]init];
            labelRestaurantRating.frame = CGRectMake(DEVICE_WIDTH -50, imageCategory.frame.size.height - 37, 30, 30);
            labelRestaurantRating.textColor = [UIColor whiteColor];
            labelRestaurantRating.backgroundColor = [UIColor colorWithRed:138.0/255.0 green:211.0/255.0 blue:153.0/255.0 alpha:1];
            labelRestaurantRating.textAlignment = NSTextAlignmentCenter;
            labelRestaurantRating.font = [UIFont fontWithName:_roboto_light size:16];
            labelRestaurantRating.text = @"4.2";
            labelRestaurantRating.layer.cornerRadius = labelRestaurantRating.frame.size.height/2;
            labelRestaurantRating.layer.masksToBounds = YES;
            [btnCategory addSubview:labelRestaurantRating];
            
            UIButton *btnFavourite = [UIButton buttonWithType:UIButtonTypeCustom];
            btnFavourite.frame = CGRectMake(DEVICE_WIDTH -50, imageCategory.frame.size.height - 72, 30, 30);
            btnFavourite.tag = i;
            [btnFavourite setImage:[UIImage imageNamed:@"fav_icon_selected"] forState:UIControlStateNormal];
            btnFavourite.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
            btnFavourite.titleLabel.textAlignment = NSTextAlignmentRight;
            btnFavourite.backgroundColor = [UIColor clearColor];
            //[btnFavourite addTarget:self action:@selector(btnCallingTapped:) forControlEvents:UIControlEventTouchUpInside];
            [btnCategory addSubview:btnFavourite];
            
            //-----------
            
            UILabel *labelCategory = [[UILabel alloc]init];
            labelCategory.frame = CGRectMake(20, kCategoryButtonHeight - 45, kCategoryButtonWidth, 20);
            labelCategory.textColor = [UIColor darkGrayColor];
            labelCategory.backgroundColor = [UIColor clearColor];
            labelCategory.textAlignment = NSTextAlignmentLeft;
            labelCategory.font = [UIFont fontWithName:_roboto_light size:16];
            labelCategory.text = [arrayFavouritesData objectAtIndex:i];
            [btnCategory addSubview:labelCategory];
            
            
            UILabel *labelDistance = [[UILabel alloc]init];
            labelDistance.frame = CGRectMake(DEVICE_WIDTH-100, kCategoryButtonHeight - 45, 80, 20);
            labelDistance.textColor = [UIColor darkGrayColor];
            labelDistance.backgroundColor = [UIColor clearColor];
            labelDistance.textAlignment = NSTextAlignmentRight;
            labelDistance.font = [UIFont fontWithName:_roboto_light size:16];
            labelDistance.text = @"3.5 Km";
            labelDistance.contentMode = UIViewContentModeScaleAspectFit;
            [btnCategory addSubview:labelDistance];
            
            
            
            UILabel *labelReviews = [[UILabel alloc]init];
            labelReviews.frame = CGRectMake(20, kCategoryButtonHeight - 18, kCategoryButtonWidth, 15);
            labelReviews.textColor = [UIColor darkGrayColor];
            labelReviews.backgroundColor = [UIColor clearColor];
            labelReviews.textAlignment = NSTextAlignmentLeft;
            labelReviews.font = [UIFont fontWithName:_roboto_light size:15];
            labelReviews.text = @"100 Reviews | 5 Photos";
            labelReviews.contentMode = UIViewContentModeScaleAspectFit;
            [btnCategory addSubview:labelReviews];
            
            UIButton *btnCalling = [UIButton buttonWithType:UIButtonTypeCustom];
            btnCalling.frame = CGRectMake(DEVICE_WIDTH-60, kCategoryButtonHeight - 21, 40, 20);
            btnCalling.tag = i;
            [btnCalling setImage:[UIImage imageNamed:@"call_icon"] forState:UIControlStateNormal];
            btnCalling.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
            btnCalling.titleLabel.textAlignment = NSTextAlignmentRight;
            btnCalling.backgroundColor = [UIColor clearColor];
            [btnCalling addTarget:self action:@selector(btnCallingTapped:) forControlEvents:UIControlEventTouchUpInside];
            [btnCategory addSubview:btnCalling];
            
            yPos+= kCategoryButtonHeight + 5;
            
            
        }
    }
    else
    {
        UILabel *labelReviews = [[UILabel alloc]init];
        labelReviews.frame = CGRectMake(20, 75, DEVICE_WIDTH-40, 30);
        labelReviews.textColor = [UIColor darkGrayColor];
        labelReviews.backgroundColor = [UIColor clearColor];
        labelReviews.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
        labelReviews.font = [UIFont fontWithName:_roboto_light size:15];
        labelReviews.text = @"100 Reviews | 5 Photos";
        labelReviews.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:labelReviews];

    }
    
    
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, yPos);
    scrollView.backgroundColor = [UIColor whiteColor];
    
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    //[appDelegate setNavigationController];
    
}


-(void)btnCategoryTapped:(id)sender
{
    
}


-(void)btnCallingTapped:(id)sender
{
    
}



@end
