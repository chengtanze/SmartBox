//
//  MoreViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/5.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
{
    NSArray * itemArray;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更多";
    
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
  
    [self.settingButton addGestureRecognizer:singleRecognizer];

    self.itemTableView.delegate = self;
    self.itemTableView.dataSource = self;
    
    [self initItemData];
}

-(void)initItemData{
    NSDictionary *itemPosOfCar = [NSDictionary dictionaryWithObjectsAndKeys:@"5-SMART-BOX-more-acwz", @"iamge", @"爱车位置", @"ItemName",@"深圳市宝安区西乡港龙城停车场", @"ItenDetail",nil];
    
    NSDictionary *itemOneKye = [NSDictionary dictionaryWithObjectsAndKeys:@"Insurance", @"iamge", @"一键保险", @"ItemName",@"直接拨打保险公司电话，快速报险", @"ItenDetail",nil];
    
    NSDictionary *itemHumanRescue = [NSDictionary dictionaryWithObjectsAndKeys:@"5-SMART-BOX-more-rsjy", @"iamge", @"人伤救援", @"ItemName",@"手动请求，将调配附近的120前来救援", @"ItenDetail",nil];
    
    NSDictionary *itemRoadRescue = [NSDictionary dictionaryWithObjectsAndKeys:@"5-SMART-BOX-more-dljy", @"iamge", @"道路救援", @"ItemName",@"拖车、无油、抛锚、爆胎、拖车、泵电...", @"ItenDetail",nil];
    
    NSDictionary *itemWarning = [NSDictionary dictionaryWithObjectsAndKeys:@"5-SMART-BOX-more-qdyj", @"iamge", @"爱车位置", @"ItemName",@"车辆启动将预警提醒", @"ItenDetail",nil];
    
    
    itemArray = [NSArray arrayWithObjects:itemPosOfCar, itemOneKye, itemHumanRescue, itemRoadRescue, itemWarning, nil];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    [self performSegueWithIdentifier:@"PushSettingCtrl" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//根据NSIndexPath 设置指定行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (cell != nil) {
        cell.textLabel.text = itemArray[indexPath.row][@"ItemName"];
        cell.imageView.image = [UIImage imageNamed:itemArray[indexPath.row][@"iamge"]];
        cell.detailTextLabel.text = itemArray[indexPath.row][@"ItenDetail"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath :%ld", indexPath.row);
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"立即拨打 95590" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.delegate = self;
            [alert show];
        }
            break;
        case 2:
        {
            
            [self performSegueWithIdentifier:@"PushHumanRescue" sender:self];
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        default:
        {
            
        }
            break;
    }
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"clickedButtonAtIndex :%ld", buttonIndex);
    if (buttonIndex == UIALERT_MB_OK) {
        //拨打电话
        
        NSString * phoneNumber = @"13691790130";
        
        [self telephoneOff:phoneNumber];
        
    }else{
        
    }
}

-(BOOL)telephoneOff:(NSString *)number{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",number];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
    return YES;
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
