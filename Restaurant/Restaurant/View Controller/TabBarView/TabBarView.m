//
//  TabBarView.m
//  Restaurant
//
//  Created by IMAC05 on 18/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "TabBarView.h"
#import "Constants.h"
#import "LocalizeHelper.h"


#define kTabBarHeight 50

@implementation TabBarView

@synthesize btnTabFirst;
@synthesize btnTabSecond;
@synthesize btnTabThird;
@synthesize btnTabFourth;


@synthesize imageTabFirst;
@synthesize imageTabSecond;
@synthesize imageTabThird;
@synthesize imageTabFourth;


@synthesize labelTabFirst;
@synthesize labelTabSecond;
@synthesize labelTabThird;
@synthesize labelTabFourth;


@synthesize lblData;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
            isEnglish = YES;
        else
            isEnglish = NO;

        
        float _width = floor(DEVICE_WIDTH/4)+1;
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, kTabBarHeight)];
        bgView.backgroundColor = [UIColor clearColor];
        //bgView.alpha = 0.5;
        [self addSubview:bgView];
        
        
        btnTabFirst = [UIButton buttonWithType:UIButtonTypeCustom];
        btnTabFirst.tag = 0;
        btnTabFirst.frame = CGRectMake(isEnglish ? 0 : _width*3, 0, _width, kTabBarHeight);
        [btnTabFirst setBackgroundImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        btnTabFirst.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnTabFirst.titleLabel.textAlignment = NSTextAlignmentRight;
        btnTabFirst.backgroundColor = [UIColor clearColor];
        [btnTabFirst addTarget:self action:@selector(btnTabFirstTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnTabFirst];
        
        imageTabFirst = [[UIImageView alloc] init];
        imageTabFirst.frame = CGRectMake(_width/2-11, 6, 22, 22);
        imageTabFirst.image = [UIImage imageNamed:@"search_icon"];
        imageTabFirst.contentMode = UIViewContentModeScaleAspectFill;
        [btnTabFirst addSubview:imageTabFirst];
        
        labelTabFirst = [[UILabel alloc]init];
        labelTabFirst.frame = CGRectMake(2, btnTabFirst.frame.size.height-20, btnTabFirst.frame.size.width-4, 17);
        labelTabFirst.textColor = [UIColor darkGrayColor];
        labelTabFirst.text = LocalizedString(@"tab_search");
        labelTabFirst.textAlignment = NSTextAlignmentCenter;
        labelTabFirst.backgroundColor = [UIColor clearColor];
        labelTabFirst.font = [UIFont fontWithName:_roboto_light size:14];
        [btnTabFirst addSubview:labelTabFirst];
//-------------------------
        
        
        btnTabSecond = [UIButton buttonWithType:UIButtonTypeCustom];
        btnTabSecond.tag = 1;
        btnTabSecond.frame = CGRectMake(isEnglish ? _width : _width*2, 0, _width, kTabBarHeight);
        [btnTabSecond setBackgroundImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        btnTabSecond.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnTabSecond.titleLabel.textAlignment = NSTextAlignmentRight;
        btnTabSecond.backgroundColor = [UIColor clearColor];
        [btnTabSecond addTarget:self action:@selector(btnTabSecondTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnTabSecond];

        imageTabSecond = [[UIImageView alloc] init];
        imageTabSecond.frame = CGRectMake(_width/2-11, 6, 22, 22);
        imageTabSecond.image = [UIImage imageNamed:@"nearby_icon"];
        imageTabSecond.contentMode = UIViewContentModeScaleAspectFill;
        [btnTabSecond addSubview:imageTabSecond];
        
        labelTabSecond = [[UILabel alloc]init];
        labelTabSecond.frame = CGRectMake(2, btnTabSecond.frame.size.height-20, btnTabSecond.frame.size.width-4, 17);
        labelTabSecond.textColor = [UIColor darkGrayColor];
        labelTabSecond.text = LocalizedString(@"tab_nearby");
        labelTabSecond.textAlignment = NSTextAlignmentCenter;
        labelTabSecond.backgroundColor = [UIColor clearColor];
        labelTabSecond.font = [UIFont fontWithName:_roboto_light size:14];
        [btnTabSecond addSubview:labelTabSecond];
       
//-------------------------

        btnTabThird = [UIButton buttonWithType:UIButtonTypeCustom];
        btnTabThird.tag = 2;
        btnTabThird.frame = CGRectMake(isEnglish ? _width*2 : _width, 0, _width, kTabBarHeight);
        [btnTabThird setBackgroundImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        btnTabThird.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnTabThird.titleLabel.textAlignment = NSTextAlignmentRight;
        btnTabThird.backgroundColor = [UIColor clearColor];
        [btnTabThird addTarget:self action:@selector(btnTabThirdTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnTabThird];

        imageTabThird = [[UIImageView alloc] init];
        imageTabThird.frame = CGRectMake(_width/2-11, 6, 22, 22);
        imageTabThird.image = [UIImage imageNamed:@"category_icon"];
        imageTabThird.contentMode = UIViewContentModeCenter;
        [btnTabThird addSubview:imageTabThird];
        
        labelTabThird = [[UILabel alloc]init];
        labelTabThird.frame = CGRectMake(2, btnTabFirst.frame.size.height-20, btnTabFirst.frame.size.width-4, 17);
        labelTabThird.textColor = [UIColor darkGrayColor];
        labelTabThird.text = LocalizedString(@"tab_category");
        labelTabThird.textAlignment = NSTextAlignmentCenter;
        labelTabThird.backgroundColor = [UIColor clearColor];
        labelTabThird.font = [UIFont fontWithName:_roboto_light size:14];
        [btnTabThird addSubview:labelTabThird];
        
//-------------------------

        btnTabFourth = [UIButton buttonWithType:UIButtonTypeCustom];
        btnTabFourth.tag = 3;
        btnTabFourth.frame = CGRectMake(isEnglish ? _width*3 : 0, 0, _width, kTabBarHeight);
        [btnTabFourth setBackgroundImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        //btnTabFourth.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        btnTabFourth.titleLabel.textAlignment = NSTextAlignmentRight;
        btnTabFourth.backgroundColor = [UIColor clearColor];
        [btnTabFourth addTarget:self action:@selector(btnTabFourthTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnTabFourth];

        imageTabFourth = [[UIImageView alloc] init];
        imageTabFourth.frame = CGRectMake(_width/2-11, 6, 22, 22);
        imageTabFourth.image = [UIImage imageNamed:@"me_icon"];
        imageTabFourth.backgroundColor = [UIColor clearColor];
        imageTabFourth.contentMode = UIViewContentModeScaleAspectFill;
        [btnTabFourth addSubview:imageTabFourth];
        
        labelTabFourth = [[UILabel alloc]init];
        labelTabFourth.frame = CGRectMake(2, btnTabFirst.frame.size.height-20, btnTabFirst.frame.size.width-4, 17);
        labelTabFourth.textColor = [UIColor darkGrayColor];
        labelTabFourth.text = LocalizedString(@"tab_me");
        labelTabFourth.textAlignment = NSTextAlignmentCenter;
        labelTabFourth.backgroundColor = [UIColor clearColor];
        labelTabFourth.font = [UIFont fontWithName:_roboto_light size:14];
        [btnTabFourth addSubview:labelTabFourth];
        
//-------------------------

        
    }
    return self;
}



-(void)setTabSelection:(int)_selectedIndex
{
   
    if(_selectedIndex == 0)
    {

        [btnTabFirst setImage:[UIImage imageNamed:@"tab_selected"] forState:UIControlStateNormal];
        
        //[btnTabSecond setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        //[btnTabThird setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        //[btnTabFourth setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        
        labelTabFirst.textColor = [UIColor whiteColor];
        imageTabFirst.image = [UIImage imageNamed:@"search_icon_selected"];
        

    }
    else if(_selectedIndex == 1)
    {
        //[btnTabFirst setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        [btnTabSecond setImage:[UIImage imageNamed:@"tab_selected"] forState:UIControlStateNormal];
        //[btnTabThird setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        //[btnTabFourth setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];

        labelTabSecond.textColor = [UIColor whiteColor];
        imageTabSecond.image = [UIImage imageNamed:@"nearby_icon_selected"];
       
        
    }
    else if(_selectedIndex == 2)
    {
        //[btnTabFirst setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        //[btnTabSecond setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        [btnTabThird setImage:[UIImage imageNamed:@"tab_selected"] forState:UIControlStateNormal];
        //[btnTabFourth setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        
        labelTabThird.textColor = [UIColor whiteColor];
        imageTabThird.image = [UIImage imageNamed:@"category_icon_selected"];

        
    }else if(_selectedIndex == 3)
    {
        //[btnTabFirst setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        //[btnTabSecond setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        //[btnTabThird setImage:[UIImage imageNamed:@"tab"] forState:UIControlStateNormal];
        [btnTabFourth setImage:[UIImage imageNamed:@"tab_selected"] forState:UIControlStateNormal];
        
        labelTabFourth.textColor = [UIColor whiteColor];
        imageTabFourth.image = [UIImage imageNamed:@"me_icon_selected"];

        
    }
    
}


-(void)btnTabFirstTapped:(id)sender
{
    [self setTabSelection:(int)[sender tag]];
    
    if(self.tabFirstSelected)
        self.tabFirstSelected();
    
}


-(void)btnTabSecondTapped:(id)sender
{
    [self setTabSelection:(int)[sender tag]];

    if(self.tabSecondSelected)
        self.tabSecondSelected();
    
}


-(void)btnTabThirdTapped:(id)sender
{
    [self setTabSelection:(int)[sender tag]];

    if(self.tabThirdSelected)
        self.tabThirdSelected();
    
}


-(void)btnTabFourthTapped:(id)sender
{
    [self setTabSelection:(int)[sender tag]];

    if(self.tabFourthSelected)
        self.tabFourthSelected();
    
}


@end
