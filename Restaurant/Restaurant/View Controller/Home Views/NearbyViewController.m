//
//  NearbyViewController.m
//  Restaurant
//
//  Created by IMAC05 on 19/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "NearbyViewController.h"
#import "Constants.h"
#import "HomeViewController.h"

#import "RestaurantDetailsView.h"
#import "CustomAlertView.h"

#import "AddRestaurantView.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController

@synthesize isManageRestaurant;


-(void)setTabBarView
{
    
    TabBarView *detailsView = [[TabBarView alloc]init];
    detailsView.frame=CGRectMake(0, DEVICE_HEIGHT-kTabbarHeight, DEVICE_WIDTH, kTabbarHeight);
    
    [self.view addSubview:detailsView];
    
    if(!isManageRestaurant)
    [detailsView setTabSelection:1];
    
    
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

-(void)viewWillAppear:(BOOL)animated
{
    [self setTabBarView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
        isEnglish = YES;
    else
        isEnglish = NO;
    
    arrayCategoryData = [[NSMutableArray alloc]init];
    
    [arrayCategoryData addObject:@"Category 1"];
    [arrayCategoryData addObject:@"Category 2"];
    [arrayCategoryData addObject:@"Category 3"];
    [arrayCategoryData addObject:@"Category 4"];
    
    
    //[self setNavigationBar];

    [self setNearbyView];
    
    [self setUIAccordingLanguage];

}


-(void)setUIAccordingLanguage
{
    labelTopHeader.text = LocalizedString(@"near_by");
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

/*
-(void)setNavigationBar
{
    UINavigationBar *localNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    
    [localNavigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *btnMenu=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnMenu setBackgroundColor:[UIColor clearColor]];
    [btnMenu setFrame:CGRectMake(0, 0, 26, 24)];
    [btnMenu setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btnMenu addTarget:self action:@selector(btnBackTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:btnMenu];
    
    // Title
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *labelHeaderTitle=[[UILabel alloc] init];
    labelHeaderTitle.frame = CGRectMake(0, 0, 100, 30);
    labelHeaderTitle.text = @"Home";
    labelHeaderTitle.textAlignment = NSTextAlignmentCenter;
    labelHeaderTitle.textColor = [UIColor whiteColor];
    labelHeaderTitle.font = [UIFont fontWithName:@"Helvetica" size:20];
    [titleView addSubview:labelHeaderTitle];
    
    [navigationItem setTitleView:titleView];
    
    
    UILabel *labelLocation=[[UILabel alloc] init];
    labelLocation.frame = CGRectMake(0, 0, 80, 30);
    labelLocation.text = @"Maria Bay";
    labelLocation.textAlignment = NSTextAlignmentCenter;
    labelLocation.textColor = [UIColor whiteColor];
    labelLocation.backgroundColor = [UIColor clearColor];
    labelLocation.font = [UIFont fontWithName:@"Helvetica" size:16];
    [titleView addSubview:labelLocation];
    
    
    
    UIButton *btnCurrentLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCurrentLocation setFrame:CGRectMake(0, 0, 30, 31)];
    [btnCurrentLocation setImage:[UIImage imageNamed:@"location_icon"] forState:UIControlStateNormal];
    [btnCurrentLocation addTarget:self action:@selector(btnCurrentLocationTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *navBtnSearch = [[UIBarButtonItem alloc] initWithCustomView:labelLocation];
    UIBarButtonItem *navBtnCart = [[UIBarButtonItem alloc] initWithCustomView:btnCurrentLocation];
    
    if (isEnglish)
    {
        [navigationItem setLeftBarButtonItems:@[leftButton]];
        [navigationItem setRightBarButtonItems:@[navBtnCart,navBtnSearch]];
    }
    else
    {
        [navigationItem setRightBarButtonItems:@[leftButton]];
        [navigationItem setLeftBarButtonItems:@[navBtnCart, navBtnSearch]];
    }
    
    localNavigationBar.items = @[ navigationItem ];
    
    [self.view addSubview:localNavigationBar];
    
}
*/

-(void)btnCurrentLocationTapped
{
    NSLog(@"-- CurrentLocation --");
    
    
   
}

-(IBAction)btnBackTapped:(id)sender
{
    for (id controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[HomeViewController class]])
        {
            [self.navigationController popToViewController:controller animated:NO];
            break;
            
        }
    }
    
    HomeViewController *home = [[HomeViewController alloc]init];
    [self.navigationController pushViewController:home animated:NO];

}

-(void)setNearbyView
{
    int xPos = 0;
    int yPos = 0;
    
    int kCategoryButtonWidth = DEVICE_WIDTH;
    int kCategoryButtonHeight = 250;
    
    
    for (id subview in scrollView.subviews)
    {
        //if ([[subview class] isSubclassOfClass: [UIButton class]])
            [subview removeFromSuperview];
        
    }

    if([arrayCategoryData count] !=0)
    {
        for(int i=0; i<[arrayCategoryData count]; i++)
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
            
            if(isManageRestaurant)
            {
                //int kManageButtonWidth = (kCategoryButtonWidth-4)/3;
                
                UIView *manageView = [[UIView alloc]init];
                manageView.frame = CGRectMake(0, 0, btnCategory.frame.size.width, 50);
                manageView.backgroundColor = [UIColor clearColor];
                [btnCategory addSubview:manageView];
                
                UIImageView *imageGradient = [[UIImageView alloc]init];
                imageGradient.frame = CGRectMake(0, 0, btnCategory.frame.size.width, 50);
                imageGradient.image = [UIImage imageNamed:@"gradient"];
                imageGradient.userInteractionEnabled = YES;
                [manageView addSubview:imageGradient];
                
                /*
                 UIView *separaterFirst = [[UIView alloc]init];
                 separaterFirst.frame = CGRectMake(kManageButtonWidth, 5, 2, 40);
                 separaterFirst.backgroundColor = [UIColor whiteColor];
                 [manageView addSubview:separaterFirst];
                 
                 UIView *separaterSecond = [[UIView alloc]init];
                 separaterSecond.frame = CGRectMake(kManageButtonWidth*2+2, 5, 2, 40);
                 separaterSecond.backgroundColor = [UIColor whiteColor];
                 [manageView addSubview:separaterSecond];
                 
                 
                 UIButton *btnViewReataurent= [UIButton buttonWithType:UIButtonTypeCustom];
                 btnViewReataurent.frame = CGRectMake(isEnglish ? 0 : 0, 0, kManageButtonWidth, 50);
                 btnViewReataurent.tag = i;
                 //btnViewReataurent.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
                 //btnViewReataurent.titleLabel.textAlignment = NSTextAlignmentRight;
                 btnViewReataurent.backgroundColor = [UIColor clearColor];
                 [btnViewReataurent addTarget:self action:@selector(btnViewReataurentTapped:) forControlEvents:UIControlEventTouchUpInside];
                 [manageView addSubview:btnViewReataurent];
                 
                 UIImageView *imageViewRestaurent = [[UIImageView alloc]init];
                 imageViewRestaurent.frame = CGRectMake(isEnglish ? 10 : 5, 10, 30, 30);
                 imageViewRestaurent.image = [UIImage imageNamed:@"view-icon"];
                 imageViewRestaurent.contentMode = UIViewContentModeScaleAspectFit;
                 [btnViewReataurent addSubview:imageViewRestaurent];
                 
                 UILabel *labelViewRestaurant = [[UILabel alloc]init];
                 labelViewRestaurant.frame = CGRectMake(isEnglish ? 45 : 40, 10, kManageButtonWidth-45, 30);
                 labelViewRestaurant.textColor = [UIColor whiteColor];
                 labelViewRestaurant.backgroundColor = [UIColor clearColor];
                 labelViewRestaurant.textAlignment = isEnglish ? NSTextAlignmentLeft :  NSTextAlignmentRight;
                 labelViewRestaurant.font = [UIFont fontWithName:_roboto_light size:16];
                 labelViewRestaurant.text = @"View";
                 [btnViewReataurent addSubview:labelViewRestaurant];
                 */
                
                UIButton *btnEditReataurent= [UIButton buttonWithType:UIButtonTypeCustom];
                btnEditReataurent.frame = CGRectMake(isEnglish ? 10 : kCategoryButtonWidth-60, 0, 30, 30);
                btnEditReataurent.tag = i;
                [btnEditReataurent setImage:[UIImage imageNamed:@"edit-icon"] forState:UIControlStateNormal];
                //btnViewReataurent.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
                //btnViewReataurent.titleLabel.textAlignment = NSTextAlignmentRight;
                btnEditReataurent.backgroundColor = [UIColor clearColor];
                [btnEditReataurent addTarget:self action:@selector(btnEditReataurentTapped:) forControlEvents:UIControlEventTouchUpInside];
                [manageView addSubview:btnEditReataurent];
                
                /*
                 UIImageView *imageEditRestaurent = [[UIImageView alloc]init];
                 imageEditRestaurent.frame = CGRectMake(isEnglish ? 10 : 5, 10, 30, 30);
                 imageEditRestaurent.image = [UIImage imageNamed:@"edit"];
                 imageEditRestaurent.contentMode = UIViewContentModeScaleAspectFit;
                 [btnEditReataurent addSubview:imageEditRestaurent];
                 
                 UILabel *labelEditRestaurant = [[UILabel alloc]init];
                 labelEditRestaurant.frame = CGRectMake(isEnglish ? 45 : 40, 10, kManageButtonWidth-45, 30);
                 labelEditRestaurant.textColor = [UIColor whiteColor];
                 labelEditRestaurant.backgroundColor = [UIColor clearColor];
                 labelEditRestaurant.textAlignment = isEnglish ? NSTextAlignmentLeft :  NSTextAlignmentRight;
                 labelEditRestaurant.font = [UIFont fontWithName:_roboto_light size:16];
                 labelEditRestaurant.text = @"Edit";
                 [btnEditReataurent addSubview:labelEditRestaurant];
                 */
                
                UIButton *btnRemoveReataurent= [UIButton buttonWithType:UIButtonTypeCustom];
                btnRemoveReataurent.frame = CGRectMake(isEnglish ? kCategoryButtonWidth-40 : 10, 0, 30, 30);
                btnRemoveReataurent.tag = i;
                [btnRemoveReataurent setImage:[UIImage imageNamed:@"delete-icon"] forState:UIControlStateNormal];
                //btnViewReataurent.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
                //btnViewReataurent.titleLabel.textAlignment = NSTextAlignmentRight;
                btnRemoveReataurent.backgroundColor = [UIColor clearColor];
                [btnRemoveReataurent addTarget:self action:@selector(btnRemoveReataurentTapped:) forControlEvents:UIControlEventTouchUpInside];
                [manageView addSubview:btnRemoveReataurent];
                /*
                 UIImageView *imageRemoveRestaurent = [[UIImageView alloc]init];
                 imageRemoveRestaurent.frame = CGRectMake(isEnglish ? 10 : 5, 10, 30, 30);
                 imageRemoveRestaurent.image = [UIImage imageNamed:@"delete-icon"];
                 imageRemoveRestaurent.contentMode = UIViewContentModeScaleAspectFit;
                 [btnRemoveReataurent addSubview:imageRemoveRestaurent];
                 
                 UILabel *labelRemoveRestaurant = [[UILabel alloc]init];
                 labelRemoveRestaurant.frame = CGRectMake(isEnglish ? 45 : 40, 10, kManageButtonWidth-45, 30);
                 labelRemoveRestaurant.textColor = [UIColor whiteColor];
                 labelRemoveRestaurant.backgroundColor = [UIColor clearColor];
                 labelRemoveRestaurant.textAlignment = isEnglish ? NSTextAlignmentLeft :  NSTextAlignmentRight;
                 labelRemoveRestaurant.font = [UIFont fontWithName:_roboto_light size:16];
                 labelRemoveRestaurant.text = @"Remove";
                 [btnRemoveReataurent addSubview:labelRemoveRestaurant];
                 */
                
                //----------
            }
            
            UILabel *labelRestaurantName = [[UILabel alloc]init];
            labelRestaurantName.frame = CGRectMake(isEnglish ? 20 : 80, imageCategory.frame.size.height - 50, kCategoryButtonWidth-100, 20);
            labelRestaurantName.textColor = [UIColor whiteColor];
            labelRestaurantName.backgroundColor = [UIColor clearColor];
            labelRestaurantName.textAlignment = isEnglish ? NSTextAlignmentLeft :  NSTextAlignmentRight;
            labelRestaurantName.font = [UIFont fontWithName:_roboto_light size:18];
            labelRestaurantName.text = @"Restaurant Name";
            [btnCategory addSubview:labelRestaurantName];
            
            UILabel *labelRestaurantAdd = [[UILabel alloc]init];
            labelRestaurantAdd.frame = CGRectMake(isEnglish ? 20 : 80, imageCategory.frame.size.height - 27, kCategoryButtonWidth-100, 20);
            labelRestaurantAdd.textColor = [UIColor whiteColor];
            labelRestaurantAdd.backgroundColor = [UIColor clearColor];
            labelRestaurantAdd.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
            labelRestaurantAdd.font = [UIFont fontWithName:_roboto_light size:16];
            labelRestaurantAdd.text = @"Address";
            [btnCategory addSubview:labelRestaurantAdd];
            
            
            UILabel *labelRestaurantRating = [[UILabel alloc]init];
            labelRestaurantRating.frame = CGRectMake(isEnglish ? DEVICE_WIDTH -50 : 20, imageCategory.frame.size.height - 37, 30, 30);
            labelRestaurantRating.textColor = [UIColor whiteColor];
            labelRestaurantRating.backgroundColor = [UIColor colorWithRed:138.0/255.0 green:211.0/255.0 blue:153.0/255.0 alpha:1];
            labelRestaurantRating.textAlignment = NSTextAlignmentCenter;
            labelRestaurantRating.font = [UIFont fontWithName:_roboto_light size:16];
            labelRestaurantRating.text = @"4.2";
            labelRestaurantRating.layer.cornerRadius = labelRestaurantRating.frame.size.height/2;
            labelRestaurantRating.layer.masksToBounds = YES;
            [btnCategory addSubview:labelRestaurantRating];
            
            UIButton *btnFavourite = [UIButton buttonWithType:UIButtonTypeCustom];
            btnFavourite.frame = CGRectMake(isEnglish ? DEVICE_WIDTH -50 : 20, imageCategory.frame.size.height - 72, 30, 30);
            btnFavourite.tag = i;
            [btnFavourite setImage:[UIImage imageNamed:@"fav_icon_selected"] forState:UIControlStateNormal];
            btnFavourite.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
            btnFavourite.titleLabel.textAlignment = NSTextAlignmentRight;
            btnFavourite.backgroundColor = [UIColor clearColor];
            //[btnFavourite addTarget:self action:@selector(btnCallingTapped:) forControlEvents:UIControlEventTouchUpInside];
            [btnCategory addSubview:btnFavourite];
            
            //-----------
            
            UILabel *labelCategory = [[UILabel alloc]init];
            labelCategory.frame = CGRectMake(20, kCategoryButtonHeight - 45, kCategoryButtonWidth-40, 20);
            labelCategory.textColor = [UIColor darkGrayColor];
            labelCategory.backgroundColor = [UIColor clearColor];
            labelCategory.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
            labelCategory.font = [UIFont fontWithName:_roboto_light size:16];
            labelCategory.text = [arrayCategoryData objectAtIndex:i];
            [btnCategory addSubview:labelCategory];
            
            
            UILabel *labelDistance = [[UILabel alloc]init];
            labelDistance.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-100 : 20, kCategoryButtonHeight - 45, 80, 20);
            labelDistance.textColor = [UIColor darkGrayColor];
            labelDistance.backgroundColor = [UIColor clearColor];
            labelDistance.textAlignment = isEnglish ? NSTextAlignmentRight : NSTextAlignmentLeft;
            labelDistance.font = [UIFont fontWithName:_roboto_light size:16];
            labelDistance.text = @"3.5 Km";
            labelDistance.contentMode = UIViewContentModeScaleAspectFit;
            [btnCategory addSubview:labelDistance];
            
            
            
            UILabel *labelReviews = [[UILabel alloc]init];
            labelReviews.frame = CGRectMake(20, kCategoryButtonHeight - 18, kCategoryButtonWidth -40, 17);
            labelReviews.textColor = [UIColor darkGrayColor];
            labelReviews.backgroundColor = [UIColor clearColor];
            labelReviews.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
            labelReviews.font = [UIFont fontWithName:_roboto_light size:16];
            labelReviews.text = @"100 Reviews | 5 Photos";
            labelReviews.contentMode = UIViewContentModeScaleAspectFit;
            [btnCategory addSubview:labelReviews];
            
            UIButton *btnCalling = [UIButton buttonWithType:UIButtonTypeCustom];
            btnCalling.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-60 : 20, kCategoryButtonHeight - 21, 40, 20);
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
        UILabel *labelRecordNotFound = [[UILabel alloc]init];
        labelRecordNotFound.frame = CGRectMake(15, 10, kCategoryButtonWidth -30, 30);
        labelRecordNotFound.textColor = [UIColor darkGrayColor];
        labelRecordNotFound.backgroundColor = [UIColor clearColor];
        labelRecordNotFound.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
        labelRecordNotFound.font = [UIFont fontWithName:_roboto_light size:16];
        labelRecordNotFound.text = LocalizedString(@"nearby_no_restaurant");
        [scrollView addSubview:labelRecordNotFound];
        
    }
    
    
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, yPos);
    scrollView.backgroundColor = [UIColor whiteColor];
    
}



-(void)btnCategoryTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Category....");
#endif
    
    RestaurantDetailsView *details = [[RestaurantDetailsView alloc]init];
    [self.navigationController pushViewController:details animated:YES];
    
}


-(void)btnCallingTapped:(id)sender
{
#if DEBUG
    NSLog(@"--- Calling....");
#endif
    NSString *phNo = @"+919730134555";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"no_call_facility") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
        [alert show];
        
    }
    
}


-(IBAction)btnEditReataurentTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Edit Restaurant --");
#endif

    AddRestaurantView *addRest = [[AddRestaurantView alloc]init];
    addRest.isEditable = YES;
    [self.navigationController pushViewController:addRest animated:YES];
    
}


-(IBAction)btnRemoveReataurentTapped:(id)sender
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"delete_restaurant") leftButtonTitle:LocalizedString(@"yes") rightButtonTitle:LocalizedString(@"no") showsImage:NO];
    [alert show];
    
    alert.leftBlock = ^()
    {
        [arrayCategoryData removeObjectAtIndex:[sender tag]];
        [self setNearbyView];
        
    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
