//
//  PointViewController.m
//  SmartBox
//
//  Created by wangsl-iMac on 14/12/10.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "PointViewController.h"
#import "PointTableViewCell.h"
@interface PointViewController ()
{
    CGFloat cellheight;
}
@property(nonatomic, strong) CALayer * pointProgress;
@property(nonatomic, strong) UIView * backView;
@property(nonatomic, strong) CALayer * progressBackGrpup;
@property(nonatomic, strong) CALayer * Progress;

@end

@implementation PointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    
    self.backView = [self.view viewWithTag:1000];
    if (self.backView != nil) {
        
        CGRect rectBack = CGRectMake(0, 0, 200, 15);
        self.progressBackGrpup = [self createPointProgressBar:CGPointMake(80, 145) bounds:rectBack color:[UIColor whiteColor]];
        float cur = [self progressBarScale:1000 curPoint:500 progressLength:rectBack.size.width];
        
        CGRect rectProgress = CGRectMake(0, 0, cur, 15);
        self.Progress = [self createPointProgressBar:CGPointMake(80, 145) bounds:rectProgress color:[UIColor yellowColor]];
        
        [self.backView.layer addSublayer:self.progressBackGrpup];
        [self.progressBackGrpup setNeedsDisplay];
        
        [self.backView.layer addSublayer:self.Progress];
        [self.Progress setNeedsDisplay];
    }
}

-(float)progressBarScale:(float)total curPoint:(float)cur progressLength:(float)length{
    
    float scale = cur / total;
    float curlength = length * scale;
    
    return curlength;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.r
}

-(CALayer *)createPointProgressBar:(CGPoint)point bounds:(CGRect)rect color:(UIColor *)backColor{
    
    
    CALayer *layer = [[CALayer alloc]init];
    
    layer.bounds = rect;//CGRectMake(0, 0, 250, 15);
    layer.backgroundColor = backColor.CGColor;
    [layer setAnchorPoint:CGPointMake(0, 0)];
    [layer setPosition:point];
    
    layer.cornerRadius = rect.size.height / 2.0;
    layer.delegate = self;

    return layer;
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"drawLayer in Ctrl%@", layer);
    
    //绘制
    CGContextStrokePath(ctx);
    
    NSString * stringProgress = @"50/100";
    
    UIGraphicsPushContext(ctx);
    
    UIColor *stringColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0];  //设置文本的颜色
    
    NSDictionary* attrs =@{NSForegroundColorAttributeName:stringColor,
                           NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter"size:15],
                           }; //在词典中加入文本的颜色 字体 大小

    [stringProgress drawInRect:CGRectMake(70, 0, 80, 15) withAttributes:attrs];
    UIGraphicsPopContext();
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



//根据NSIndexPath 设置指定行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"row height:%f", cellheight);
    return cellheight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"cellForRowAtIndexPath :%ld", indexPath.row);
    PointTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"PointCell" owner:self options:nil] objectAtIndex:0];
    
    cell.date = @"12.3";
    [cell addNewItem:@"5-SMART-BOX-map-car" textLabel:@"大赞，连续登陆5天获得了52个积分"];
    [cell addNewItem:@"5-SMART-BOX-map-me" textLabel:@"分享到朋友圈或QQ空间3次获得了60个积分"];
    
    [cell createTableViewCell];
    
    cellheight = cell.cellHeight;
    return cell;
}

-(void)dealloc{
    NSLog(@"dealloc layer");
    
    
    [self.progressBackGrpup removeFromSuperlayer];
    [self.Progress removeFromSuperlayer];
    
    self.Progress.delegate = nil;
    self.progressBackGrpup.delegate = nil;
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
