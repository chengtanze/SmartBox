//
//  PointViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/10.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@end
