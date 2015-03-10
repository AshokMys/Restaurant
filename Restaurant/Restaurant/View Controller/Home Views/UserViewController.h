//
//  UserViewController.h
//  Restaurant
//
//  Created by IMAC05 on 20/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController
{

    IBOutlet  UIScrollView *scrollView;
    
    IBOutlet UILabel *labelTopHeader;
    IBOutlet UIImageView *imageUserProfile;
    IBOutlet UILabel *labelUserName;
    IBOutlet UIButton *btnBack;
    IBOutlet UITableView *tableUserOptions;
    
    NSMutableArray *arrayOptions;
    
    BOOL isEnglish;
    
}

@end
