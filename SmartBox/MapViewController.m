//
//  MapViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/26.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
{
    CLLocation * currLocation;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    
    
    
    //currLocation = [[CLLocation alloc]initWithLatitude:39.84671 longitude:116.35405];
//    if (self.locationManager lo) {
//        <#statements#>
//    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.locationManager startUpdatingLocation];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.locationManager stopUpdatingLocation];
}

//core location委托方法，用于实现位置的更新
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateLocations");
    currLocation = [locations lastObject];
    //currLocation = [[CLLocation alloc]initWithLatitude:0  longitude:0];
    
    self.lngText.text = [NSString stringWithFormat:@"%3.5f", currLocation.coordinate.longitude];
    self.latText.text = [NSString stringWithFormat:@"%3.5f", currLocation.coordinate.latitude];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error :%@", error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getPosInfo:(id)sender {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark * placeMark = placemarks[0];
            NSDictionary * addressDictionary = placeMark.addressDictionary;
            
            NSString * address = [addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
            NSString * state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
            NSString * city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
            
            self.psoInfo.text = [NSString stringWithFormat:@"%@,%@,%@",state , city , address ];//;
            
        }
    }];
}
- (IBAction)getAddrInfo:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:@"深圳市世界之窗" completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"查询记录数:%ld", placemarks.count);
        
        if (placemarks.count > 0) {
            CLPlacemark * placemark = [placemarks objectAtIndex:0];
            
            NSLog(@"%@", placemark.country);
            
            CLLocationCoordinate2D Coordinate = placemark.location.coordinate;
            NSString * strCoordinate = [NSString stringWithFormat:@"经度:%3.5f, 纬度:%3.5f\n", Coordinate.longitude, Coordinate.latitude];
            
            NSDictionary * addressDictionay = placemark.addressDictionary;
            NSString * strAddress = [addressDictionay objectForKey:(NSString *)kABPersonAddressStreetKey];
            NSString * strState = [addressDictionay objectForKey:(NSString *)kABPersonAddressStateKey];
            NSString * strCity = [addressDictionay objectForKey:(NSString *)kABPersonAddressCityKey];
            
            NSString * strAddressInfo = [NSString stringWithFormat: @"%@ %@,%@,%@", strCoordinate, strState, strCity, strAddress];
            
            self.addrInfo.text = strAddressInfo;
        }
    }];
}
@end
