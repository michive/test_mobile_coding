//
//  NSString+Utilities.m
//  test_mobile_coding
//
//  Created by Michele Verani on 30/10/15.
//  Copyright © 2015 mikydevelop. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)

- (NSString *) removeAllWhitespace
{
    return [self stringByReplacingOccurrencesOfString:@"\\s" withString:@""
                                              options:NSRegularExpressionSearch
                                                range:NSMakeRange(0, [self length])];
}

@end
