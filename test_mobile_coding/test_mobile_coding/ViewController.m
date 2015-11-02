//
//  ViewController.m
//  test_mobile_coding
//
//  Created by Michele Verani on 30/10/15.
//  Copyright © 2015 mikydevelop. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     // Do any additional setup after loading the view, typically from a nib.
    //[self.]
    
    [self changeTextFieldColorWithColor:[UIColor whiteColor]];
   
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    //4.1 Validate length of text is more then 1
    if ([textField.text length]>1)
    {
        //4. On keyboard return make a network request to validate the company name using
        //   the following API: GET https://[COMPANY NAME].fusion-universal.com/api/v1/
        //   company.json
        
        _requestThread = [[NSThread alloc] initWithTarget:self selector:@selector(createValidationRequest:) object:textField.text];
        [_requestThread start];
        
        [textField resignFirstResponder];
    }
    else
    {
        if ([textField.text length] == 0)
        {
            [textField resignFirstResponder];
        }
        else
        {
            [self changeTextFieldColorWithColor:[UIColor redColor]];
        }
    
    }
    
    return YES;
}


//6. On textfield retry reset the textfield colour to white 
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self changeTextFieldColorWithColor:[UIColor whiteColor]];
    
    return YES;
}

-(BOOL) resignFirstResponder
{
    return YES;
}

#pragma mark - Request
-(void) createValidationRequest:(NSString *)companyName
{
    RequestManager *req = [[RequestManager alloc] initWithCompanyName:companyName];
    req.delegate = (id)self;
    
    [req startSending];
}

#pragma mark - UITextField ChangeTextColor

// 5.1 Make the textfield green of status 200 otherwise make it red
-(void)changeTextFieldColorWithColor:(UIColor*)txtColor
{
    self.companyNameTxtField.backgroundColor = txtColor;

}

// 5.2 Replace the textfield text with the response key “name” value from your model
-(void) changeTextWithName:(NSString*)companyName
{
    self.companyNameTxtField.text = companyName;
}

#pragma mark - RequestManagerDelegate

-(void) requestFinished:(ResponseModel*) responseModel
{
    _respModel = responseModel;
    
    BOOL isSuccessKey = NO;
    
    BOOL successKeyValue = FALSE;
    
    if ([[[_respModel getFuseResponse] allKeys] containsObject:success])
    {
        isSuccessKey = YES;
        
        successKeyValue = [[_respModel getFuseResponse][success] boolValue];
    }
       
    //check success value
    if (isSuccessKey)
    {
        if (!successKeyValue)
        {
            [self performSelectorOnMainThread:@selector(changeTextFieldColorWithColor:) withObject:[UIColor redColor] waitUntilDone:NO];
        }
    }
    else
    {
        if([[[_respModel getFuseResponse] allKeys] containsObject:name])
        {
            [self performSelectorOnMainThread:@selector(changeTextWithName:) withObject:[_respModel getFuseResponse][name] waitUntilDone:NO];
            
            [self performSelectorOnMainThread:@selector(changeTextFieldColorWithColor:) withObject:[UIColor greenColor] waitUntilDone:NO];
        }
        else
        {
            [self performSelectorOnMainThread:@selector(changeTextFieldColorWithColor:) withObject:[UIColor redColor] waitUntilDone:YES];
        }
    }
    
}

-(void) requestFinishedWithError:(NSError *) error
{
    [self performSelectorOnMainThread:@selector(changeTextFieldColorWithColor:) withObject:[UIColor redColor] waitUntilDone:NO];
}

-(void) requestFinishedWithArray:(NSArray *)responseDictArray
{
    [self performSelectorOnMainThread:@selector(changeTextFieldColorWithColor:) withObject:[UIColor redColor] waitUntilDone:NO];
}

@end
