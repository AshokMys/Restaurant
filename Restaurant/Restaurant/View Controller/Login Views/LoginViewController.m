//
//  LoginViewController.m
//  Restaurant
//
//  Created by IMAC05 on 13/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import "CreateAccountView.h"
#import "LocalizeHelper.h"
#import "Constants.h"

#import "HomeViewController.h"
#import "CustomAlertView.h"
#import "MyPopUpView.h"


#define kAnimationDuration 0.3


#define kTextFieldColor [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1]


@interface LoginViewController () //<FBHelperDelegate>

@end

@implementation LoginViewController


- (UIImage *)rotateImage:(UIImage *)image onDegrees:(float)degrees
{
    CGFloat rads = M_PI * degrees ;
    float newSide = MAX([image size].width, [image size].height);
    CGSize size =  CGSizeMake(newSide, newSide);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, newSide/2, newSide/2);
    CGContextRotateCTM(ctx, rads);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(-[image size].width/2,-[image size].height/2,size.width, size.height),image.CGImage);
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
    {
        isEnglish = YES;
        tempLanguage = YES;
    }
    else
    {
        isEnglish = NO;
        tempLanguage = NO;
    }


       
    [self setLoginView];

    if(tempLanguage)  // SET ACTUAL SELECTED LANGUAGE
        [self setEnglishLanguage];
    else
        [self setArebicLanguage];
    
    scrollLanguage.contentSize = CGSizeMake(DEVICE_WIDTH*2, 568);
    //scrollView.backgroundColor = [UIColor redColor];
    
    [self setEnglishLanguage];//TODO: FORCEFULLY SET FOR TESTING
    
}

-(void)setEnglishLanguage
{
    [AppMemory setLanguage:LANGUAGE_VALUE_ENG];
    LocalizationSetLanguage(@"en");
    isEnglish = YES;
    
}


-(void)setArebicLanguage
{
    [AppMemory setLanguage:LANGUAGE_VALUE_ARE];
    LocalizationSetLanguage(@"ar");
    isEnglish = NO;
    
}

