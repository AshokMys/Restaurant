//
//  AppDelegate.h
//  Restaurant
//
//  Created by IMAC05 on 13/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

#import "LoginUserData.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MYSFacebookHelper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, RESideMenuDelegate>
{
    NSString *currentLanguage;

    UIView *alertView;
    UIActivityIndicatorView *indicator;
    MYSFacebookHelper *FBHelperObj;
    
}

@property (nonatomic, retain) LoginUserData *userDetails;

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, retain) UINavigationController *nvc;

-(void)setNavigationController;

- (CGFloat)heightForString:(NSString *)string withFont:(UIFont *)font labelWidht:(int)_width;

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize SourceImage:(UIImage *)sourceImage;


-(void)saveToUserDefaultsForKey:(NSString*)key saveValue :(NSString*)value;
-(NSString*)retrieveFromUserDefaults:(NSString*)key;


-(void)startSpinner;
-(void)stopSpinner;


-(void)saveCustomObject:(LoginUserData *)obj;
-(LoginUserData *)loadCustomObjectWithKey:(NSString*)key;  

-(NSString *)checkForNullValue:(NSString *)_parameter;  // Check Null Parameter


@end

