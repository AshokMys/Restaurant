//
//  CreateAccountView.m
//  Restaurant
//
//  Created by IMAC05 on 13/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "CreateAccountView.h"
#import "Constants.h"

#import "LocalizeHelper.h"
#import "CustomAlertView.h"

#define kAnimationDuration 0.3


#define kTextFieldColor [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1]


@interface CreateAccountView ()

@end

@implementation CreateAccountView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
        isEnglish = YES;
    else
        isEnglish = NO;

    countryId = -1;
    
    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 475);
    
    arrayCountryNames = [[NSMutableArray alloc]init];
    
    [arrayCountryNames addObject:@"sdfsd 1"];
    [arrayCountryNames addObject:@"sdfsd 2"];
    [arrayCountryNames addObject:@"sdfsd 3"];
    [arrayCountryNames addObject:@"sdfsd 4"];
    [arrayCountryNames addObject:@"sdfsd 5"];
    [arrayCountryNames addObject:@"sdfsd 6"];
    [arrayCountryNames addObject:@"sdfsd 7"];
    [arrayCountryNames addObject:@"sdfsd 8"];

    [self getCountryDetails];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setUIAsPerLanguage];

  
}


-(void)setUIAsPerLanguage
{
    labelAppName.font = [UIFont fontWithName:_roboto_light size:16];
    labelWelcome.font = [UIFont fontWithName:_roboto_light size:16];
    labelMessage.font = [UIFont fontWithName:_roboto_light size:16];

    textUserName.font = [UIFont fontWithName:_roboto_light size:14];
    textEmailAdd.font = [UIFont fontWithName:_roboto_light size:14];
    textMobile.font = [UIFont fontWithName:_roboto_light size:14];
    textPassword.font = [UIFont fontWithName:_roboto_light size:14];
    textConfirmPass.font = [UIFont fontWithName:_roboto_light size:14];
    textCountry.font = [UIFont fontWithName:_roboto_light size:14];

    labelTerms.font = [UIFont fontWithName:_roboto_light size:16];
    
    btnCreateAccount.titleLabel.font = [UIFont fontWithName:_roboto size:18];
    btnLogin.titleLabel.font = [UIFont fontWithName:_roboto size:18];

    
    [textUserName setValue:kTextFieldColor forKeyPath:@"_placeholderLabel.textColor"];
    [textEmailAdd setValue:kTextFieldColor forKeyPath:@"_placeholderLabel.textColor"];
    [textMobile setValue:kTextFieldColor forKeyPath:@"_placeholderLabel.textColor"];
    [textPassword setValue:kTextFieldColor forKeyPath:@"_placeholderLabel.textColor"];
    [textConfirmPass setValue:kTextFieldColor forKeyPath:@"_placeholderLabel.textColor"];
    [textCountry setValue:kTextFieldColor forKeyPath:@"_placeholderLabel.textColor"];
    
    
    labelWelcome.text = LocalizedString(@"welcome_to");
    labelAppName.text = LocalizedString(@"app_name");
    labelMessage.text = LocalizedString(@"greate_food");
    labelTerms.text = LocalizedString(@"terms");
    
    textUserName.placeholder = LocalizedString(@"user_name");
    textEmailAdd.placeholder = LocalizedString(@"email_add");
    textMobile.placeholder = LocalizedString(@"mobile_number");
    textPassword.placeholder = LocalizedString(@"password");
    textConfirmPass.placeholder = LocalizedString(@"confirm_pass");
    textCountry.placeholder = LocalizedString(@"country");
    
    [btnLogin setTitle:LocalizedString(@"login") forState:UIControlStateNormal];
    [btnCreateAccount setTitle:LocalizedString(@"create") forState:UIControlStateNormal];

    //textUserName.backgroundColor = [UIColor redColor];
    
    imageUserName.frame = CGRectMake(isEnglish ? 20 : textUserName.frame.size.width-10, textUserName.frame.origin.y, 30, 30);
    imageEmailAdd.frame = CGRectMake(isEnglish ? 20 : textEmailAdd.frame.size.width-10, textEmailAdd.frame.origin.y, 30, 30);
    imageMobile.frame = CGRectMake(isEnglish ? 20 : textMobile.frame.size.width-10, textMobile.frame.origin.y, 30, 30);

    imagePassword.frame = CGRectMake(isEnglish ? 20 : textPassword.frame.size.width-10, textPassword.frame.origin.y, 30, 30);
    imageConfirmPass.frame = CGRectMake(isEnglish ? 20 : textConfirmPass.frame.size.width-10, textConfirmPass.frame.origin.y, 30, 30);
    imageCountry.frame = CGRectMake(isEnglish ? 20 : textCountry.frame.size.width-10, textCountry.frame.origin.y, 30, 30);

    btnAcceptTerms.frame = CGRectMake(isEnglish ? 20 : DEVICE_WIDTH - 60, 319, 40, 30);
    btnAcceptTerms.contentEdgeInsets = isEnglish ? UIEdgeInsetsMake(0, 0, 0, 10) : UIEdgeInsetsMake(0, 10, 0, 0);

    labelTerms.frame = CGRectMake(isEnglish ? 70 : 20, 319, DEVICE_WIDTH - 80 -10, 30);
    labelTerms.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;


    if(isEnglish)
    {
        
        UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textUserName.leftViewMode = UITextFieldViewModeAlways;
        textUserName.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textEmailAdd.leftViewMode = UITextFieldViewModeAlways;
        textEmailAdd.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textMobile.leftViewMode = UITextFieldViewModeAlways;
        textMobile.leftView = paddingUserName;

        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textPassword.leftViewMode = UITextFieldViewModeAlways;
        textPassword.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textConfirmPass.leftViewMode = UITextFieldViewModeAlways;
        textConfirmPass.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textCountry.leftViewMode = UITextFieldViewModeAlways;
        textCountry.leftView = paddingUserName;

        
    }
    else
    {
        
        UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 32)];
        textUserName.rightViewMode = UITextFieldViewModeAlways;
        textUserName.rightView = paddingUserName;

        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textEmailAdd.rightViewMode = UITextFieldViewModeAlways;
        textEmailAdd.rightView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textMobile.rightViewMode = UITextFieldViewModeAlways;
        textMobile.rightView = paddingUserName;

        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textPassword.rightViewMode = UITextFieldViewModeAlways;
        textPassword.rightView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textConfirmPass.rightViewMode = UITextFieldViewModeAlways;
        textConfirmPass.rightView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 32)];
        textCountry.rightViewMode = UITextFieldViewModeAlways;
        textCountry.rightView = paddingUserName;
        
    }
    
    textUserName.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textEmailAdd.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textMobile.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textPassword.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textConfirmPass.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    textCountry.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)btnAcceptTermsTapped:(id)sender
{
    if(btnAcceptTerms.selected == YES)
    {
        btnAcceptTerms.selected = NO;
        
        [btnAcceptTerms setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];

    }
    else
    {
        btnAcceptTerms.selected = YES;
        
        [btnAcceptTerms setImage:[UIImage imageNamed:@"checkbox-selected"] forState:UIControlStateNormal];

    }

}

