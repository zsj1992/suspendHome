//
//  subViewController.m
//  好用的首页
//
//  Created by zsj1992 on 16/9/21.
//  Copyright © 2016年 bjhj. All rights reserved.
//

#import "subViewController.h"

@interface subViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation subViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.category isEqualToString:@"www"]) {
        
        self.strings = @[@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸",@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];

    }else{
    
        self.strings = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];

    }
    self.tableView.bounces = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(240, 0, 0, 0);
    self.tableView.tag = self.tag;
    [self.tableView reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.strings.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    NSString * str = self.strings[indexPath.row];
    
    cell.textLabel.text = str;
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    NSLog(@"===%f===",currentOffsetY);
    
    NSLog(@"talbeView向上滚了%f",240-currentOffsetY);
    
    NSDictionary * userInfo = @{@"currentOffsetY":@(currentOffsetY),@"tag":@(self.tag)};
    
    NSNotification * notification = [[NSNotification alloc]initWithName:@"subTableViewDidScroll" object:nil userInfo:userInfo];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

@end
