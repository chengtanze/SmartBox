//
//  MapViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/26.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <AddressBook/AddressBook.h>


@interface MapViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *psoInfo;
- (IBAction)getPosInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *latText;
@property (weak, nonatomic) IBOutlet UITextField *lngText;
@property(strong, nonatomic) CLLocationManager * locationManager;

@property (weak, nonatomic) IBOutlet UILabel *addrInfo;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
- (IBAction)getAddrInfo:(id)sender;



@end