-(void)setLoginView
{
    int xPos = 0;
    int yPos = 50;

    
    for (int i=0; i<2 ; i++)
    {
        labelWelcome = [[UILabel alloc]init];
        labelWelcome.frame = CGRectMake(xPos + 20, yPos, DEVICE_WIDTH-40, 25);
        labelWelcome.textColor = [UIColor lightGrayColor];
        labelWelcome.backgroundColor = [UIColor clearColor];
        labelWelcome.textAlignment = NSTextAlignmentCenter;
        labelWelcome.font = [UIFont fontWithName:_roboto_light size:16];
            [scrollLanguage addSubview:labelWelcome];
        
        yPos+= 25;
        
        LabelAppName = [[UILabel alloc]init];
        LabelAppName.frame = CGRectMake(xPos + 20, yPos, DEVICE_WIDTH-40, 25);
        LabelAppName.textColor = [UIColor lightGrayColor];
        LabelAppName.backgroundColor = [UIColor clearColor];
        LabelAppName.textAlignment = NSTextAlignmentCenter;
        LabelAppName.font = [UIFont fontWithName:_roboto_light size:16];
            [scrollLanguage addSubview:LabelAppName];
        
        yPos+= 25;

        imageLogo = [[UIImageView alloc]init];
        imageLogo.frame = CGRectMake(xPos+ (DEVICE_WIDTH-100)/2 , yPos, 100, 100);
        imageLogo.contentMode = UIViewContentModeScaleAspectFit;
            [scrollLanguage addSubview:imageLogo];
        
        yPos+= 100;

        labelDescription = [[UILabel alloc]init];
        labelDescription.frame = CGRectMake(xPos + 20, yPos, DEVICE_WIDTH-40, 25);
        labelDescription.textColor = [UIColor lightGrayColor];
        labelDescription.backgroundColor = [UIColor clearColor];
        labelDescription.textAlignment = NSTextAlignmentCenter;
        labelDescription.font = [UIFont fontWithName:_roboto_light size:16];
            [scrollLanguage addSubview:labelDescription];
        
        yPos+= 30;
        
        textUserName = [[UITextField alloc]init];
        textUserName.tag = 0;
        textUserName.frame = CGRectMake(xPos+20, yPos, DEVICE_WIDTH-40, 30);
        textUserName.font = [UIFont fontWithName:_roboto_light size:14];
        textUserName.delegate = self;
        textUserName.keyboardType = UIKeyboardTypeEmailAddress;
        textUserName.textColor = kTextFieldColor;
        textUserName.backgroundColor = [UIColor clearColor];
            [scrollLanguage addSubview:textUserName];
        
        
        yPos+= 35;

        //---- User Name ----
        imageEmail = [[UIImageView alloc] init];
        imageEmail.image = [UIImage imageNamed:@"mail-icon"];
        imageEmail.contentMode = UIViewContentModeScaleAspectFit;
        [textUserName addSubview:imageEmail];

        seperaterFirst = [[UIView alloc]init];
        seperaterFirst.frame = CGRectMake(xPos+20, yPos, DEVICE_WIDTH-40, 1);
        seperaterFirst.backgroundColor = kTextFieldColor;
        [scrollLanguage addSubview:seperaterFirst];
        
        yPos+= 5;
        
        textPassword = [[UITextField alloc]init];
        textPassword.tag = 1;
        textPassword.frame = CGRectMake(xPos+20, yPos, DEVICE_WIDTH-40, 30);
        textPassword.font = [UIFont fontWithName:_roboto_light size:14];
        textPassword.delegate = self;
        textPassword.textColor = kTextFieldColor;
        textPassword.secureTextEntry = YES;
        textPassword.backgroundColor = [UIColor clearColor];
            [scrollLanguage addSubview:textPassword];
        
        
        imagePassword = [[UIImageView alloc] init];
        imagePassword.image = [UIImage imageNamed:@"password-icon"];
        imagePassword.contentMode = UIViewContentModeScaleAspectFit;
        [textPassword addSubview:imagePassword];

        yPos+= 35;

        seperaterSecond = [[UIView alloc]init];
        seperaterSecond.frame = CGRectMake(xPos+20, yPos, DEVICE_WIDTH-40, 1);
        seperaterSecond.backgroundColor = kTextFieldColor;
        [scrollLanguage addSubview:seperaterSecond];

        yPos+= 15;
        
        btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLogin.frame = CGRectMake(xPos+20, yPos, DEVICE_WIDTH-40, 40);
        [btnLogin setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        [btnLogin setTitle:@"LOGIN" forState:UIControlStateNormal];
        btnLogin.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnLogin.titleLabel.textAlignment = NSTextAlignmentRight;
        [btnLogin addTarget:self action:@selector(btnLoginTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollLanguage addSubview:btnLogin];
        
        yPos+= 45;

        btnForgotPass = [UIButton buttonWithType:UIButtonTypeCustom];
        btnForgotPass.frame = CGRectMake(xPos+20, yPos, (DEVICE_WIDTH -40), 30);
        //[btnForgotPass setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        //[btnForgotPass setTitle:@"Forgot Password?" forState:UIControlStateNormal];
        btnForgotPass.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnForgotPass.titleLabel.textAlignment = NSTextAlignmentRight;
        btnForgotPass.backgroundColor = [UIColor clearColor];
        [btnForgotPass addTarget:self action:@selector(btnForgotPassTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollLanguage addSubview:btnForgotPass];
        
//--------------
        labelForgotPass = [[UILabel alloc]init];
        labelForgotPass.frame = CGRectMake(0, 0, btnForgotPass.frame.size.width, btnForgotPass.frame.size.height);
        labelForgotPass.textColor = [UIColor whiteColor];
        labelForgotPass.backgroundColor = [UIColor clearColor];
        labelForgotPass.font = [UIFont fontWithName:_roboto_light size:16];
        [btnForgotPass addSubview:labelForgotPass];

//--------------------
        
        yPos+= 35;
        
        btnFacebook = [UIButton buttonWithType:UIButtonTypeCustom];
        btnFacebook.frame = CGRectMake(xPos+20, yPos, DEVICE_WIDTH-40, 40);
        //[btnFacebook setTitle:@"FB" forState:UIControlStateNormal];
        btnFacebook.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnFacebook.titleLabel.textAlignment = NSTextAlignmentRight;
        [btnFacebook addTarget:self action:@selector(btnFacebookTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollLanguage addSubview:btnFacebook];

        labelFBText = [[UILabel alloc]init];
        labelFBText.frame = CGRectMake(0, 0, btnFacebook.frame.size.width, btnFacebook.frame.size.height);;
        labelFBText.textAlignment = NSTextAlignmentCenter;
        labelFBText.font = [UIFont fontWithName:_roboto_light size:16];
        labelFBText.textColor = [UIColor whiteColor];
        [btnFacebook addSubview:labelFBText];
        
        
        yPos+= 50;
        
        seperaterThird = [[UIView alloc]init];
        seperaterThird.frame = CGRectMake(xPos+20, yPos, DEVICE_WIDTH-40, 1);
        seperaterThird.backgroundColor = kTextFieldColor;
        [scrollLanguage addSubview:seperaterThird];

        yPos+= 20;

        pageControl = [[UIPageControl alloc]init];
        pageControl.frame = CGRectMake(xPos ,  yPos, DEVICE_WIDTH, 10);
        pageControl.numberOfPages = 2;
        pageControl.currentPage = 0;
        pageControl.userInteractionEnabled = NO;
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:132.0/255.0 green:210.0/255.0 blue:143.0/255.0 alpha:1];
        [pageControl setDefersCurrentPageDisplay: YES] ;
        [scrollLanguage addSubview:pageControl];

        yPos+= 10;

        /*
        pageControl = [[SMPageControl alloc]init];
        pageControl.frame = CGRectMake(0 ,  300, DEVICE_WIDTH, 10);
        pageControl.numberOfPages = 2;
        pageControl.currentPage = 0;
        pageControl.userInteractionEnabled = NO;
        pageControl.backgroundColor = [UIColor clearColor];
        //pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        //pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        [pageControl setDefersCurrentPageDisplay: YES] ;
        [pageControl setPageIndicatorImage:[UIImage imageNamed:@"inactive_login"]];
        [pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"active_login"]];
        [loginView addSubview:pageControl];
         */
        
        btnSignUp = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSignUp.frame = CGRectMake(xPos+20, yPos, DEVICE_WIDTH-40, 40);
        //[btnSignUp setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        btnSignUp.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnSignUp.titleLabel.textAlignment = NSTextAlignmentRight;
        [btnSignUp addTarget:self action:@selector(btnSignUpTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollLanguage addSubview:btnSignUp];

        yPos+= 45;
//-------------
        btnSkip = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSkip.frame = CGRectMake(xPos+20, yPos, DEVICE_WIDTH-40, 30);
        //[btnSkip setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        btnSkip.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnSkip.titleLabel.textAlignment = NSTextAlignmentRight;
        [btnSkip addTarget:self action:@selector(btnSkipTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollLanguage addSubview:btnSkip];

        labelSkip = [[UILabel alloc]init];
        labelSkip.frame = CGRectMake(0, 0, btnSkip.frame.size.width, btnSkip.frame.size.height);
        labelSkip.textColor = [UIColor whiteColor];
        labelSkip.backgroundColor = [UIColor clearColor];
        labelSkip.font = [UIFont fontWithName:_roboto_light size:16];
        labelSkip.textAlignment = NSTextAlignmentCenter;
        [btnSkip addSubview:labelSkip];
//----------
        
        xPos+=DEVICE_WIDTH;
        yPos = 50;
        
        
        NSString *strForgotPass;
        
        if(i == 0)
        {
            [self setEnglishLanguage];
            
            imageLogo.image = [UIImage imageNamed:@"login_logo"];
            [btnFacebook setBackgroundImage:[UIImage imageNamed:@"fb_icon"] forState:UIControlStateNormal];

            imageEmail.frame = CGRectMake(0, 2, 26, 26);
            imagePassword.frame = CGRectMake(0, 2, 26, 26);
            textUserName.textAlignment = NSTextAlignmentLeft;
            textPassword.textAlignment = NSTextAlignmentLeft;
            labelForgotPass.textAlignment = NSTextAlignmentLeft;
            
            
            UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 32)];
            textUserName.leftViewMode = UITextFieldViewModeAlways;
            textUserName.leftView = paddingUserName;

            UIView *paddingPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 32)];
            textPassword.leftViewMode = UITextFieldViewModeAlways;
            textPassword.leftView = paddingPassword;

        }
        else
        {
            [self setArebicLanguage];
            
            imageLogo.image = [UIImage imageNamed:@"login_logo"];
            [btnFacebook setBackgroundImage:[UIImage imageNamed:@"fb_ar_icon"] forState:UIControlStateNormal];

            imageEmail.frame = CGRectMake(textUserName.frame.size.width-26, 2, 26, 26);
            imagePassword.frame = CGRectMake(textPassword.frame.size.width-26, 2, 26, 26);
            textUserName.textAlignment = NSTextAlignmentRight;
            textPassword.textAlignment = NSTextAlignmentRight;
            labelForgotPass.textAlignment = NSTextAlignmentRight;

            
            UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 32)];
            textUserName.rightViewMode = UITextFieldViewModeAlways;
            textUserName.rightView = paddingUserName;

            UIView *paddingPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 32)];
            textPassword.rightViewMode = UITextFieldViewModeAlways;
            textPassword.rightView = paddingPassword;

        }
        
        labelWelcome.text = LocalizedString(@"welcome_to");
        LabelAppName.text = LocalizedString(@"app_name");
        
        labelDescription.text = LocalizedString(@"greate_food");
        textUserName.placeholder = LocalizedString(@"email_add");
        textPassword.placeholder = LocalizedString(@"password");
        strForgotPass= LocalizedString(@"forgot_pass");
        
        [btnLogin setTitle:LocalizedString(@"login") forState:UIControlStateNormal];
        labelFBText.text = LocalizedString(@"fb_connect");
        [btnSignUp setTitle:LocalizedString(@"sign_up") forState:UIControlStateNormal];
        //[btnSkip setTitle:LocalizedString(@"skip") forState:UIControlStateNormal];

        [textUserName setValue:kTextFieldColor forKeyPath:@"_placeholderLabel.textColor"];
        [textPassword setValue:kTextFieldColor forKeyPath:@"_placeholderLabel.textColor"];
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strForgotPass];
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [strForgotPass length])];
        [labelForgotPass setAttributedText:attributedString];

        
        NSString *strSkip= LocalizedString(@"skip");
        NSMutableAttributedString *attributedStrSkip = [[NSMutableAttributedString alloc] initWithString:strSkip];
        [attributedStrSkip addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [strSkip length])];
        [labelSkip setAttributedText:attributedStrSkip];
        
        //textUserName.text = @"tushar.tyagi@mys.st";
        //textPassword.text = @"tushar";
        
    }
    
    
    textUserName.font = [UIFont fontWithName:_roboto_light size:14];
    textPassword.font = [UIFont fontWithName:_roboto_light size:14];

    btnLogin.titleLabel.font = [UIFont fontWithName:_roboto size:18];
    btnSignUp.titleLabel.font = [UIFont fontWithName:_roboto size:18];

    labelForgotPass.font = [UIFont fontWithName:_roboto_light size:16];

    labelSkip.font = [UIFont fontWithName:_roboto size:16];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isKeyBoardVisible)
        [self hideKeyboard];
    
    //[textCurrentField resignFirstResponder];

}


