//
//  CarInfoViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/24.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "CarInfoViewController.h"
#import "CarListTableViewController.h"

@interface CarInfoViewController ()
{
    NSMutableDictionary * itemArray;
}
@end

@implementation CarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carInfoTableView.sectionHeaderHeight = 5;
    self.carInfoTableView.sectionFooterHeight = 5;
    
    itemArray = [[NSMutableDictionary alloc]initWithCapacity:5];
    [itemArray setValue:@"宝马" forKey:@"车型"];
    [itemArray setValue:@"粤B123456" forKey:@"车牌号"];
    [itemArray setValue:@"2014-1-1" forKey:@"购车日期"];
    [itemArray setValue:@"2014-1-1" forKey:@"投保日期"];
    
    
//    itemArray = [[NSMutableArray alloc]initWithObjectsAndKeys:@"宝马", @"车型",@"粤B123456",@"车牌号" ,@"2014-1-1",@"购车日期", @"2014-1-1",@"投保日期",nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initCarInfoItem
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveData:(id)sender {
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"carInfoItem"];
    
    if (cell != nil) {
        
    }
    
    cell.textLabel.text =  [itemArray allKeys][indexPath.section];
    cell.detailTextLabel.text = [itemArray valueForKey:cell.textLabel.text];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath :%ld", indexPath.section);
    if (indexPath.section == 2) {
        //这里通过获取mainStoryboard来加载界面配置。如果用alloc创建就不能和Storyboard的配置界面对应。
        UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        //通过StoryboardID 来加载配置界面。如果没有设置就异常
        CarListTableViewController * info = (CarListTableViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"CarListTableViewController"];
        
        //info.Delegate = self;
        [self.navigationController pushViewController:info animated:YES];
    }
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




@end
