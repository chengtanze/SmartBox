//
//  AboutUsViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/4.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController<UITableViewDataSource, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ItemTableView;

@end
