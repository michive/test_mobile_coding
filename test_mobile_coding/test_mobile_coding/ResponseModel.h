//
//  ResponseModel.h
//  test_mobile_coding
//
//  Created by Michele Verani on 30/10/15.
//  Copyright © 2015 mikydevelop. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REQUEST_JSON @".fusion-universal.com/api/v1/company.json"

extern NSString* const custom_color;
extern NSString* const logo;
extern NSString* const name;
extern NSString* const passwordChanging;

extern NSString* const success;

@interface ResponseModel : NSObject
{
    NSDictionary *_fuseResponse;
}

-(instancetype) initWithResponse:(NSDictionary*)respDict;

-(NSDictionary* ) getFuseResponse;

@end
