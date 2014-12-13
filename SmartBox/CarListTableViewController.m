//
//  CarListTableViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/24.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "CarListTableViewController.h"
#import "KeyItemTableViewCell.h"
#import "ChoiceCarTypeViewController.h"
@interface CarListTableViewController ()

{
    BOOL isOpen;
    NSDictionary *carArray;
    NSIndexPath * selectIndexPath;
}
@end

@implementation CarListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择车系";
    
    isOpen = NO;
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"carList" ofType:@"plist"];
    carArray = [[NSDictionary alloc]initWithContentsOfFile:strPath];
    selectIndexPath = nil;
    //selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    NSArray * carList = carArray.allKeys;
//    NSArray * dic = [carArray objectForKey:carList[0]];
//    NSString * str = dic[0];

   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return carArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"numberOfRowsInSection :%ld", section);
    // Return the number of rows in the section.
    if (isOpen == YES) {
        if (section == selectIndexPath.section) {
            NSArray * dic = [carArray objectForKey:carArray.allKeys[section]];
            NSLog(@"number of row :%ld", dic.count + 1);
            return dic.count + 1;
        }
    }

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"carInfoItem"];
    
    
    NSLog(@"cellForRowAtIndexPath section:%ld, row:%ld", indexPath.section, indexPath.row);
    if (isOpen == YES) {
        if (indexPath.row == 0) {
            
            KeyItemTableViewCell * cell = [[KeyItemTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"carInfoItem"];
            
            NSArray * array = carArray.allKeys;
            //cell.textLabel.text = array[indexPath.section];
            cell.keyTextLabel.text = array[indexPath.section];
            return cell;
        }
        else{
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"carInfoItem"];
            
            NSArray * keyArray = carArray.allKeys;
            NSString * key = keyArray[indexPath.section];
            NSArray * array = [carArray objectForKey:key];
            
            cell.textLabel.text = array[indexPath.row - 1];
            cell.detailTextLabel.text = @"共3款";
            cell.imageView.image = [UIImage imageNamed:@"IMG_0410"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
    else{
        KeyItemTableViewCell * cell = [[KeyItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"carInfoItem"];
        NSArray * array = carArray.allKeys;
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CarInfoKeyItem" owner:self options:nil] objectAtIndex:0];

        
        cell.keyTextLabel.text = array[indexPath.section];
        cell.keyImage.image = [UIImage imageNamed:@"DownAccessory.png"];
        return cell;
    }

    //cell.detailTextLabel.text = array
    // Configure the cell...
    
    return nil;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击的是key 用于展开
    if (indexPath.row == 0) {
        SelectState state = [self getTableViewState:indexPath];
        
        NSLog(@"didSelectRowAtIndexPath :%ld state :%ld", indexPath.section, (NSInteger)state);
        
        [self modifyTableView:state indexPath:indexPath];
    }
    else//点击的是 展开列表
    {
        UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"ChoiceCarTypeViewController"];
        
        [self.navigationController pushViewController:info animated:YES];
    }
}

-(SelectState)getTableViewState:(NSIndexPath *)indexPath
{
    //和上一次选中的是同一个 需要关闭
    if ([selectIndexPath isEqual:indexPath] == YES) {
        isOpen = NO;
        return enum_state_closeState;
    }
    else{
        isOpen = YES;
        
        //上一次无选中状态 需要打开
        if (selectIndexPath == nil) {
            return enum_state_openState;
        }
        else//上一次有选中状态和当前不一样 需要关闭之前，打开现在的列表
        {
            return enum_state_openNewcloseOldState;
        }
    }

    return enum_state_unDefine;
}

-(void)modifyTableView:(SelectState)state indexPath:(NSIndexPath *)indexPath
{
    NSArray * keyArray = carArray.allKeys;
    NSString * key = keyArray[indexPath.section];
    NSArray * array = [carArray objectForKey:key];
    
    //点击某分类分3个情况处理
    // 1 enum_state_openState 之前没有展开直接展开即可（像里面添加行）
    // 2 enum_state_closeState 某类表以展开关闭即可 （删除行）
    // 3 enum_state_openNewcloseOldState 之前有展开选中另一个选项 需要关闭上个选项，展开当前选项
    if (enum_state_openNewcloseOldState == state) {
        
        isOpen = NO;
        state = enum_state_closeState;
        NSArray * array1 = [carArray objectForKey:keyArray[selectIndexPath.section]];
        NSLog(@"curr :%ld, pre :%ld", indexPath.section, selectIndexPath.section);
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i < array1.count + 1; i++) {
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:selectIndexPath.section];
            [rowToInsert addObject:indexPathToInsert];
        }
        //调用完deleteRowsAtIndexPaths 后会立即调用numberOfRowsInSection重新获取section的个数。
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        KeyItemTableViewCell *cell = (KeyItemTableViewCell *)[self.tableView cellForRowAtIndexPath:selectIndexPath];
        [cell changeBackGroudImage:YES];

        
        selectIndexPath = indexPath;
        
        isOpen = YES;

        NSMutableArray* rowToInsert1 = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i < array.count + 1; i++) {
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:selectIndexPath.section];
            [rowToInsert1 addObject:indexPathToInsert];
        }
        
        
        //调用完insertRowsAtIndexPaths 后会立即调用numberOfRowsInSection重新获取section的个数之后会调用
        //tableView: cellForRowAtIndexPath:插入新增加的row
        [self.tableView insertRowsAtIndexPaths:rowToInsert1 withRowAnimation:UITableViewRowAnimationTop];
        
        KeyItemTableViewCell *cell2 = (KeyItemTableViewCell *)[self.tableView cellForRowAtIndexPath:selectIndexPath];
        [cell2 changeBackGroudImage:NO];
        
    }
    else if(enum_state_unDefine == state){
        NSLog(@"UNDEIF ERROR!");
    }
    else
    {
        [self.tableView beginUpdates];
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i < array.count + 1; i++) {
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [rowToInsert addObject:indexPathToInsert];
        }
        
        if (enum_state_openState == state){
            selectIndexPath = indexPath;
            
            NSLog(@"selectIndexPath %@", selectIndexPath);
            KeyItemTableViewCell *cell = (KeyItemTableViewCell *)[self.tableView cellForRowAtIndexPath:selectIndexPath];
            [cell changeBackGroudImage:NO];
            
            [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];

        }else if (enum_state_closeState == state){
            
            KeyItemTableViewCell *cell = (KeyItemTableViewCell *)[self.tableView cellForRowAtIndexPath:selectIndexPath];
            [cell changeBackGroudImage:YES];
            
            selectIndexPath = nil;
            [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
            
        }
        
        [self.tableView endUpdates];
        
        if (isOpen)
            [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
