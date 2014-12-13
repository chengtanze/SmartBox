//
//  CarListTableViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/24.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SELECTSTATE
{
    enum_state_unDefine = 0,
    enum_state_openState,
    enum_state_closeState,
    enum_state_openNewcloseOldState
}SelectState;

@interface CarListTableViewController : UITableViewController

@end
