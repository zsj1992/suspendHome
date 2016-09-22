//
//  subViewController.h
//  好用的首页
//
//  Created by zsj1992 on 16/9/21.
//  Copyright © 2016年 bjhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subViewController : UIViewController

@property (nonatomic,copy)NSString * category;

@property (nonatomic,strong)NSArray * strings;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,assign)NSInteger tag;

@property(nonatomic,strong)NSArray * topics;

@end
