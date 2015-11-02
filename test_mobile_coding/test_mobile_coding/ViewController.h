//
//  ViewController.h
//  test_mobile_coding
//
//  Created by Michele Verani on 30/10/15.
//  Copyright © 2015 mikydevelop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestManager.h"
#import "ResponseModel.h"

@interface ViewController : UIViewController<UITextFieldDelegate, RequestManagerDelegate>
{
    NSThread *_requestThread;
    
    ResponseModel *_respModel;
    
    
}

@property (nonatomic, weak) IBOutlet UITextField *companyNameTxtField;


@end