-(void)btnLoginTapped:(id)sender
{
    [textCurrentField resignFirstResponder];

#if DEBUG
    //NSLog(@"----  sUserName : %@",strUserName);
   // NSLog(@"----  btnLoginTapped : %@",strPassword);
#endif
    
    
    strUserName = [strUserName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    strPassword = [strPassword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    
    if(strUserName.length!=0)
    {
        if(strPassword.length!=0)
        {
            loginManager = [[LoginManager alloc]init];
            [loginManager setLoginManagerDelegate:self];
            
            NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
            
            [dataDict setObject:@"login" forKey:@"scope"];
            [dataDict setObject:isEnglish ? @"en" : @"ar" forKey:@"lang"];
            
            [dataDict setObject:strUserName forKey:@"username"];
            [dataDict setObject:strPassword forKey:@"password"];
            
            //[dataDict setObject:@"load_category" forKey:@"scope"];
            //[dataDict setObject:isEnglish ? @"en" : @"ar" forKey:@"lang"];
            
            [loginManager getLogin:dataDict];

        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"password_error") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
            [alert show];
            
        }
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"username_error") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
        [alert show];
        
    }
    
}

-(void)btnForgotPassTapped:(id)sender
{
#if DEBUG
    NSLog(@"----  btnForgotPassTapped  ----");
#endif

    //MyPopUpView *myPopup = [[MyPopUpView alloc]init];
    //[self.view addSubview:myPopup];
    
    CustomAlertView *alert = [[CustomAlertView alloc]initWithForgotPassword:LocalizedString(@"forgot_pass")];
    [alert show];
    
    alert.textEmailAdd.delegate = self;
    
    alert.leftBlock =^()
    {
        
    };
    
    
    alert.rightBlock =^()
    {
        //NSLog(@"-- ale :%@",alert.textEmailAdd.text);
        
        BOOL *isValid = [self isValidEmail:alert.textEmailAdd.text];
        
        if(isValid)
        {
            loginManager = [[LoginManager alloc]init];
            [loginManager setLoginManagerDelegate:self];
            
            NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
            
            [dataDict setObject:@"forgot_password" forKey:@"scope"];
            [dataDict setObject:isEnglish ? @"en" : @"ar" forKey:@"lang"];
            
            [dataDict setObject:alert.textEmailAdd.text forKey:@"email"];
            
            [loginManager getNewPassword:dataDict];
            
        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"enter_valid_email") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
            [alert show];
        }
    };
}

