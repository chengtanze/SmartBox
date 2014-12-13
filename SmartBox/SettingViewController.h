//
//  SettingViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/14.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UITableView *settingTableView;

@end
