//
//  ResponseModel.m
//  test_mobile_coding
//
//  Created by Michele Verani on 30/10/15.
//  Copyright © 2015 mikydevelop. All rights reserved.
//

#import "ResponseModel.h"

NSString * const custom_color = @"custom_color";
NSString * const logo = @"logo";
NSString * const name = @"name";
NSString*  const  password_changing = @"password_changing";

NSString* const success = @"success";

@implementation ResponseModel


-(instancetype) initWithResponse:(NSDictionary*)respDict
{
    if ([super init])
    {
        _fuseResponse = respDict;
    }
    
    return self;
}

-(NSDictionary *) getFuseResponse
{
    return _fuseResponse;
}

@end
