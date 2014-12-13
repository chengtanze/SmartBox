//
//  CustomAnn.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/27.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
@interface CustomAnn : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


+(id)CustomAnnForTitle:(CLLocationCoordinate2D)coord Title:(NSString *)title subTitle:(NSString *)subtitle;



@end
