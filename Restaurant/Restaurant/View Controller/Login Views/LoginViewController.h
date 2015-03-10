//
//  LoginViewController.h
//  Restaurant
//
//  Created by IMAC05 on 13/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "LoginManager.h"
#import "MyScrollView.h"

#import "MYSFacebookHelper.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, LoginManagerDelegate, FBHelperDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;
    MYSFacebookHelper *FBHelperObj;
    
    IBOutlet MyScrollView *scrollLanguage;
    
    UILabel *labelWelcome, *LabelAppName, *labelDescription;
    UIPageControl *pageControl;
    UIImageView *imageLogo, *imageEmail, *imagePassword;
    
    UITextField *textUserName, *textPassword, *textCurrentField;
    
    UIView *seperaterFirst, *seperaterSecond, *seperaterThird;
    
    UIButton *btnLogin, *btnForgotPass, *btnFacebook, *btnSignUp, *btnSkip;
    
    UILabel *labelForgotPass;
    UILabel *labelFBText, *labelSkip;

    BOOL isEnglish, tempLanguage, isKeyBoardVisible;
    
    NSString *strUserName, *strPassword;
    
    
}

@end
