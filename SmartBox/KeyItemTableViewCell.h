//
//  KeyItemTableViewCell.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/25.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *keyTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *keyImage;
@property (strong, nonatomic)  UIImage * upImage;
@property (strong, nonatomic)  UIImage * downImage;


-(void)changeBackGroudImage:(BOOL)down;
@end
