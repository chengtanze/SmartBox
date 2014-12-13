//
//  PersonInfoViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/17.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BindPhoneViewController.h"

@interface PesonInfo : NSObject

@property (strong, nonatomic) NSString * userID;
@property (strong, nonatomic) NSString * userNickName;
@property (strong, nonatomic) NSString * userPhone;
@property (strong, nonatomic) NSString * password;
@property (strong, nonatomic) NSString * sex;

@end



@interface PersonInfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, BindPhoneDelegate>

@property (retain, nonatomic)PesonInfo * info;
@property (weak, nonatomic) IBOutlet UIImageView *UserHeader;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@end
