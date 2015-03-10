//
//  CountryData.h
//  Restaurant
//
//  Created by IMAC05 on 10/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryData : NSObject

@property (nonatomic, retain) NSString *countryId;
@property (nonatomic, retain) NSString *countryCode;

@property (nonatomic, retain) NSString *countryName_en;
@property (nonatomic, retain) NSString *countryName_ar;

@property (nonatomic, retain) NSMutableArray *arrayCities;


@property (nonatomic, retain) NSString *cityId;
@property (nonatomic, retain) NSString *cityName_en;
@property (nonatomic, retain) NSString *cityName_ar;

@property (nonatomic, retain) NSString *cityLatitude;
@property (nonatomic, retain) NSString *cityLongitude;


@end
