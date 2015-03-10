//
//  HomeViewController.m
//  Restaurant
//
//  Created by IMAC05 on 17/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "HomeViewController.h"
#import "Constants.h"
#import "TabBarView.h"
#import "CustomAlertView.h"
#import "LocalizeHelper.h"

#import "NearbyViewController.h"
#import "SearchViewController.h"
#import "UserViewController.h"
#import "CategoryViewController.h"

#import "SelectCityView.h"


#define kAddButtonWidth DEVICE_WIDTH
#define kAddButtonHeight 175

#define kAnimationDelay 0.3
#define kCategoryImageAnimationDuration 1.5

@interface HomeViewController ()

@property (nonatomic,strong) UIPickerView *pickerView;

@end

@implementation HomeViewController



-(void)setTabBarView
{
    
    TabBarView *detailsView = [[TabBarView alloc]init];
    detailsView.frame=CGRectMake(0, DEVICE_HEIGHT-kTabbarHeight, DEVICE_WIDTH, kTabbarHeight);
    detailsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:detailsView];
    
    //[detailsView setTabSelection:2];
    
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

#if DEBUG
    NSLog(@"-- City :%@",[appDelegate retrieveFromUserDefaults:@"CITY"]);
#endif
    
    if([appDelegate retrieveFromUserDefaults:@"CITY"].length ==0)
    {
        SelectCityView *city = [[SelectCityView alloc]init];
        [self.navigationController pushViewController:city animated:NO];
    }
    
    
    UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 32)];
    textSearch.leftViewMode = UITextFieldViewModeAlways;
    textSearch.leftView = paddingUserName;

    
    arrayCategoryData = [[NSMutableArray alloc]init];
    arrayAddData = [[NSMutableArray alloc]init];
    
    
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

    [arrayAddData addObject:@"Asian Food"];
    [arrayAddData addObject:@"Veg"];
    [arrayAddData addObject:@"PizzA"];
    [arrayAddData addObject:@"Burger"];
    [arrayAddData addObject:@"Non veg"];
    
    if(isEnglish)
        xPosCategory = 0;
    else
        xPosCategory = 4*DEVICE_WIDTH;

    
    [self performSelector:@selector(animateCategoryImages) withObject:nil afterDelay:3];

    [self getCategoryDetails];
    
}

- (UIImage *)rotateImage:(UIImage *)image onDegrees:(float)degrees
{
    CGFloat rads = M_PI * degrees / 180;
    float newSide = MAX([image size].width, [image size].height);
    CGSize size =  CGSizeMake(newSide, newSide);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, newSide/2, newSide/2);
    CGContextRotateCTM(ctx, rads);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(-[image size].width/2,-[image size].height/2,size.width, size.height),image.CGImage);
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}

-(void)getCategoryDetails
{
    
    restaurantManager = [[RestaurantManager alloc]init];
    [restaurantManager setRestaurantManagerDelegate:self];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    
    [dataDict setObject:@"load_category" forKey:@"scope"];
    [dataDict setObject:isEnglish ? @"en" : @"ar" forKey:@"lang"];
    
    [restaurantManager getCategoryDetails:dataDict];

    
}

