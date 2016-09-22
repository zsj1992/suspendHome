//
//  Tool.m
//  好用的首页
//
//  Created by zsj1992 on 16/9/22.
//  Copyright © 2016年 bjhj. All rights reserved.
//

#import "Tool.h"

@interface Tool()




@end

@implementation Tool


+(NSDictionary *)getData{
    
    NSString * filepath = [[NSBundle mainBundle] pathForResource:@"app_JSON" ofType:nil];
    
    NSURL * url = [NSURL fileURLWithPath:filepath];
    
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    return dataDic;
}

@end
