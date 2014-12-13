//
//  HumanRescueViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/9.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "HumanRescueViewController.h"


@implementation RescueItem



@end

@interface HumanRescueViewController ()
{
    NSArray * rescueArray;
}
@end

@implementation HumanRescueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViewData{
    
    //如果为YES 自动设置tableview 的坐标往下调64点（状态栏的高度）避免遮住状态栏
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.rescueTableView.delegate = self;
    self.rescueTableView.dataSource = self;
//
    self.rescueTableView.sectionHeaderHeight = 1;
    self.rescueTableView.sectionFooterHeight = 1;
    
    RescueItem * item0 = [[RescueItem alloc]init];
    item0.name = @"车牌号";
    item0.content = @"粤B12345";

    RescueItem * item1 = [[RescueItem alloc]init];
    item1.name = @"联系电话";
    item1.content = @"1380013800";
    
    RescueItem * item2 = [[RescueItem alloc]init];
    item2.name = @"紧急联系电话";
    item2.content = @"1380013800";
    
    RescueItem * item3 = [[RescueItem alloc]init];
    item3.name = @"事发地点";
    item3.content = @"深圳市桃花源";
    
    rescueArray = [NSArray arrayWithObjects:item0, item1, item2, item3, nil];
    
    
}

//根据NSIndexPath 设置指定行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

//设置tableview头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [rescueArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (cell != nil) {
        
        RescueItem * item = rescueArray[indexPath.section];
        cell.textLabel.text = item.name;

        cell.detailTextLabel.text = item.content;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
            [self performSegueWithIdentifier:@"PushContactInfor" sender:self];
            break;
            
        case 2:
            [self performSegueWithIdentifier:@"PushOhterContactInfor" sender:self];
            break;
        case 3:
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
