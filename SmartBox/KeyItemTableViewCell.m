//
//  KeyItemTableViewCell.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/25.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "KeyItemTableViewCell.h"

@implementation KeyItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //static BOOL init = NO;
    //if (!init) {
    //    init = YES;
        self.upImage = [UIImage imageNamed:@"UpAccessory.png"];
        self.downImage = [UIImage imageNamed:@"DownAccessory.png"];
    //}
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    NSLog(@"setSelected");
    // Configure the view for the selected state
}

-(void)changeBackGroudImage:(BOOL)down
{
    if (down) {
        self.keyImage.image = self.downImage;
    }
    else{
        self.keyImage.image = self.upImage;
    }
}

@end