-(IBAction)btnCreateAccountTapped:(id)sender
{
    textUserName.text = [textUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    textEmailAdd.text = [textEmailAdd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    textMobile.text = [textMobile.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    textPassword.text = [textPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    textConfirmPass.text = [textConfirmPass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    textCountry.text = [textCountry.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(textUserName.text.length!=0)
    {
        if(textEmailAdd.text.length!=0)
        {
            if([self isValidEmail:textEmailAdd.text])
            {
                if(textMobile.text.length!=0)
                {
                    if(textPassword.text.length!=0)
                    {
                        if(textConfirmPass.text.length!=0)
                        {
                            if([textPassword.text isEqualToString:textConfirmPass.text])
                            {
                                //if(textCountry.text.length!=0)
                                if(countryId != -1)
                                {
                                    
                                    [self createNewAccount];
                                    
                                }
                                else
                                {
                                    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"country_error") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
                                    [alert show];
                                    
                                }
                                
                            }
                            else
                            {
                                CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"enter_same_password") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
                                [alert show];
                                
                            }
                        }
                        else
                        {
                            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"confirm_password_error") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
                            [alert show];
                            
                        }
                    }
                    else
                    {
                        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"password_error") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
                        [alert show];
                        
                    }
                }
                else
                {
                    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"mobile_error") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
                    [alert show];
                
                }
            }
            else
            {
                CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"enter_valid_email") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
                [alert show];
                
            }
        }
        else
        {
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"email_error") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
            [alert show];
            
        }
    }
    else
    {
        CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"username_error") leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
        [alert show];
        
    }
    
}