-(void)animateCategoryImages
{
    //NSLog(@"--- animateCategoryImages  ---");
    
    if(isEnglish)
    {
        if(xPosCategory <([arrayAddData count]-1)*DEVICE_WIDTH)
        {
            xPosCategory+=DEVICE_WIDTH;
            
        }
        else
        {
            xPosCategory = 0;
            
            [UIView animateWithDuration:0 animations:^{
                
                [scrollAdd setContentOffset:CGPointMake(xPosCategory, 0) animated:NO];
                
            }completion:^(BOOL finished){
            }];
            
        }
        
    }
    else
    {
        if(xPosCategory >0)
        {
            xPosCategory-=DEVICE_WIDTH;
            
        }
        else
        {
            xPosCategory = DEVICE_WIDTH*([arrayAddData count]-1);
            
            [UIView animateWithDuration:0 animations:^{
                
                [scrollAdd setContentOffset:CGPointMake(xPosCategory, 0) animated:NO];
                
            }completion:^(BOOL finished){
            }];
            
        }
        
    }
    
    
    [UIView animateWithDuration:kCategoryImageAnimationDuration animations:^{
        
        [scrollAdd setContentOffset:CGPointMake(xPosCategory, 0) animated:NO];
        
    }completion:^(BOOL finished){
        
        [self performSelector:@selector(animateCategoryImages) withObject:nil afterDelay:3];
        
    }];
    
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
    [btnMenu setBackgroundImage:[UIImage imageNamed:@"menu_icon"] forState:UIControlStateNormal];
    [btnMenu addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:btnMenu];
    
    // Title
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *labelHeaderTitle=[[UILabel alloc] init];
    labelHeaderTitle.frame = CGRectMake(0, 0, 150, 30);
    labelHeaderTitle.text = @"Home";
    labelHeaderTitle.textAlignment = NSTextAlignmentCenter;
    labelHeaderTitle.textColor = [UIColor whiteColor];
    labelHeaderTitle.backgroundColor = [UIColor clearColor];
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


-(IBAction)btnCurrentLocationTapped:(id)sender
{
    NSLog(@"-- CurrentLocation --");
    
}


-(void)viewWillAppear:(BOOL)animated
{
    if([appDelegate retrieveFromUserDefaults:@"CITY"].length !=0 )
        labelLocation.text = [appDelegate retrieveFromUserDefaults:@"CITY"];
    else
        labelLocation.text = @"";
    
    [self setUIAccordingLanguage];

}

-(void)setUIAccordingLanguage
{
    textSearch.font = [UIFont fontWithName:_roboto_light size:14];
    textSearch.placeholder = LocalizedString(@"search_placeholder");
    textSearch.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    btnSearch.frame = CGRectMake(isEnglish ? DEVICE_WIDTH - 30 - 20 : 25, 75, 26, 26);
    
    labelTopHeader.text = LocalizedString(@"home");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];
    
    labelLocation.font = [UIFont fontWithName:_roboto_light size:14];

    labelFeatured.text = LocalizedString(@"featured");
    labelFeatured.font = [UIFont fontWithName:_roboto_light size:17];
    
    [btnSeeAll setTitle:LocalizedString(@"see_all") forState:UIControlStateNormal];
    btnSeeAll.titleLabel.font = [UIFont fontWithName:_roboto_light size:17];
    
    btnMenu.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-45, 25, 35, 35);
    btnLocation.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-40 : 10, 25, 30, 36);
    labelLocation.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-115 : 45, 27, 80, 30);
    labelLocation.textAlignment = isEnglish ? NSTextAlignmentRight : NSTextAlignmentLeft;

    
    labelFeatured.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH - 10-120, 5, 120, 30);
    labelFeatured.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    btnSeeAll.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-10-80 : 10, 5, 80, 30);
    btnSeeAll.contentEdgeInsets = isEnglish ? UIEdgeInsetsMake(0, 10, 0, 0) : UIEdgeInsetsMake(0, 0, 0, 10);
   
    
    [self setAddvertiseView];
    [self setCategoryView];
    
       
    UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 32)];
    
    if(isEnglish)
    {
        textSearch.rightViewMode = UITextFieldViewModeAlways;
        textSearch.rightView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
        textSearch.leftViewMode = UITextFieldViewModeAlways;
        textSearch.leftView = paddingUserName;
        
        [btnMenu addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        textSearch.leftViewMode = UITextFieldViewModeAlways;
        textSearch.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
        textSearch.rightViewMode = UITextFieldViewModeAlways;
        textSearch.rightView = paddingUserName;
        
        [btnMenu addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.frame = CGRectMake(0, scrollAdd.frame.origin.y + scrollAdd.frame.size.height -20, DEVICE_WIDTH, 20);
    pageControl.numberOfPages = [arrayAddData count];
    [self.view addSubview:pageControl];
    
    
    [self setTabBarView];
    

    
}





-(void)setAddvertiseView
{
    int xPos = 0;
    
    for(int i=0; i<[arrayAddData count]; i++)
    {
        
        btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAdd.frame = CGRectMake(xPos, 0, DEVICE_WIDTH, kAddButtonHeight);
        //[btnAdd setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        //[btnAdd setTitle:@"Forgot Password?" forState:UIControlStateNormal];
        btnAdd.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnAdd.titleLabel.textAlignment = NSTextAlignmentRight;
        btnAdd.backgroundColor = [UIColor clearColor];
        [btnAdd addTarget:self action:@selector(btnAddTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollAdd addSubview:btnAdd];
        
        
        UIImageView *imageAdd = [[UIImageView alloc]init];
        imageAdd.frame = CGRectMake(0, 0, btnAdd.frame.size.width, kAddButtonHeight);
        imageAdd.image = [UIImage imageNamed:@"dummy"];
        imageAdd.userInteractionEnabled = YES;
            [btnAdd addSubview:imageAdd];
        
        UILabel *labelRestaurant = [[UILabel alloc]init];
        labelRestaurant.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH - 210, kAddButtonHeight - 30,200, 30);
        labelRestaurant.textColor = [UIColor whiteColor];
        labelRestaurant.backgroundColor = [UIColor clearColor];
        labelRestaurant.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
        labelRestaurant.font = [UIFont fontWithName:_roboto_light size:18];
        labelRestaurant.text = [arrayAddData objectAtIndex:i];
        [btnAdd addSubview:labelRestaurant];
        
        xPos+= DEVICE_WIDTH;

    }
    
    //scrollAdd.backgroundColor = [UIColor redColor];
    scrollAdd.contentSize = CGSizeMake(DEVICE_WIDTH*[arrayAddData count], kAddButtonHeight);
    
}


-(void)setCategoryView
{
    int xPos = 10;
    int yPos = 0;
    
    int kCategoryButtonWidth = (DEVICE_WIDTH-30)/2;
    int kCategoryButtonHeight = 120;
    
    
    for(int i=0; i<[arrayCategoryData count]; i++)
    {
        btnCategory = [UIButton buttonWithType:UIButtonTypeCustom];
        btnCategory.frame = CGRectMake(xPos, yPos, kCategoryButtonWidth, kCategoryButtonHeight);
        //[btnCategory setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        //[btnCategory setTitle:@"Forgot Password?" forState:UIControlStateNormal];
        btnCategory.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnCategory.titleLabel.textAlignment = NSTextAlignmentRight;
        btnCategory.backgroundColor = [UIColor clearColor];
        [btnCategory addTarget:self action:@selector(btnAddTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollCategory addSubview:btnCategory];
        
        //[btnCategory.layer setBorderColor: [kGrayTextColor CGColor]];
        //[btnCategory.layer setBorderWidth: 0.3f];
        //[btnCategory.layer setShadowOffset:CGSizeMake(0.4, 0.4)];
        //[btnCategory.layer setShadowRadius: 1.3];
        //[btnCategory.layer setShadowOpacity: 0.6];

        
        UIImageView *imageCategory = [[UIImageView alloc]init];
        imageCategory.frame = CGRectMake(0, 0, btnCategory.frame.size.width, kCategoryButtonHeight-20);
        imageCategory.image = [UIImage imageNamed:@"dummy"];
        [btnCategory addSubview:imageCategory];
        
        UILabel *labelCategory = [[UILabel alloc]init];
        labelCategory.frame = CGRectMake(0, kCategoryButtonHeight - 20, kCategoryButtonWidth, 20);
        labelCategory.textColor = kGrayTextColor;
        labelCategory.backgroundColor = [UIColor clearColor];
        labelCategory.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
        labelCategory.font = [UIFont fontWithName:_roboto_light size:14];
        labelCategory.text = [arrayCategoryData objectAtIndex:i];
        labelCategory.contentMode = UIViewContentModeScaleAspectFit;
        
        [btnCategory addSubview:labelCategory];
        
        xPos+= kCategoryButtonWidth+10;
        
        if((i+1)%2 == 0)
        {
            xPos = 10;
            yPos+= kCategoryButtonHeight + 7;
            
        }

        
    }
    
    if([arrayCategoryData count]%2 != 0)
        yPos+= kCategoryButtonHeight + 7;

    //scrollCategory.backgroundColor = [UIColor blueColor];
    scrollCategory.contentSize = CGSizeMake(DEVICE_WIDTH, yPos);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnLocationTapped:(id)sender
{
    SelectCityView *city = [[SelectCityView alloc]init];
    [self.navigationController pushViewController:city animated:YES];
    
}

-(void)btnAddTapped:(id)sender
{
    
}


-(IBAction)btnSeeAllTapped:(id)sender
{
    if(btnSeeAll.selected == NO)
    {
        btnSeeAll.selected = YES;
        
        pageControl.hidden = YES;
        
        [UIView animateWithDuration:kAnimationDelay delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            //CGRect frame = scrollAdd.frame;
            //frame.size.height= 0;
            //scrollAdd.frame= frame;
            
            CGRect frame = viewCategory.frame;
                frame.origin.y-= kAddButtonHeight - 45;
                frame.size.height+= kAddButtonHeight - 45;
            viewCategory.frame = frame;
            
            
        } completion:^(BOOL finished) {
            
            
            
        }];
        
    }
    else
    {
        btnSeeAll.selected = NO;

        pageControl.hidden = NO;

        [UIView animateWithDuration:kAnimationDelay delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect frame = viewCategory.frame;
            
            frame.origin.y+= kAddButtonHeight - 45;
            frame.size.height-= kAddButtonHeight-45;
            
            viewCategory.frame = frame;
            
        } completion:^(BOOL finished) {
            
            
            
        }];
    }
   
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

#pragma mark -- --- --- --- ---
#pragma mark --- ---  SCROLLVIEW DELEGATE --- ---


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(scrollAdd.frame);
    NSUInteger page = floor((scrollAdd.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
   
    pageControl.currentPage = page;
    
    //[pageControl updateCurrentPageDisplay] ;
    
    if(page == 0)
    {
        //[AppMemory setLanguage:LANGUAGE_VALUE_ENG];
        //LocalizationSetLanguage(@"en");
        
        //isEnglish = YES;
        //[self setUIAsPerLanguage];
        
    }
    else
    {
        //[AppMemory setLanguage:LANGUAGE_VALUE_ARE];
       // LocalizationSetLanguage(@"ar");
        //isEnglish = NO;
        //[self setUIAsPerLanguage];
    }
    
    
}


#pragma mark ---- ----  Delegate Call back Methods  ----  ----

-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:_message leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
    [alert show];
    
}


-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
    [alert show];
    
}


-(void)successWithCategoryDetails:(NSMutableArray *)_dataArray
{
#if DEBUG
    NSLog(@"-- Category Data :%@",_dataArray);
#endif
    
    [appDelegate stopSpinner];
    
}




@end
