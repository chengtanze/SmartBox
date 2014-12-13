//
//  CarTypeTableViewCell.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/3.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLable;
@property (weak, nonatomic) IBOutlet UIButton *choiceBtn;
- (IBAction)choiceBtnClick:(id)sender;

@property(nonatomic, strong) UIImage * backGroundUpImage;
@property(nonatomic, strong) UIImage * backGroundDownImage;
@property(nonatomic)    BOOL isPress;

-(void)setRadioButtonState:(BOOL)state;
@end