-(void)createNewAccount
{
    [textCurrentField resignFirstResponder];
    
    [appDelegate startSpinner];
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    
    [dataDict setObject:@"create_customer" forKey:@"scope"];
    [dataDict setObject:isEnglish ? @"en" : @"ar" forKey:@"lang"];
    
    [dataDict setObject:textUserName.text forKey:@"first_name"];
    [dataDict setObject:@"" forKey:@"last_name"];
    [dataDict setObject:textEmailAdd.text forKey:@"email"];
    
    [dataDict setObject:@"" forKey:@"profile_pic"];
    [dataDict setObject:textPassword.text forKey:@"password"];
    [dataDict setObject:textMobile.text forKey:@"mobile"];
    
    [dataDict setObject:@"" forKey:@"address"];
    [dataDict setObject:@"" forKey:@"city"];
    [dataDict setObject:@"" forKey:@"state"];
    
    [dataDict setObject:[[arrayCountryNames objectAtIndex:countryId] countryId] forKey:@"country_id"];
    [dataDict setObject:@"Custom" forKey:@"account_from"];
    [dataDict setObject:@"YES" forKey:@"is_accepted_terms"];
    
    [loginManager createNewCustomer:dataDict];
    
}


-(void)getCountryDetails
{
    
    loginManager = [[LoginManager alloc]init];
    [loginManager setLoginManagerDelegate:self];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    
    [dataDict setObject:@"load_country" forKey:@"scope"];
    [dataDict setObject:isEnglish ? @"en" : @"ar" forKey:@"lang"];
    
    [loginManager getCountryDetails:dataDict];
   
}

-(IBAction)btnLoginTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark -------- -----------
#pragma mark ---- TEXT FIELD DELEGATE -----


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(!isKeyBoardVisible)
        [self showKeyboard];

    if(textField == textCountry)
    {
        [self showPickerView];
        
        return NO;
    }
    
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
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        CGRect newFrame = topView.frame;
        newFrame.size.height = 0;
        topView.frame = newFrame;

        
        newFrame = scrollView.frame;
        newFrame.origin.y = scrollView.frame.origin.y - 221;
        scrollView.frame = newFrame;

        
        topView.alpha = 0;
        
    }completion:^(BOOL finished){
        
    }];
    
   //
}


-(void)hideKeyboard
{
    isKeyBoardVisible = NO;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        CGRect newFrame = topView.frame;
        newFrame.size.height = 221;
        topView.frame = newFrame;
        
        
        newFrame = scrollView.frame;
        newFrame.origin.y = scrollView.frame.origin.y + 221;
        scrollView.frame = newFrame;

        
        topView.alpha = 1;
        
    }completion:^(BOOL finished){
        
    }];

}


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


-(void)successfullyCreateNewAccount
{
    [appDelegate stopSpinner];

    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:[NSString stringWithFormat:LocalizedString(@"ac_create_success"), textUserName.text] leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
    [alert show];
 
    
    alert.rightBlock = ^()
    {
        [appDelegate setNavigationController];

    };
}


-(void)successWithCountryDetails:(NSMutableArray *)_dataArray
{
#if DEBUG
    NSLog(@"-- Country : %@",_dataArray);
#endif
    
    arrayCountryNames = _dataArray;
    
}

//----------------


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


-(void)shakeTextField:(UITextField *)textField
{
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:1.5];
    [shake setRepeatCount:1];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(textField.center.x - 5,textField.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(textField.center.x + 5, textField.center.y)]];
    [textField.layer addAnimation:shake forKey:@"position"];
    
}


