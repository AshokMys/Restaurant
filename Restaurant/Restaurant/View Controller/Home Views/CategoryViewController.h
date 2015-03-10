//
//  CategoryViewController.h
//  Restaurant
//
//  Created by IMAC05 on 24/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TabBarView.h"

@interface CategoryViewController : UIViewController
{
    AppDelegate *appDelegate;

    IBOutlet UIScrollView *scrollView;

    IBOutlet UILabel *labelTopHeader;
    IBOutlet UIButton *btnBack, *btnSearch;
    IBOutlet UITextField *textSearch;
    
    UIButton *btnCategory;
    
    NSMutableArray *arrayCategoryData;
    BOOL isEnglish;
    
}

@end
