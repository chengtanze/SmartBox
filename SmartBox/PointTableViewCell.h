//
//  PointTableViewCell.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/11.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;



@property(nonatomic) CGFloat cellHeight;
@property(strong, nonatomic) NSString * date;
@property(strong, nonatomic) NSMutableArray * arrayCell;
-(void)createTableViewCell;
-(void)setCellDate;
-(void)addNewItem:(NSString *)iamgeName textLabel:(NSString *)text;

@end