-(BOOL)isValidEmail:(NSString *)emailString
{
    // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}



-(void)btnFacebookTapped:(id)sender
{
#if DEBUG
    NSLog(@"----  btnFacebookTapped  ----");
#endif
    
    //CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"Testing....alert") leftButtonTitle:LocalizedString(@"CANCEL") rightButtonTitle:LocalizedString(@"YES") showsImage:NO];
    //[alert show];
    
    FBHelperObj =[[MYSFacebookHelper alloc]init];
    [FBHelperObj setFbHelperDelegate:self];
        
    [FBHelperObj FBLogIn];
    
}


-(void)successWithFBUserDetails:(LoginUserData *)_userData
{
#if DEBUG
    NSLog(@"-- FB User Details :%@",_userData);
#endif
    
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
   
    [dataDict setObject:@"create_customer_sm" forKey:@"scope"];
    [dataDict setObject:isEnglish ? @"en" : @"ar" forKey:@"lang"];
    
    [dataDict setObject:_userData.userEmail forKey:@"email"];
    [dataDict setObject:_userData.userFirstName forKey:@"first_name"];
    [dataDict setObject:_userData.userLastName forKey:@"last_name"];

    [dataDict setObject:@"" forKey:@"profile_pic"];
    [dataDict setObject:_userData.userFBId forKey:@"password"];

    [dataDict setObject:@"" forKey:@"mobile"];
    [dataDict setObject:@"" forKey:@"address"];
    [dataDict setObject:@"" forKey:@"city"];
    [dataDict setObject:@"" forKey:@"state"];
    [dataDict setObject:@"1" forKey:@"country_id"];   //Static
    [dataDict setObject:@"Facebook" forKey:@"account_from"];

    [dataDict setObject:@"1" forKey:@"is_accepted_terms"];  //Static
    
    [loginManager createOrCheckNewUserWithFBDetails:dataDict];
    
}

-(void)btnSignUpTapped:(id)sender
{
#if DEBUG
    NSLog(@"----  btnSignUpTapped  ----");
#endif

    CreateAccountView *create = [[CreateAccountView alloc]init];
    [self.navigationController pushViewController:create animated:YES];
    
    
}


-(void)btnSkipTapped:(id)sender
{
#if DEBUG
    NSLog(@"----  btn Skip Tapped   ----");
#endif
    
    [appDelegate setNavigationController];
    
}



#pragma mark -------- -----------
#pragma mark ---- TEXT FIELD DELEGATE -----


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(DEVICE_HEIGHT == 480)
    {
        if(!isKeyBoardVisible)
            [self showKeyboard];

    }
    
    textCurrentField = textField;
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField.tag == 0)
        strUserName = textField.text;
    else
        strPassword = textField.text;
    
