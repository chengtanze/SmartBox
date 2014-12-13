//
//  PointTableViewCell.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/11.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "PointTableViewCell.h"


#define POINT_TABLEVIEWCELL_HEIGHT (35.0)

@implementation PointTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.dateLabel.layer.cornerRadius = self.dateLabel.bounds.size.height / 2.0;
    self.dateLabel.layer.masksToBounds = YES;
    
    self.arrayCell = [[NSMutableArray alloc]init];
    self.cellHeight = self.bounds.size.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)createTableViewCell{
    [self setCellDate];
    
    NSInteger nCount = self.arrayCell.count;
    for (NSInteger index = 0; index < nCount; index++) {
        UIView * itemView = [self createInfoItem:index];
        
        [self addSubview:itemView];
        
        //self.cellHeight += POINT_TABLEVIEWCELL_HEIGHT;
    }
    
    self.cellHeight = self.dateLabel.frame.size.height + POINT_TABLEVIEWCELL_HEIGHT * nCount;
    CGRect rectOld = self.frame;
    rectOld.size.height = self.cellHeight;
    self.frame = rectOld;
    
    CGRect rectLine = CGRectMake(15, self.dateLabel.frame.size.height, 2, POINT_TABLEVIEWCELL_HEIGHT * nCount);
    UILabel * line = [[UILabel alloc]initWithFrame:rectLine];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    
}

-(void)addNewItem:(NSString *)iamgeName textLabel:(NSString *)text{
    NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:iamgeName, @"imageName", text, @"Text", nil];
    [self.arrayCell addObject:dic];
}

-(UIView *)createInfoItem:(NSInteger)index{
    //NSInteger nCount = self.arrayCell.count;
    
    NSString *imageName = [self.arrayCell valueForKeyPath:@"imageName"][index];
    NSString *text      = [self.arrayCell valueForKeyPath:@"Text"][index];
    
    CGRect rect = CGRectMake(20, self.dateLabel.frame.size.height + index * POINT_TABLEVIEWCELL_HEIGHT, self.bounds.size.width, POINT_TABLEVIEWCELL_HEIGHT);
    UIView * backView = [[UIView alloc]initWithFrame:rect];
    
    CGRect rectImageView = CGRectMake(0, 0, 30, 30);
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:rectImageView];
    UIImage * iamge = [UIImage imageNamed:imageName];
    imageView.image = iamge;
    [backView addSubview:imageView];

    CGRect rectText = CGRectMake(35, 0, backView.bounds.size.width - 55, POINT_TABLEVIEWCELL_HEIGHT);
    UILabel * lebel = [[UILabel alloc]initWithFrame:rectText];
    lebel.text = text;
    
    UIFont *oldFont = [lebel font];
    UIFont * font = [UIFont fontWithName:oldFont.familyName size:13.0];
    [lebel setFont:font];
    [backView addSubview:lebel];
    
    
    
    return backView;
}

-(void)setCellDate{
    self.dateLabel.text = self.date;
}

@end
