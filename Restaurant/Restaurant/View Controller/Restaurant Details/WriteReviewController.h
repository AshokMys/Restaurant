//
//  WriteReviewController.h
//  Restaurant
//
//  Created by IMAC05 on 09/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomTextView.h"


@interface WriteReviewController : UIViewController <UITextViewDelegate>
{
    IBOutlet CustomTextView *textReview;
    
    IBOutlet UILabel *labelRating;
    
    IBOutlet UIButton *btnPublish, *btnFBSelected, *btnTwitterSelected;
    
    
}


@end
