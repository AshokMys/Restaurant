//
//  RestaurantManager.h
//  Restaurant
//
//  Created by IMAC05 on 05/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "MYSGenericProxy.h"


@protocol RestaurantManagerDelegate <NSObject>

-(void)problemForGettingResponse:(NSString *)_message;
-(void)requestFailWithError:(NSString *)_errorMessage;

@optional
-(void)successWithCategoryDetails:(NSMutableArray *)_dataArray;

@end


@interface RestaurantManager : NSObject <MYSWebRequestProxyDelegate>
{
    AppDelegate *appDelegate;
    
    MYSGenericProxy *proxy;
    
}


@property (nonatomic, assign) id<RestaurantManagerDelegate> restaurantManagerDelegate;


+ (id)allocWithZone:(NSZone*)zone;
+ (RestaurantManager *)sharedInstance;



-(void)getCategoryDetails:(NSMutableDictionary *)_dataDict;


@end
