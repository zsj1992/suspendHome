//
//  ZSTableViewCell.m
//  好用的首页
//
//  Created by zsj1992 on 16/9/22.
//  Copyright © 2016年 bjhj. All rights reserved.
//

#import "ZSTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface ZSTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation ZSTableViewCell



+(instancetype)cellWithTableView:(UITableView *)tableView{

    ZSTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZSTableViewCell" owner:self options:nil][0];
    }
    return cell;
}

-(void)setTopic:(ZSTopic *)topic{

    _topic = topic;
    
    NSURL * url = [NSURL URLWithString:topic.pic];
    
    [self.imgView sd_setImageWithURL:url placeholderImage:nil];
    self.lblTitle.text = topic.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
