//
//  PassWordViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/19.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonInfoViewController.h"

@interface PassWordViewController : UIViewController<UITextFieldDelegate>
{
    
}

@property (retain, nonatomic) PesonInfo * personinfo;
@property (weak, nonatomic) IBOutlet UITextField *oldPassWord;
@property (weak, nonatomic) IBOutlet UITextField *newsPassWord;

- (IBAction)changedPassWord:(id)sender;
- (IBAction)Save:(id)sender;

@end
