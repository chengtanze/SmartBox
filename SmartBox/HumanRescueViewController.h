//
//  HumanRescueViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/9.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//



#import <UIKit/UIKit.h>


@interface RescueItem : NSObject

@property(nonatomic) NSString * name;
@property(nonatomic) NSString * content;

@end

@interface HumanRescueViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *rescueTableView;
@property (weak, nonatomic) IBOutlet UIButton *callRescue;

@end
