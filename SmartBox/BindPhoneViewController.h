//
//  BindPhoneViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/17.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BindPhoneDelegate <NSObject>

@optional
-(void)getBindPhoneNO:(NSString *)phoneNO;

@end


@interface BindPhoneViewController : UIViewController<UITextFieldDelegate>


- (IBAction)getAuthCode:(id)sender;
- (IBAction)bind:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *senderPhoneNO;

@property (weak, nonatomic) IBOutlet UITextField *textFieldText;

@property (weak, nonatomic) IBOutlet UITextField *authCodeFieldText;

@property (retain, nonatomic) id<BindPhoneDelegate> Delegate;

@end
