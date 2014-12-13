//
//  MapClientViewController.h
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/26.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

#import <MapKit/MKAnnotation.h>
@interface MapClientViewController : UIViewController<MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *MapClient;
@property (weak, nonatomic) IBOutlet UITextField *queryText;
- (IBAction)queryBtn:(id)sender;
@property(strong, nonatomic) CLLocationManager * locationManager;

@end
