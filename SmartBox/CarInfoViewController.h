//
//  CarInfoViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/24.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInfoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *carInfoTableView;
- (IBAction)saveData:(id)sender;

@end
