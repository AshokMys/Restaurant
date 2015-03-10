//
//  NearbyViewController.h
//  Restaurant
//
//  Created by IMAC05 on 19/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"

#import "AppDelegate.h"


@interface NearbyViewController : UIViewController
{
    AppDelegate *appDelegate;
    
    IBOutlet UILabel *labelTopHeader;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *btnSearch, *btnBack;
    IBOutlet UITextField *textSearch;

    NSMutableArray *arrayCategoryData;
    
    BOOL isEnglish;
    
}

@property (nonatomic, readwrite) BOOL isManageRestaurant;

@end
