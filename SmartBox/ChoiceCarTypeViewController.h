//
//  ChoiceCarTypeViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/3.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceCarTypeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *carTypeTableView;

@end
