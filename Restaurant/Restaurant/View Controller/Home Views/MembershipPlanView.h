//
//  MembershipPlanView.h
//  Restaurant
//
//  Created by IMAC05 on 25/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface MembershipPlanView : UIViewController
{
    AppDelegate *appDelegate;
    
    IBOutlet UILabel *labelTopHeader;
    IBOutlet UIButton *btnBack;
    
    IBOutlet UITableView *tableMembership;
    
    NSMutableArray *arrayMembershipPlan;
    
}


@end
