//
//  SearchViewController.h
//  Restaurant
//
//  Created by IMAC05 on 20/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SearchViewController : UIViewController
{
    AppDelegate *appDelegate;
    
    IBOutlet UILabel *labelTopHeader;
    IBOutlet UIButton *btnBack, *btnSearch;
    IBOutlet UITextField *textArea, *textFoodType, *textKeyword, *textCategory;
    
    BOOL isEnglish;
    
}

@end
