//
//  AboutUsViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/4.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "AboutUsViewController.h"




@interface AboutUsViewController ()
{
    NSArray * itemArray;
}
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSDictionary *itemDic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"5-SMART-BOX-about-feedback.png", @"image", @"检查更新", @"name", nil];
    NSDictionary *itemDic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"5-SMART-BOX-about-update.png", @"image", @"意见反馈", @"name", nil];
    itemArray = [[NSArray alloc]initWithObjects:itemDic1, itemDic2, nil];

    self.ItemTableView.delegate = self;
    self.ItemTableView.dataSource = self;
    self.ItemTableView.sectionHeaderHeight = 1;
    self.ItemTableView.sectionFooterHeight = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//设置整体tableview头部,尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [itemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingItem"];
    
    if (cell != nil) {
        NSDictionary * dic = itemArray[indexPath.section];
        cell.textLabel.text = dic[@"name"];
        cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"didSelectRowAtIndexPath :%ld", indexPath.section);
    switch (indexPath.section) {
        case 0:
        {
            UIAlertView * alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前版本已是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alertview show];
            
        }
            break;
        case 1:
        {
             //这里通过获取mainStoryboard来加载界面配置。如果用alloc创建就不能和Storyboard的配置界面对应。
            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"FeedBackViewController"];
            
            [self.navigationController pushViewController:info animated:YES];
            
        }
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
