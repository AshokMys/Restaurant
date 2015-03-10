//
//  MenuViewController.h
//  Restaurant
//
//  Created by IMAC05 on 18/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

#import "RESideMenu.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate>
{
    
    MFMailComposeViewController *mailComposer;
    
    AppDelegate *appDelegate;
    
    NSMutableArray *arrayTitles, *arrayImages;

    BOOL isEnglish;
    
}

@end
