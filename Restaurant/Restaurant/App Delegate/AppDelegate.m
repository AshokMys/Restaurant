//
//  AppDelegate.m
//  Restaurant
//
//  Created by IMAC05 on 13/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeViewController.h"

#import "LocalizeHelper.h"
#import "AppMemory.h"
#import "Constants.h"


#import "MenuViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize nvc;
@synthesize userDetails;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"--- Nice ----");
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //Facebook
    FBHelperObj =[[MYSFacebookHelper alloc]init];
    //[FBHelperObj GetAppActive];
    
    userDetails = [self loadCustomObjectWithKey:@"myLoginData"]; // USER OBJECT
    currentLanguage = [AppMemory getDataForKey:LANGUAGE_KEY];

    if (!currentLanguage)
        [AppMemory setLanguage:LANGUAGE_VALUE_ARE];  //TODO: By default Arebic language
    else
        [AppMemory setLanguage:currentLanguage];

    LoginViewController *login = [[LoginViewController alloc]init];
    nvc = [[UINavigationController alloc] initWithRootViewController:login];
    nvc.navigationBarHidden = YES;
    
    [self.window setRootViewController:nvc];
    [self.window makeKeyAndVisible];

    return YES;
    
}


-(void)setNavigationController
{
    //----------
    
    HomeViewController *home = [[HomeViewController alloc]init];
    
    nvc = [[UINavigationController alloc] initWithRootViewController:home];
    MenuViewController *leftMenuViewController = [[MenuViewController alloc] init];
    //DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];
    
    nvc.navigationBarHidden = YES;

    RESideMenu *sideMenuViewController;
    
    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
    {
       sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:nvc
                                     leftMenuViewController:leftMenuViewController
                                    rightMenuViewController:nil];
    }
    else
    {
       sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:nvc
                                     leftMenuViewController:nil
                                    rightMenuViewController:leftMenuViewController];
    }

    
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = sideMenuViewController;
    
    
    //------------

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
     [FBSession.activeSession close];
}

#pragma mark Facebook
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL urlWasHandled = [FBAppCall handleOpenURL:url
                                sourceApplication:sourceApplication
                                  fallbackHandler:^(FBAppCall *call) {
                                      NSLog(@"Unhandled deep link: %@", url);
                                  }];
    
    return urlWasHandled;
}


#pragma mark --- --- ---- ------
#pragma mark --- --- USER DEFAULT ---- ------

-(void)saveToUserDefaultsForKey:(NSString*)key saveValue :(NSString*)value
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

-(NSString*)retrieveFromUserDefaults:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value = nil;
    
    if (standardUserDefaults)
        value = [standardUserDefaults objectForKey:key];
    
    return value;
}


#pragma mark --- --- ---- ------
#pragma mark --- --- HEIGHT FOR STRING ---- ------

- (CGFloat)heightForString:(NSString *)string withFont:(UIFont *)font labelWidht:(int)_width
{
    CGSize maximumLabelSize = CGSizeMake(_width,9999);
    CGSize expectedLabelSize = [string sizeWithFont:font
                                  constrainedToSize:maximumLabelSize
                                      lineBreakMode:NSLineBreakByWordWrapping];
    
    //NSLog(@"-- Height : %f",expectedLabelSize.height);
    
    return expectedLabelSize.height;
    
}


- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize SourceImage:(UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
        {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}


#pragma mark --- --- ---- ------
#pragma mark --- ---  SPINNER METHOD  ---- ------

-(void)startSpinner
{
#if DEBUG
    NSLog(@"***** App Delegate Start Spinner *****");
#endif
    
    if([alertView superview])
        [alertView removeFromSuperview];
    
    alertView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width,  self.window.frame.size.height)];
    alertView.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.window.frame.size.width,  self.window.frame.size.height)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [alertView addSubview:bgView];
    
    if(indicator==nil)
        indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [indicator startAnimating];
    indicator.hidesWhenStopped=YES;
    [indicator setCenter:CGPointMake(self.window.frame.size.width/2,self.window.frame.size.height/2)];
    [alertView addSubview:indicator];
    
    [self.window addSubview:alertView];
    
}

-(void)stopSpinner
{
#if DEBUG
    NSLog(@"***** App Delegate Stop Spinner *****");
#endif

    if(alertView!=nil)
    {
        [alertView removeFromSuperview];
        alertView = nil;
        
    }
    
}

#pragma mark --- --- ---- ------

-(void)saveCustomObject:(LoginUserData *)obj
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    
    [defaults setObject:myEncodedObject forKey:@"myLoginData"];
    
    userDetails = [self loadCustomObjectWithKey:@"myLoginData"];
    
}

-(LoginUserData *)loadCustomObjectWithKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey: key];
    
    LoginUserData* obj = (LoginUserData *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return obj;
}

#pragma mark --- --- ---- ------


-(NSString *)checkForNullValue:(NSString *)_parameter
{
    NSString *strParameter;
    
    if (_parameter == nil || [_parameter isKindOfClass:[NSNull class]])
        strParameter = @"";
    else
        strParameter = _parameter;
    
    return strParameter;
    
}

@end
