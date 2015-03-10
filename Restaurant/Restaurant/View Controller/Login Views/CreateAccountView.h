//
//  CreateAccountView.h
//  Restaurant
//
//  Created by IMAC05 on 13/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoginManager.h"

@interface CreateAccountView : UIViewController <LoginManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>
{
    AppDelegate *appDelegate;
    LoginManager *loginManager;

    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UITextField *textUserName, *textEmailAdd, *textPassword, *textConfirmPass, *textCountry, *textMobile, *textCurrentField;
    IBOutlet UIImageView *imageUserName, *imageEmailAdd, *imagePassword, *imageConfirmPass, *imageCountry, *imageMobile;
    
    IBOutlet UIView *sepraterUserName, *sepraterEmailAdd, *sepraterPassword, *sepraterConfirmPass, *sepraterCountry, *sepraterMobile;
    IBOutlet UIView *topView;
    
    IBOutlet UIButton *btnCreateAccount, *btnLogin, *btnAcceptTerms;
    
    IBOutlet UILabel *labelWelcome, *labelAppName, *labelMessage, *labelTerms;
    
    BOOL isEnglish, isKeyBoardVisible;
    
    UIPickerView *pickerView;
    UIView *viewCountry;
    int  selectedIndex;
    int countryId;
    
    NSMutableArray *arrayCountryNames;
    
}

@end
