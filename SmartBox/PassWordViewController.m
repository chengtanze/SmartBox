//
//  PassWordViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/11/19.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "PassWordViewController.h"

@interface PassWordViewController ()
{
    NSMutableArray *arraySettingItem;
}
@end

@implementation PassWordViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.newsPassWord.delegate = self;
    self.oldPassWord.delegate = self;
    

    
    
    //arraySettingItem[4][@"PassWord"] = @"98765";
    //arraySettingItem[0][@"Content"] = @"98765";
//    
//    NSMutableDictionary * item = [[NSMutableDictionary alloc]init];
//    [item setObject:@"1" forKey:@"Name"];
//    [item setObject:@"2" forKey:@"Content"];
//    [item setObject:@"3" forKey:@"accessoryType"];
//    
//    [item writeToFile:path atomically:YES];
    
//    BOOL ret = [arraySettingItem writeToFile:path atomically:YES];
//    NSLog(@"write :%ld", ret);
    
    
    
    
//    
//    //获取路径对象
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    //获取完整路径
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
//    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc ] init];
//    //设置属性值
//    [dictplist setObject:@"张三" forKey:@"name"];
//    [dictplist setObject:@"李四" forKey:@"name1"];
//    [dictplist setObject:@"王五" forKey:@"name2"];
//    //写入文件
//    [dictplist writeToFile:plistPath atomically:YES];
//    
//    
//    NSMutableArray *arraySettingItem1 = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
//    NSLog(@"%@", arraySettingItem1);

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textfieldshouldreturn");
    [self.oldPassWord resignFirstResponder];
    [self.newsPassWord resignFirstResponder];
    
    return YES;
}

- (IBAction)changedPassWord:(id)sender {
    
    UISwitch * myswitch = (UISwitch *)sender;
    if(myswitch.on == NO)
    {
        self.oldPassWord.secureTextEntry = YES;
        self.newsPassWord.secureTextEntry = YES;
    }
    else
    {
        self.oldPassWord.secureTextEntry = NO;
        self.newsPassWord.secureTextEntry = NO;
    }
    
}

- (IBAction)Save:(id)sender {
    [self.oldPassWord resignFirstResponder];
    [self.newsPassWord resignFirstResponder];

    NSString * password = self.oldPassWord.text;
    [self passWordHasChanged:password];
}


-(void)passWordHasChanged:(NSString *)password
{
    NSLog(@"cur :%@, input:%@", self.personinfo.password, password);
    if ([self.personinfo.password isEqualToString:password] == YES) {
        
        NSString * new = [[NSString alloc]initWithString:self.newsPassWord.text];
        self.personinfo.password = new;
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alert show];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"输入密码不正确" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
        
        [alert show];
    }
}


@end
