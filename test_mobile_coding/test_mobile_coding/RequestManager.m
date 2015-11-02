//
//  RequestManager.m
//  test_mobile_coding
//
//  Created by Michele Verani on 30/10/15.
//  Copyright © 2015 mikydevelop. All rights reserved.
//

#import "RequestManager.h"

#import "HTTPCodes.h"

#import "NSString+Utilities.h"

@implementation RequestManager

@synthesize delegate = _delegate;

#pragma mark - Initialize methods
-(instancetype) initWithCompanyName:(NSString*) cName
{
    if ([self init])
    {
        
        //4.1 remove any white space from text
        _companyName = [cName removeAllWhitespace];
    
    }
    
    return  self;
}

#pragma mark - Public methods

-(void) startSending
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    _urlString =  [NSString stringWithFormat:@"https://%@%@",_companyName,REQUEST_JSON];
    
    [manager GET:_urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AFHTTPRequestOperation *localOperation = operation;
        
        NSInteger statusCode = localOperation.response.statusCode;
        
        //5. If the response is successful (status code 200) create a model of the response
        //   values
        if (statusCode == HTTPCode200OK)
        {
            if ([self.delegate respondsToSelector:@selector(requestFinished:)])
            {
                
                NSDictionary *respDict = (NSDictionary*) responseObject;

                ResponseModel *respMod = [[ResponseModel alloc] initWithResponse:respDict];
                
                [self.delegate requestFinished:respMod];
            }
        }
        else
        {
    
            NSDictionary *errorDescr = [NSDictionary dictionaryWithObjectsAndKeys:[HTTPCodes descriptionForCode:statusCode],@"description",nil];
            
            [self.delegate requestFinishedWithError:[NSError errorWithDomain:@"fuse-universal.com" code:statusCode userInfo:errorDescr]];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate requestFinishedWithError:error];
    }];
}



@end
