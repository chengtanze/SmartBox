//
//  MapClientViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/26.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "MapClientViewController.h"
#import "CustomAnn.h"
@interface MapClientViewController ()

{
    CLLocation * currLocation;
}

@property(strong, nonatomic) CustomAnn *customAnn;
@end

@implementation MapClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化地图管理器
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    
    //初始化地图view类型
    self.MapClient.mapType = MKMapTypeStandard;
    self.MapClient.delegate = self;
    
//    currLocation = [[CLLocation alloc]initWithLatitude:39.915352 longitude:116.397105];
//    float zoomLevel = 0.02;
//    MKCoordinateRegion region = MKCoordinateRegionMake(currLocation.coordinate,MKCoordinateSpanMake(zoomLevel, zoomLevel));
//    [self.MapClient setRegion:[self.MapClient regionThatFits:region] animated:YES];
    
    
//    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(39.915352,116.397105);
//    float zoomLevel = 0.02;
//    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
//    [self.MapClient setRegion:[self.MapClient regionThatFits:region] animated:YES];
//    
//    self.customAnn = [CustomAnn CustomAnnForTitle:coords Title:@"北京故宫" subTitle:@"欢迎你"];
    
//    [self.MapClient addAnnotation:self.customAnn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"%@", [error description]);
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
    
    //[self showPositionOnMap:currLocation.coordinate Title:@"当前位置" subTitle:@""];

    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(currLocation.coordinate,MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [self.MapClient setRegion:[self.MapClient regionThatFits:region] animated:YES];
    
    NSString * strCoordinate = [NSString stringWithFormat:@"经度:%3.5f, 纬度:%3.5f\n", currLocation.coordinate.longitude, currLocation.coordinate.latitude];
    NSLog(@"%@", strCoordinate);
    //self.lngText.text = [NSString stringWithFormat:@"%3.5f", currLocation.coordinate.longitude];
    //self.latText.text = [NSString stringWithFormat:@"%3.5f", currLocation.coordinate.latitude];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error :%@", error);
}

-(void)showPositionOnMap:(CLLocationCoordinate2D )Coordinate Title:(NSString *)title subTitle:(NSString *)subtitle
{
    CLLocationCoordinate2D coords = Coordinate;
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [self.MapClient setRegion:[self.MapClient regionThatFits:region] animated:YES];
    NSString * strCoordinate = [NSString stringWithFormat:@"经度:%3.5f, 纬度:%3.5f\n", coords.longitude, coords.latitude];
    NSLog(@"showPositionOnMap :%@", strCoordinate);
    self.customAnn = [CustomAnn CustomAnnForTitle:coords Title:title subTitle:subtitle];
    
    [self.MapClient addAnnotation:self.customAnn];
}

-(NSString *)getAddressFromCoordinate:(CLLocationCoordinate2D)coord
{
    CLLocation * location = [[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
    NSString * address = @"";
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark * placeMark = placemarks[0];
            NSDictionary * addressDictionary = placeMark.addressDictionary;
            
            NSString * address = [addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
            NSString * state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
            NSString * city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
            
            address = [NSString stringWithFormat:@"%@,%@,%@",state , city , address ];//;
            
        }
    }];
    
    return address;
}


//-(void)(^geocodeAddress_block)(NSArray *placemarks, NSError *error)
//{
//    
//}

-(CLLocationCoordinate2D)getCoordinate:(NSString *)address
{
    __block CLLocationCoordinate2D coor;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"查询记录数:%ld", placemarks.count);
        
        if (placemarks.count > 0) {
            CLPlacemark * placemark = [placemarks objectAtIndex:0];
            
            NSLog(@"%@", placemark.country);
            
             coor = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);

            NSString * strCoordinate = [NSString stringWithFormat:@"getCoordinate,经度:%3.5f, 纬度:%3.5f\n", coor.longitude, coor.latitude];
            
            NSLog(@"%@",strCoordinate);
            
            NSDictionary * addressDictionay = placemark.addressDictionary;
            NSString * strAddress = [addressDictionay objectForKey:(NSString *)kABPersonAddressStreetKey];
            NSString * strState = [addressDictionay objectForKey:(NSString *)kABPersonAddressStateKey];
            NSString * strCity = [addressDictionay objectForKey:(NSString *)kABPersonAddressCityKey];
            
            NSString * strAddressInfo = [NSString stringWithFormat: @"%@ %@,%@,%@", strCoordinate, strState, strCity, strAddress];
            
            NSLog(@"AddressInfo :%@", strAddressInfo);
            
            [self showPositionOnMap:coor Title:strAddressInfo subTitle:@""];
        }
    }];

    return coor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textfieldshouldreturn");
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)queryBtn:(id)sender {
    [self.queryText resignFirstResponder];
    
    NSString * strAddress = self.queryText.text;
    CLLocationCoordinate2D coordinate = [self getCoordinate:strAddress];
    //[self getAddressFromCoordinate:coordinate];
    //[self showPositionOnMap:coordinate Title:strAddress subTitle:@""];
}
@end