#if DEBUF
    NSLog(@"--- User Name :%@",textField.text);
    NSLog(@"--- Password :%@",textField.text);
#endif
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self hideKeyboard];

    return YES;
    
}


-(void)showKeyboard
{
    isKeyBoardVisible = YES;
    
    [scrollLanguage scrollRectToVisible:CGRectMake(0, 120, DEVICE_WIDTH, 200) animated:NO];

    //[UIView animateWithDuration:kAnimationDuration animations:^{
    //}completion:^(BOOL finished){
    //}];
    

}


-(void)hideKeyboard
{
    isKeyBoardVisible = NO;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        
    }completion:^(BOOL finished){
        
    }];
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(scrollLanguage.frame);
    NSUInteger page = floor((scrollLanguage.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    pageControl.currentPage = page;
    //[pageControl updateCurrentPageDisplay] ;
    
    if(page == 0)
    {
        [self setEnglishLanguage];
        
    }
    else
    {
        [self setArebicLanguage];

    }
    
}


#pragma mark -
#pragma mark - Facebook Delegate Methods

/*
-(void)didRecieveAccessToken:(NSString*)accessToken
{
    if (accessToken)
    {
        NSLog(@"Facebook authenticated successfully!");
        [AppMemory storeData:accessToken forKey:FACEBOOK_TOKEN_KEY];
        //        HomeViewController *home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        //        [self.navigationController pushViewController:home animated:YES];
        
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        [del loginSuccessfull:nil];
    }
}

-(void)didFailToSignIn:(NSString*)errMsg
{
    NSLog(@"%@",errMsg);
}
 */


#pragma mark ---- ----  Delegate Call back Methods  ----  ----


-(void)problemForGettingResponse:(NSString *)_message
{
    [appDelegate stopSpinner];

    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:_message leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
    [alert show];
    
}


-(void)requestFailWithError:(NSString *)_errorMessage
{
    [appDelegate stopSpinner];

    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:_errorMessage leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
    [alert show];
    
}


-(void)successWithLoginDetails:(LoginUserData *)_loginUserData
{
    [appDelegate stopSpinner];
    
    [appDelegate setNavigationController];

}



-(void)successfullyResetPassword:(NSString *)_message
{
    [appDelegate stopSpinner];

    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:_message leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
    [alert show];
    
}


-(void)successWithSocialMedia:(NSString *)_message
{
    [appDelegate stopSpinner];
    
    [appDelegate setNavigationController];

    //CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:_message leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
    //[alert show];

}

@end
