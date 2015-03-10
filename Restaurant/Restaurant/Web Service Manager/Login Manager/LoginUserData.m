//
//  LoginUserData.m
//  Restaurant
//
//  Created by IMAC05 on 03/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "LoginUserData.h"

@implementation LoginUserData


@synthesize userId;
@synthesize userFirstName;
@synthesize userLastName;
@synthesize userEmail;
@synthesize userMobile;
@synthesize userProfilePicture;

@synthesize userFBId;
@synthesize userFBLink;
@synthesize userGender;

@synthesize countryId;
@synthesize countryName;

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil )
    {
        //decode properties, other class vars
        userId = [decoder decodeObjectForKey:@"userId"];
        userFirstName = [decoder decodeObjectForKey:@"userFirstName"];
        userLastName = [decoder decodeObjectForKey:@"userLastName"];
        userEmail = [decoder decodeObjectForKey:@"userEmail"];
        userMobile = [decoder decodeObjectForKey:@"userMobile"];
        userProfilePicture = [decoder decodeObjectForKey:@"userProfilePicture"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:userId forKey:@"userId"];
    [encoder encodeObject:userFirstName forKey:@"userFirstName"];
    [encoder encodeObject:userLastName forKey:@"userLastName"];
    [encoder encodeObject:userEmail forKey:@"userEmail"];
    [encoder encodeObject:userMobile forKey:@"userMobile"];
    [encoder encodeObject:userProfilePicture forKey:@"userProfilePicture"];
    
}


@end