#pragma mark --- ---- ---- ----
#pragma mark ---- ----   Picker Delegate ----  ----

-(void)showPickerView
{
    
    viewCountry = [[UIView alloc]init];
    viewCountry.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    viewCountry.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewCountry];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [viewCountry addSubview:bgView];
    
    [textUserName resignFirstResponder];
    [textEmailAdd resignFirstResponder];
    [textPassword resignFirstResponder];
    [textConfirmPass resignFirstResponder];
    [textMobile resignFirstResponder];

 
    pickerView = [[UIPickerView alloc] init];
    pickerView.frame = CGRectMake(0, DEVICE_HEIGHT-150, DEVICE_WIDTH, 100);
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    pickerView.backgroundColor = [UIColor whiteColor];
    
    [viewCountry addSubview:pickerView];

    UIView *countryTopView = [[UIView alloc]init];
    countryTopView.frame = CGRectMake(0, DEVICE_HEIGHT-190, DEVICE_WIDTH, 40);
    countryTopView.backgroundColor = [UIColor darkGrayColor];
    [viewCountry addSubview:countryTopView];
    
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(DEVICE_WIDTH-80, 5, 70, 30);
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    btnDone.titleLabel.font = [UIFont fontWithName:_roboto size:18];
    btnDone.titleLabel.textAlignment = NSTextAlignmentRight;
    [btnDone addTarget:self action:@selector(btnDoneCountryTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnDone.backgroundColor = [UIColor colorWithRed:132.0/255.0 green:210.0/255.0 blue:143.0/255.0 alpha:1];
    [countryTopView addSubview:btnDone];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(10, 5, 70, 30);
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont fontWithName:_roboto size:18];
    btnCancel.titleLabel.textAlignment = NSTextAlignmentRight;
    [btnCancel addTarget:self action:@selector(btnCancelCountryTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnCancel.backgroundColor = [UIColor colorWithRed:132.0/255.0 green:210.0/255.0 blue:143.0/255.0 alpha:1];
    [countryTopView addSubview:btnCancel];
    
    if(countryId != -1)
        [pickerView selectRow:countryId inComponent:0 animated:YES];
    
    
}


-(void)btnDoneCountryTapped:(id)sender
{
    [self hideKeyboard];
    [viewCountry removeFromSuperview];

    countryId = selectedIndex;
    textCountry.text = isEnglish ? [[arrayCountryNames objectAtIndex:countryId] countryName_en] : [[arrayCountryNames objectAtIndex:countryId] countryName_ar];

}

-(void)btnCancelCountryTapped:(id)sender
{
    if(countryId !=-1)
        textCountry.text =  isEnglish ? [[arrayCountryNames objectAtIndex:countryId] countryName_en] : [[arrayCountryNames objectAtIndex:countryId] countryName_ar];
    else
        textCountry.text = @"";
    
    [self hideKeyboard];
    [viewCountry removeFromSuperview];
    
}


- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSLog(@"-- Country Count: %d", [arrayCountryNames count]);

    return [arrayCountryNames count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSLog(@"-- Slected Country : %@", [[arrayCountryNames objectAtIndex:row] countryName_en]);

    return @""; //isEnglish ? [[arrayCountryNames objectAtIndex:row] countryName_en] : [[arrayCountryNames objectAtIndex:row] countryName_ar];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedIndex = row;
    textCountry.text =  isEnglish ? [[arrayCountryNames objectAtIndex:row] countryName_en] : [[arrayCountryNames objectAtIndex:row] countryName_ar];
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        tView.textAlignment = NSTextAlignmentCenter;
        tView.font = [UIFont fontWithName:_roboto_light size:16];
        tView.text = isEnglish ? [[arrayCountryNames objectAtIndex:row] countryName_en] : [[arrayCountryNames objectAtIndex:row] countryName_ar];
        tView.textColor = [UIColor darkGrayColor];//kTextFieldColor;
        
        
    }

    return tView;
}



@end
