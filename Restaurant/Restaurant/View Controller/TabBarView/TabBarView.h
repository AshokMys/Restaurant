//
//  TabBarView.h
//  Restaurant
//
//  Created by IMAC05 on 18/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarView : UIView
{
    BOOL isEnglish;
    
}

@property (nonatomic, retain) IBOutlet UILabel *lblData;

@property (nonatomic, retain) IBOutlet UIButton *btnTabFirst;
@property (nonatomic, retain) IBOutlet UIButton *btnTabSecond;
@property (nonatomic, retain) IBOutlet UIButton *btnTabThird;
@property (nonatomic, retain) IBOutlet UIButton *btnTabFourth;


@property (nonatomic, retain) IBOutlet UIImageView *imageTabFirst;
@property (nonatomic, retain) IBOutlet UIImageView *imageTabSecond;
@property (nonatomic, retain) IBOutlet UIImageView *imageTabThird;
@property (nonatomic, retain) IBOutlet UIImageView *imageTabFourth;


@property (nonatomic, retain) IBOutlet UILabel *labelTabFirst;
@property (nonatomic, retain) IBOutlet UILabel *labelTabSecond;
@property (nonatomic, retain) IBOutlet UILabel *labelTabThird;
@property (nonatomic, retain) IBOutlet UILabel *labelTabFourth;


-(void)setTabSelection:(int)_selectedIndex;


@property (nonatomic, copy) dispatch_block_t tabFirstSelected;
@property (nonatomic, copy) dispatch_block_t tabSecondSelected;
@property (nonatomic, copy) dispatch_block_t tabThirdSelected;
@property (nonatomic, copy) dispatch_block_t tabFourthSelected;

@end
