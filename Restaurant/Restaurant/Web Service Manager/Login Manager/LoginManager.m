//
//  LoginManager.m
//  Restaurant
//
//  Created by IMAC05 on 03/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "LoginManager.h"

#import "MYSStringUtils.h"
#import "Constants.h"
#import "JSONStringGenerator.h"

@implementation LoginManager

@synthesize loginManagerDelegate;
static LoginManager *sharedInstance = nil;


#pragma mark --------------- Sigleton Copy Object ---------------------


+ (id)allocWithZone:(NSZone*)zone
{
    return [self sharedInstance];
}

// Get the shared instance and create it if necessary.
+ (LoginManager *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

#pragma mark --------------- -------------------- ---------------------


-(NSString *)getFinalHexString:(NSMutableDictionary *)_dataDict
{
    NSString *jsonInput = [JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:_dataDict];
    
    NSString *newinputParamString =[MYSStringUtils convertStringInToHex:jsonInput];
    NSString *signature = [MYSStringUtils generateSignatureForString:newinputParamString withKey:APP_SHRAED_KEY];
    
    NSString *inputString = [NSString stringWithFormat:@"post_data=%@&auth=%@",newinputParamString,signature];
    
#if DEBUG
    NSLog(@"-- Parameter String :%@",jsonInput);
    NSLog(@"-- Parameter Data :%@",inputString);
#endif
    
    return inputString;
    
}



-(void)getLogin:(NSMutableDictionary *)_dataDict
{
    
    NSString *inputString = [self getFinalHexString:_dataDict];
  
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    [proxy asyncronouslyPOSTRequestURL:@""
                    withBodyParameters:[inputString dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"login"];
    
}



-(void)createNewCustomer:(NSMutableDictionary *)_dataDict
{
    NSString *inputString = [self getFinalHexString:_dataDict];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    [proxy asyncronouslyPOSTRequestURL:@""
                    withBodyParameters:[inputString dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"create_customer"];
    
}

-(void)getCountryDetails:(NSMutableDictionary *)_dataDict
{
    NSString *inputString = [self getFinalHexString:_dataDict];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    [proxy asyncronouslyPOSTRequestURL:@""
                    withBodyParameters:[inputString dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"load_country"];
    
}



-(void)getNewPassword:(NSMutableDictionary *)_dataDict
{
    NSString *inputString = [self getFinalHexString:_dataDict];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    [proxy asyncronouslyPOSTRequestURL:@""
                    withBodyParameters:[inputString dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"forgot_password"];
    
}


-(void)createOrCheckNewUserWithFBDetails:(NSMutableDictionary *)_dataDict
{
    NSString *inputString = [self getFinalHexString:_dataDict];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    [proxy asyncronouslyPOSTRequestURL:@""
                    withBodyParameters:[inputString dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"create_customer_sm"];
    
}


#pragma mark --- --- ---- ---- ----
#pragma mark - API Response Methods

- (void)didRecieveResponse:(NSDictionary *)responseDictionary
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSLog(@"--- Response :%@",responseDictionary);
    
    NSMutableData *data = [responseDictionary valueForKey:MYS_RESPONSE_DATA_KEY];
    NSError* error = nil;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    int status = [[json valueForKey:@"status"] intValue];
    
    
    if(status)
    {
        //NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"data"]]);
        
        if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"login"])
        {
            if([json valueForKey:@"data"])
            {
                NSMutableDictionary *customerInfo = [[json valueForKey:@"data"] valueForKey:@"Customer"];
                
                appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                
                LoginUserData *loginData = [[LoginUserData alloc]init];
                
                loginData.userId = [appDelegate checkForNullValue:[customerInfo valueForKey:@"id"]];
                loginData.userFirstName = [appDelegate checkForNullValue:[customerInfo valueForKey:@"first_name"]];
                loginData.userLastName = [appDelegate checkForNullValue:[customerInfo valueForKey:@"last_name"]];
                loginData.userEmail = [appDelegate checkForNullValue:[customerInfo valueForKey:@"email"]];
                loginData.userMobile = [appDelegate checkForNullValue:[customerInfo valueForKey:@"mobile"]];
                loginData.userProfilePicture = [appDelegate checkForNullValue:[customerInfo valueForKey:@"profile_pic"]];
                
                appDelegate.userDetails = loginData;
                [appDelegate saveCustomObject:loginData];
                
                if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithLoginDetails:)])
                    [loginManagerDelegate successWithLoginDetails:loginData];
                
                
            }

        }
        else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"create_customer"])
        {
            //{"Customer":{"email":"english@mys.st","profile_pic":"","mobile":"1","last_name":"","id":"7","first_name":"test"}}
            
            if([json valueForKey:@"data"])
            {
                NSMutableDictionary *customerInfo = [[json valueForKey:@"data"] valueForKey:@"Customer"];
                
                appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                
                LoginUserData *loginData = [[LoginUserData alloc]init];
                
                loginData.userId = [appDelegate checkForNullValue:[customerInfo valueForKey:@"id"]];
                loginData.userFirstName = [appDelegate checkForNullValue:[customerInfo valueForKey:@"first_name"]];
                loginData.userLastName = [appDelegate checkForNullValue:[customerInfo valueForKey:@"last_name"]];
                loginData.userEmail = [appDelegate checkForNullValue:[customerInfo valueForKey:@"email"]];
                loginData.userMobile = [appDelegate checkForNullValue:[customerInfo valueForKey:@"mobile"]];
                loginData.userProfilePicture = [appDelegate checkForNullValue:[customerInfo valueForKey:@"profile_pic"]];
                
                appDelegate.userDetails = loginData;
                [appDelegate saveCustomObject:loginData];
                
                if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyCreateNewAccount)])
                    [loginManagerDelegate successfullyCreateNewAccount];
                
                
            }
            
        }
        else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"load_country"])
        {
            //NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"data"]]);

            NSMutableArray *arrayCountry = [[NSMutableArray alloc]init];
            
            NSMutableDictionary *countryInfo = [[json valueForKey:@"data"] valueForKey:@"Country"];
            
            for(int i =0; i<[countryInfo count]; i++)
            {
                CountryData *countryData = [[CountryData alloc]init];
                
                countryData.countryId = [appDelegate checkForNullValue:[[countryInfo valueForKey:@"id"] objectAtIndex:i]];
                countryData.countryCode = [appDelegate checkForNullValue:[[countryInfo valueForKey:@"code"] objectAtIndex:i]];

                countryData.countryName_en = [appDelegate checkForNullValue:[[countryInfo valueForKey:@"name_en"] objectAtIndex:i]];
                countryData.countryName_ar = [appDelegate checkForNullValue:[[countryInfo valueForKey:@"name_ar"] objectAtIndex:i]];

                
                NSMutableDictionary *citiesDict = [[countryInfo valueForKey:@"cities"] objectAtIndex:i];
                
                for(int j =0; j<[citiesDict count]; j++)
                {
                    NSLog(@"-- Dict :%@", [[citiesDict valueForKey:@"name_ar"] objectAtIndex:j]);

                    CountryData *cityData = [[CountryData alloc]init];
                    
                    cityData.cityId = [appDelegate checkForNullValue:[[citiesDict valueForKey:@"id"] objectAtIndex:j]];
                    
                    cityData.cityName_ar = [appDelegate checkForNullValue:[[citiesDict valueForKey:@"name_ar"] objectAtIndex:j]];
                    cityData.cityName_en = [appDelegate checkForNullValue:[[citiesDict valueForKey:@"name_en"] objectAtIndex:j]];

                    cityData.cityLatitude = [appDelegate checkForNullValue:[[citiesDict valueForKey:@"latitude"] objectAtIndex:j]];
                    cityData.cityLongitude = [appDelegate checkForNullValue:[[citiesDict valueForKey:@"longitude"] objectAtIndex:j]];

                    [countryData.arrayCities addObject:cityData];
                    cityData = nil;
                    
                }
                
                [arrayCountry addObject:countryData];
                countryData = nil;
                
            }
            
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithCountryDetails:)])
                [loginManagerDelegate successWithCountryDetails:arrayCountry];
            
            
        }
        else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"forgot_password"])
        {
            if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyResetPassword:)])
                [loginManagerDelegate successfullyResetPassword:[json valueForKey:@"message"]];

        }
        else if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"create_customer_sm"])
        {
            if([json valueForKey:@"data"])
            {
                NSMutableDictionary *customerInfo = [[json valueForKey:@"data"] valueForKey:@"Customer"];
                
                appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                
                LoginUserData *loginData = [[LoginUserData alloc]init];
                
                loginData.userId = [appDelegate checkForNullValue:[customerInfo valueForKey:@"id"]];
                loginData.userFirstName = [appDelegate checkForNullValue:[customerInfo valueForKey:@"first_name"]];
                loginData.userLastName = [appDelegate checkForNullValue:[customerInfo valueForKey:@"last_name"]];
                loginData.userEmail = [appDelegate checkForNullValue:[customerInfo valueForKey:@"email"]];
                loginData.userMobile = [appDelegate checkForNullValue:[customerInfo valueForKey:@"mobile"]];
                loginData.userProfilePicture = [appDelegate checkForNullValue:[customerInfo valueForKey:@"profile_pic"]];
                
                appDelegate.userDetails = loginData;
                [appDelegate saveCustomObject:loginData];
                
                //if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successfullyCreateNewAccount)])
                  //  [loginManagerDelegate successfullyCreateNewAccount];
                
                if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(successWithSocialMedia:)])
                    [loginManagerDelegate successWithSocialMedia:[json valueForKey:@"message"]];
                
                
            }
            
            
        }
        
        
        
    }
    else
    {
        if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
        {
            if ([json valueForKey:@"message"] == nil || [[json valueForKey:@"message"] isKindOfClass:[NSNull class]])
                [loginManagerDelegate problemForGettingResponse:LocalizedString(@"went_wrong")];
            else
                [loginManagerDelegate problemForGettingResponse:[json valueForKey:@"message"]];
            
        }
        
    }
    
}

- (void)didFailWithError:(NSDictionary *)error
{
    NSLog(@"-- Error Desc :%@", [error description]);
    
    if(loginManagerDelegate!=nil && [loginManagerDelegate respondsToSelector:@selector(requestFailWithError:)])
        [loginManagerDelegate requestFailWithError:[error description]];
    
}





@end
