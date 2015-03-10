//
//  MYSFacebookHelper.h
//  FacebookSharing
//
//  Created by IMAC04 on 27/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

#import "LoginUserData.h"


@protocol FBHelperDelegate <NSObject>

@optional
-(void)successWithFBUserDetails:(LoginUserData *)_userData;


@end


@interface MYSFacebookHelper : UIView
{
    LoginUserData *loginUserObject;
    
}


@property (nonatomic, assign) id<FBHelperDelegate> fbHelperDelegate;



-(void)GetAppActive;
-(void)FBLogIn;
-(void)FBLogOut;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)userLoggedIn;
- (void)userLoggedOut;
- (void)showMessage:(NSString *)text withTitle:(NSString *)title;

//Share
-(void)FBShareMsg;
- (void)FBSharePhoto:(UIImage *)image;
- (void)FBShareVideo:(NSString *)filePath;

@end
