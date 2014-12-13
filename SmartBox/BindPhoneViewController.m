//
//  BindPhoneViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/17.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "BindPhoneViewController.h"

@interface BindPhoneViewController ()
{
    NSString * phoneNO;
}

@end

//@synthesize  Delegate;

@implementation BindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textFieldText.delegate = self;
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textfieldshouldreturn");
    [textField resignFirstResponder];
    
    phoneNO =   [[NSString alloc]initWithFormat:@"%@",textField.text ];
    return YES;
}

- (IBAction)getAuthCode:(id)sender
{
    [[self textFieldText] resignFirstResponder];
    phoneNO =   [[NSString alloc]initWithFormat:@"%@",[self textFieldText].text ];
    
    NSLog(@"getAuthCode");
    
    UIView * authCode = [self.view viewWithTag:100];
    
    if (authCode.hidden == NO) {
        //authCode.hidden = NO;
        [self ShowAuthCodeOrBindView:100];
        
        self.senderPhoneNO.text = phoneNO;
        
        [[self Delegate] getBindPhoneNO:phoneNO];
    }
}

- (IBAction)bind:(id)sender {
}

-(void)ShowAuthCodeOrBindView:(NSInteger)nIndex
{
    UIView * show = nil;
    UIView * hide = nil;
    
    if (100 == nIndex) {
        show = [self.view viewWithTag:100];
        hide = [self.view viewWithTag:101];
        show.hidden = YES;
        hide.hidden = NO;
    }else if(101 == nIndex)
    {
        show = [self.view viewWithTag:101];
        hide = [self.view viewWithTag:100];
        show.hidden = YES;
        hide.hidden = NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
