//
//  CustomAnn.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/27.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "CustomAnn.h"

@implementation CustomAnn

-(id)initWithCustomAnn:(CLLocationCoordinate2D) coord
{
    if (self = [super init]) {
        self.coordinate = coord;
    }
    
    return self;
}

+(id)CustomAnnForTitle:(CLLocationCoordinate2D)coord Title:(NSString *)title subTitle:(NSString *)subtitle
{
    CustomAnn * ann = [[CustomAnn alloc]initWithCustomAnn:coord];
    ann.title = title;
    ann.subtitle = subtitle;
    
    return ann;
}

-(void)dealloc
{
    NSLog(@"dealloc");
}

@end
