//
//  ZSTableViewCell.h
//  好用的首页
//
//  Created by zsj1992 on 16/9/22.
//  Copyright © 2016年 bjhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSTopic.h"
@interface ZSTableViewCell : UITableViewCell

@property(nonatomic,strong)ZSTopic * topic;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
