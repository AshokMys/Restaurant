//
//  HomeViewController.h
//  Restaurant
//
//  Created by IMAC05 on 17/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"
#import "RestaurantManager.h"
#import "AppDelegate.h"

@interface HomeViewController : UIViewController <RestaurantManagerDelegate>
{
    AppDelegate *appDelegate;
    RestaurantManager *restaurantManager;
    
    
    IBOutlet UIScrollView *scrollAdd, *scrollCategory;
    IBOutlet UIView *viewCategory;
    
    IBOutlet UILabel *labelFeatured,  *labelTopHeader, *labelLocation;
    IBOutlet UIButton *btnSeeAll, *btnBack, *btnSearch, *btnMenu, *btnLocation;
    
    IBOutlet UIPageControl *pageControl;
    
    IBOutlet UITextField *textSearch;
    IBOutlet UIImageView *imageSearch;
    
    NSMutableArray *arrayCategoryData;
    NSMutableArray *arrayAddData;
    
    UIButton *btnAdd, *btnCategory;
    
    BOOL isEnglish;
    
    
    int xPosCategory;
    
}

@end
