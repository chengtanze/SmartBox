//
//  MoreViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/5.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIALERT_MB_OK 1
#define UIALERT_MB_CANCLE 0

@interface MoreViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *settingButton;
@property (weak, nonatomic) IBOutlet UITableView *itemTableView;

@end
