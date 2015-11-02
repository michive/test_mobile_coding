//
//  RequestManager.h
//  test_mobile_coding
//
//  Created by Michele Verani on 30/10/15.
//  Copyright © 2015 mikydevelop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ResponseModel.h"

@protocol RequestManagerDelegate <NSObject>

-(void) requestFinished:(ResponseModel*) responseModel;
-(void) requestFinishedWithArray:(NSArray *)responseDictArray;

-(void) requestFinishedWithError:(NSError *) error;

@end

@interface RequestManager : NSObject
{
    NSString *_urlString;
    
    NSString *_companyName;
    
    id<RequestManagerDelegate> _delegate;
    
}

@property (nonatomic, strong) id<RequestManagerDelegate> delegate;

/**
 * initWithCompanyName
 * @param cName: company name
 */

-(instancetype) initWithCompanyName:(NSString*) cName;

#pragma mark - Public method
/**
 * startSending: Method to send the request
 */

-(void) startSending;


@end
