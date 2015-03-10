//
//  RestaurantManager.m
//  Restaurant
//
//  Created by IMAC05 on 05/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "RestaurantManager.h"

#import "MYSStringUtils.h"
#import "Constants.h"
#import "JSONStringGenerator.h"


@implementation RestaurantManager

@synthesize restaurantManagerDelegate;
static RestaurantManager *sharedInstance = nil;


#pragma mark --------------- Sigleton Copy Object ---------------------


+ (id)allocWithZone:(NSZone*)zone
{
    return [self sharedInstance];
}

// Get the shared instance and create it if necessary.
+ (RestaurantManager *)sharedInstance
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



-(void)getCategoryDetails:(NSMutableDictionary *)_dataDict
{
    
    NSString *inputString = [self getFinalHexString:_dataDict];
    
    proxy = [[MYSGenericProxy alloc] init];
    proxy.genericProxyListener = self;
    [proxy asyncronouslyPOSTRequestURL:@""
                    withBodyParameters:[inputString dataUsingEncoding:NSUTF8StringEncoding]
                  withHeaderParameters:nil
                         withRequestId:@"load_category"];
    
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
        NSLog(@"--- Response :%@",[JSONStringGenerator jsonStringWithPrettyPrint:NO fromDict:[json valueForKey:@"data"]]);
        
        if([[responseDictionary valueForKey:MYS_REQUEST_ID_KEY] isEqualToString:@"load_category"])
        {
            if([json valueForKey:@"data"])
            {
                NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                
                NSMutableDictionary *categoryData = [[json valueForKey:@"data"] valueForKey:@"Category"];
                NSLog(@"--- Category :%@", categoryData);
                
                if(restaurantManagerDelegate!=nil && [restaurantManagerDelegate respondsToSelector:@selector(successWithCategoryDetails:)])
                    [restaurantManagerDelegate successWithCategoryDetails:dataArray];
                
                
            }
            
        }
        
    }
    else
    {
        if(restaurantManagerDelegate!=nil && [restaurantManagerDelegate respondsToSelector:@selector(problemForGettingResponse:)])
        {
            if ([json valueForKey:@"message"] == nil || [[json valueForKey:@"message"] isKindOfClass:[NSNull class]])
                [restaurantManagerDelegate problemForGettingResponse:LocalizedString(@"went_wrong")];
            else
                [restaurantManagerDelegate problemForGettingResponse:[json valueForKey:@"message"]];
            
        }
        
    }
    
}

- (void)didFailWithError:(NSDictionary *)error
{
    NSLog(@"-- Error Desc :%@", [error description]);
    
    if(restaurantManagerDelegate!=nil && [restaurantManagerDelegate respondsToSelector:@selector(requestFailWithError:)])
        [restaurantManagerDelegate requestFailWithError:[error description]];
    
}



@end
