//
//  PersonInfoViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/17.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "BindPhoneViewController.h"
#import "PassWordViewController.h"
#import "EditNickNameViewController.h"
@interface PersonInfo

@end ;
@implementation PesonInfo

@end



@interface PersonInfoViewController ()
{
    NSMutableArray * arrayInfo;
    
}
@end

@implementation PersonInfoViewController

-(void)loadView
{
    [super loadView];
    
    self.title = @"个人信息";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initUserItem];
    [self initUserInfo];
    // Do any additional setup after loading the view.

//    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(click:)];
//    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    // [super viewDidLayoutSubviews];
    //在viewDidLoad 中修改tableview的frame无效，要在xid或是storyboard加载完后再去修改。
    //UIView * view = [self.view viewWithTag:100];
    
    //self.UserHeader.center = view.center;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
    
    
}

-(void)initUserInfo
{
    UIImage * user = [UIImage imageNamed:@"5-SMART-BOX-more-user.png"];
    self.UserHeader.image = user;
    
    self.infoTableView.sectionHeaderHeight = 3;
    self.infoTableView.sectionFooterHeight = 3;
    
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
}

-(void)initUserItem
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"PersonInfo" ofType:@"plist"];
    arrayInfo = [[NSMutableArray alloc]initWithContentsOfFile:strPath];
    
    self.info = [[PesonInfo alloc]init];
    self.info.userID = @"12422";
    self.info.userNickName = @"hype";
    self.info.userPhone = @"13691790130";
    self.info.sex = @"男";
    self.info.password = @"123456";

    arrayInfo[0][@"Content"] = self.info.userID;
    arrayInfo[1][@"Content"] = self.info.userPhone;
    arrayInfo[2][@"Content"] = self.info.sex;
    arrayInfo[3][@"Content"] = self.info.userNickName;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingItem"];
    
    if (cell != nil) {
        
        
        NSDictionary * dict = arrayInfo[indexPath.section];
        //NSDictionary * dict = [[NSDictionary alloc]initWithDictionary:arrayInfo[indexPath.section]];
        
        NSString * name = dict[@"Name"];
        NSString * content = dict[@"Content"];
        BOOL type = dict[@"accessoryType"];
        
        NSLog(@"cellForRowAtIndexPath %d", type);
        cell.textLabel.text = name;
        cell.detailTextLabel.text = content;

        if (indexPath.section != 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath :%ld", indexPath.section);
    
    switch (indexPath.section) {
        case 0:
            break;
        case 1:
        {
            //这里通过获取mainStoryboard来加载界面配置。如果用alloc创建就不能和Storyboard的配置界面对应。
            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            
            //通过StoryboardID 来加载配置界面。如果没有设置就异常
            BindPhoneViewController * info = (BindPhoneViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"BindPhoneViewController"];
            
            info.Delegate = self;
            [self.navigationController pushViewController:info animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            //这里通过获取mainStoryboard来加载界面配置。如果用alloc创建就不能和Storyboard的配置界面对应。
            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            
            //通过StoryboardID 来加载配置界面。如果没有设置就异常
            EditNickNameViewController * info = (EditNickNameViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"EditNickNameViewController"];
            
            //info.Delegate = self;
            [self.navigationController pushViewController:info animated:YES];
            
        }
            break;
        case 4:
        {
            //这里通过获取mainStoryboard来加载界面配置。如果用alloc创建就不能和Storyboard的配置界面对应。
            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PassWordViewController * info = (PassWordViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"PassWordViewController"];
            
            info.personinfo = self.info;
            [self.navigationController pushViewController:info animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)getBindPhoneNO:(NSString *)phoneNO
{
    NSLog(@"getBindPhoneNO :%@", phoneNO);
    
    
    NSDictionary * dict = arrayInfo[1];
    //dict[@"Content"] = phoneNO;
    arrayInfo[1][@"Content"] = phoneNO;
    
    NSString * content = dict[@"Content"];
    NSLog(@"getBindPhoneNO Edit:%@", content);
    
    //局部刷新
    NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:1];
    [[self infoTableView] reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
    //NSArray *array = @[];
    
    //[self infoTableView] reloadRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:<#(UITableViewRowAnimation)#>
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
