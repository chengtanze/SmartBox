//
//  ChoiceCarTypeViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/3.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "ChoiceCarTypeViewController.h"
#import "CarTypeTableViewCell.h"
#import "RadioButton.h"
@interface ChoiceCarTypeViewController ()
{
    NSIndexPath * selectIndexPath;
}
@end

@implementation ChoiceCarTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.carTypeTableView.sectionHeaderHeight = 1;
    self.carTypeTableView.sectionFooterHeight = 1;
    
    
    self.carTypeTableView.delegate = self;
    self.carTypeTableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    // [super viewDidLayoutSubviews];
    //在viewDidLoad 中修改tableview的frame无效，要在xid或是storyboard加载完后再去修改。
    CGRect rect = CGRectMake(0, 24, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.carTypeTableView.frame = rect;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"cellForRowAtIndexPath indexPath:%d-%d", indexPath.section, indexPath.row);
    CarTypeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"carType"];
    
    if (cell != nil) {
        /* 注意1
        不能在这个地方addsubview 因为当屏幕滚动到外边时，会卸载不显示的row，当滚动回来时又会重新加载（从缓存对列中加载而不是重新创建）
        旧的row中含有radioBtn，当重新加载时候又会将radioBtn再一次加入row中，造成内存泄露。
        RadioButton * radioBtn = [[RadioButton alloc]initWithGroupId:@"first_groud" index:indexPath.row clickDownImage:[UIImage imageNamed:@"5-SMART-BOX-car-checkbox02.png"] clickUpImage:[UIImage imageNamed:@"5-SMART-BOX-car-checkbox01.png"]];
        radioBtn.frame =  CGRectMake(cell.frame.size.width - 40, 15, 50, 50);
        [cell addSubview:radioBtn];
         */
        
        /* 注意2
         每个item的数据来源都是通过外部数据源控制，不要再item内部控制（由于缓存机制造成）
         例如cell中的RadioButton是单选按钮，在其内部控制单选。但是在tableview中有缓存机制，某选中的cell划出屏幕的时候被放到缓存中的，并没有释放，该cell中的RadioButton还是选中状态，当再次显示出来的时候造成有几个选中的单选按钮。
         所以这些状态要在外部控制，设计的关键是实现cell和数据的完全分离
         
         */

        if (selectIndexPath.row == indexPath.row) {
            [cell setRadioButtonState:NO];
        }
        else{
            [cell setRadioButtonState:YES];
        }
        cell.textLable.text = @"123";
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"didSelectRowAtIndexPath :%ld", indexPath.section);
    selectIndexPath = indexPath;
    
    [tableView reloadData];
    
    
}

-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString*)groupId{
    NSLog(@"radioButtonSelectedAtIndex index:%ld, group:%@", index, groupId);
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
