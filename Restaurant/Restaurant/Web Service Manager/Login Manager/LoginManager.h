//
//  LoginManager.h
//  Restaurant
//
//  Created by IMAC05 on 03/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "MYSGenericProxy.h"

#import "LoginUserData.h"
#import "CountryData.h"


@protocol LoginManagerDelegate <NSObject>

-(void)problemForGettingResponse:(NSString *)_message;
-(void)requestFailWithError:(NSString *)_errorMessage;

@optional
-(void)successWithLoginDetails:(LoginUserData *)_loginUserData;
-(void)successfullyCreateNewAccount;
-(void)successWithCountryDetails:(NSMutableArray *)_dataArray;
-(void)successfullyResetPassword:(NSString *)_message;
-(void)successWithSocialMedia:(NSString *)_message;    //Create account with FB data



@end


@interface LoginManager : NSObject <MYSWebRequestProxyDelegate>
{
    AppDelegate *appDelegate;
    
    MYSGenericProxy *proxy;
    
}


@property (nonatomic, assign) id<LoginManagerDelegate> loginManagerDelegate;


+ (id)allocWithZone:(NSZone*)zone;
+ (LoginManager *)sharedInstance;


-(void)getLogin:(NSMutableDictionary *)_dataDict;  // Login existing user...
-(void)createNewCustomer:(NSMutableDictionary *)_dataDict;   // Create New customer...

-(void)getCountryDetails:(NSMutableDictionary *)_dataDict;  // Get Country Details...


-(void)getNewPassword:(NSMutableDictionary *)_dataDict;

-(void)createOrCheckNewUserWithFBDetails:(NSMutableDictionary *)_dataDict;


@end
