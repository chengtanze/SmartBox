//
//  CarTypeTableViewCell.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/3.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "CarTypeTableViewCell.h"
#import "RadioButton.h"
@implementation CarTypeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.isPress = NO;
    self.backGroundUpImage = [UIImage imageNamed:@"5-SMART-BOX-car-checkbox01.png"];
    self.backGroundDownImage = [UIImage imageNamed:@"5-SMART-BOX-car-checkbox02.png"];
    
//    RadioButton * radioBtn = [[RadioButton alloc]initWithGroupId:@"first_groud" index:0 clickDownImage:[UIImage imageNamed:@"5-SMART-BOX-car-checkbox02.png"] clickUpImage:[UIImage imageNamed:@"5-SMART-BOX-car-checkbox01.png"]];
//    
//    radioBtn.frame =  CGRectMake(self.frame.size.width - 40, 15, 50, 50);
//    
//    [RadioButton addObserverForGroupId:@"first group" observer:self];
//    [self addSubview:radioBtn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRadioButtonState:(BOOL)state
{
    if (state) {
        [self.choiceBtn setImage:self.backGroundUpImage forState:UIControlStateNormal];
    }
    else{
        [self.choiceBtn setImage:self.backGroundDownImage forState:UIControlStateNormal];
    }
}

- (IBAction)choiceBtnClick:(id)sender {
    
}
@end
