//
//  AppMemory.m
//  Tayrni
//
//  Created by Mahesh on 06/08/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import "AppMemory.h"
#import "LocalizeHelper.h"
#import "Constants.h"


@implementation AppMemory

+ (void)storeData:(id)data forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

+ (id)getDataForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id data = [defaults objectForKey:key];
    return data;
}

+ (void)setLanguage:(NSString *)lang
{
    if ([lang isEqualToString:LANGUAGE_VALUE_ARE])
    {
        [AppMemory storeData:LANGUAGE_VALUE_ARE forKey:LANGUAGE_KEY];
        LocalizationSetLanguage(@"ar");
    }
    else
    {
        [AppMemory storeData:LANGUAGE_VALUE_ENG forKey:LANGUAGE_KEY];
        LocalizationSetLanguage(@"en");
    }
}

@end
