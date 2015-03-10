//
//  MyFavouriteView.h
//  Restaurant
//
//  Created by IMAC05 on 23/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "AppDelegate.h"


@interface MyFavouriteView : UIViewController
{
    AppDelegate *appDelegate;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UILabel *labelTopHeader;
    IBOutlet UIButton *btnBack;
    
    NSMutableArray *arrayFavouritesData;
    
    
    BOOL isEnglish;
    
}


@end
