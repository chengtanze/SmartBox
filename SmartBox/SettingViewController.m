//
//  SettingViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/14.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonInfoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MapViewController.h"
#import "MapClientViewController.h"
#import "AboutUsViewController.h"
#import "PointViewController.h"


@interface SettingViewController ()
{
    NSArray * arraySettingItem;
    
    NSMutableDictionary * dicSettingItem;
}
@end

@implementation SettingViewController


-(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)loadView
{
    [super loadView];
    self.title = @"设置";

    

    
    //设置navibar 的背景图片，还没找到怎么修改背景颜色
    //UIImage * image = [self imageWithColor:[UIColor blueColor]];
    //[self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault ];
    
    CGRect rect, rect2;
    rect = [[UIApplication sharedApplication]statusBarFrame];
    rect2 = self.navigationController.navigationBar.frame;
    NSLog(@"statusBarFrame height%f navigationBar height%f", rect.size.height, rect2.size.height);
    NSLog(@"mainScreen height%f", [UIScreen mainScreen].bounds.size.height);
    
}

-(void)initSettingItem
{
    
    
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"SettingItem" ofType:@"plist"];
    arraySettingItem = [[NSArray alloc]initWithContentsOfFile:path];
    
    
    dicSettingItem  = [[NSMutableDictionary alloc]initWithCapacity:5];
    NSLog(@"arraySettingItem count:%ld", arraySettingItem.count);
    for (NSDictionary * dict in arraySettingItem) {
        NSString * name = dict[@"Name"];
        NSString * icon = dict[@"icon"];
        
    
        NSLog(@"name :%@, icon :%@", name, icon);
    }
    
    //dicSettingItem = [NSDictionary dictionaryWithObjectsAndKeys:@"head.jpg", @"personalInfo", @"car.jpg", @"carInfo",@"point.jpg", @"point",@"about.jpg", @"about", nil];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    self.settingTableView.rowHeight = 50;
 
    //如果为YES 自动设置tableview 的坐标往下调64点（状态栏的高度）避免遮住状态栏
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self initSettingItem];
    
    
}

- (void)viewDidLayoutSubviews
{
   // [super viewDidLayoutSubviews];
    //在viewDidLoad 中修改tableview的frame无效，要在xid或是storyboard加载完后再去修改。
    CGRect rect = CGRectMake(0, 0+100, [UIScreen mainScreen].bounds.size.width, 50 * 4);
    self.settingTableView.frame = rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arraySettingItem.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingItem"];
    
    if (cell != nil) {
        NSDictionary * dict =  [[NSDictionary alloc]initWithDictionary:arraySettingItem[indexPath.row]];
        
        NSString * name = dict[@"Name"];
        NSString * icon = dict[@"icon"];
        //NSLog(@"name :%@, icon :%@", name, icon);
        
        cell.textLabel.text = name;
        cell.imageView.image = [UIImage imageNamed:icon];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}



// 判断是否支持某种多媒体类型：拍照，视频
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes =[UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL*stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
        
    }];
    return result;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath :%ld", indexPath.row);
    
    switch (indexPath.row) {
        case 0:
        {
            //这里通过获取mainStoryboard来加载界面配置。如果用alloc创建就不能和Storyboard的配置界面对应。
            ////PersonInfoViewController * info = [[PersonInfoViewController alloc]init];
            
//            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"PersonInfoViewController"];
//            
//            [self.navigationController pushViewController:info animated:YES];
            
            [self performSegueWithIdentifier:@"PushPersonCtrl" sender:self];

        }
            break;
        case 1:
        {
//            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"CarInfoViewController"];
//            
//            [self.navigationController pushViewController:info animated:YES];
            
            [self performSegueWithIdentifier:@"PushCarInfoCtrl" sender:self];
 
        }
            break;
        case 2:
        {
//            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            //UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"MapViewController"];
//            UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
//            
//            [self.navigationController pushViewController:info animated:YES];
            
            [self performSegueWithIdentifier:@"PushPointCtrl" sender:self];
        }
            break;
        case 3:
        {
            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
            
            [self.navigationController pushViewController:info animated:YES];
        }
            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
