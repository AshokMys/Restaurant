//
//  AddRestaurantView.h
//  Restaurant
//
//  Created by IMAC05 on 23/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "CustomTextView.h"

@interface AddRestaurantView : UIViewController
{
    
    AppDelegate *appDelegate;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UILabel *labelTopHeader;
    IBOutlet UIButton *btnMap, *btnBack, *btnCategory, *btnNext;

    IBOutlet UITextField *textRestName, *textSpecification, *textFBLink, *textTwitterLink;
    IBOutlet UILabel *labelMapPlaceholder, *labelCategory, *labelSocialMediaPlaceholder;
    IBOutlet UIImageView *imageMapNext;
    
    IBOutlet CustomTextView *textAddress;
    
    BOOL isEnglish;
    
}


@property (nonatomic, readwrite) BOOL isEditable;

@end
