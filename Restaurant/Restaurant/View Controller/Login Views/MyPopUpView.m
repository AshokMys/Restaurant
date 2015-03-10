//
//  MyPopUpView.m
//  Restaurant
//
//  Created by IMAC05 on 02/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MyPopUpView.h"
#import "Constants.h"


@implementation MyPopUpView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
        bgView.backgroundColor  = [UIColor clearColor];
        //bgView.userInteractionEnabled = NO;
        [self addSubview:bgView];
        
        UIView *transparentView = [[UIView alloc]init];
        transparentView.frame = CGRectMake(0, 0, 0, 0);
        transparentView.backgroundColor  = [UIColor blackColor];
        transparentView.alpha = 0.5;
        [bgView addSubview:transparentView];
        
        
        UIView *popupView = [[UIView alloc]init];
        popupView.backgroundColor = [UIColor whiteColor];
        popupView.frame = CGRectMake(20, 100, DEVICE_WIDTH-40, 200);
            [bgView addSubview:popupView];
        
        labelTitle = [[UILabel alloc]init];
        labelTitle.frame = CGRectMake(0, 0,popupView.frame.size.width, 40);
        labelTitle.backgroundColor = [UIColor colorWithRed:138.0/255.0 green:211.0/255.0 blue:153.0/255.0 alpha:1];
        labelTitle.numberOfLines  = 0;
        labelTitle.font = [UIFont fontWithName:_roboto size:18];
        labelTitle.text = @"Forgot Password";
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.textColor = [UIColor whiteColor];
            [popupView addSubview:labelTitle];

        
        textEmailAdd = [[UITextField alloc]init];
        textEmailAdd.frame = CGRectMake(10, 60, popupView.frame.size.width-20, 35);
        textEmailAdd.font = [UIFont fontWithName:_roboto_light size:14];
        textEmailAdd.placeholder = LocalizedString(@"Enter your email address");
        textEmailAdd.delegate = self;
        textEmailAdd.textColor = kGrayTextColor;
        textEmailAdd.secureTextEntry = YES;
        textEmailAdd.backgroundColor = [UIColor clearColor];
            [popupView addSubview:textEmailAdd];

        
        UILabel *labelSeparator = [[UILabel alloc]init];
        labelSeparator.frame = CGRectMake(10, textEmailAdd.frame.origin.y+40, popupView.frame.size.width-20, 1);
        labelSeparator.backgroundColor = [UIColor colorWithRed:138.0/255.0 green:211.0/255.0 blue:153.0/255.0 alpha:1];
            [popupView addSubview:labelSeparator];

        
        popupView.alpha = 0;
        
        [UIView animateWithDuration:0.4f animations:^{
            
            popupView.alpha = 1;

            //bgView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
            //transparentView.frame = bgView.frame;


        } completion:^(BOOL finished) {
            
            

        }];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
