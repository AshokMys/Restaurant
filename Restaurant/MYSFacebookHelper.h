//
//  MYSFacebookHelper.h
//  FacebookSharing
//
//  Created by IMAC04 on 27/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
@interface MYSFacebookHelper : UIView

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

//-(void) postWithText: (NSString*) message ImageName: (NSString*) image URL: (NSString*) url Caption: (NSString*) caption Name: (NSString*) name andDescription: (NSString*) description;








@end
