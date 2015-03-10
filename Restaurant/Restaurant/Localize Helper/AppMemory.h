//
//  AppMemory.h
//  Tayrni
//
//  Created by Mahesh on 06/08/14.
//  Copyright (c) 2014 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppMemory : NSObject

+ (void)storeData:(id)data forKey:(NSString *)key;

+ (id)getDataForKey:(NSString *)key;

+ (void)setLanguage:(NSString *)lang;

@end
