//
//  ViewController.m
//  好用的首页
//
//  Created by zsj1992 on 16/9/21.
//  Copyright © 2016年 bjhj. All rights reserved.
//

#import "ViewController.h"
#import "subViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)UIView * headView;

@property (nonatomic,strong)UIScrollView * segmentView;

@property (nonatomic,strong)UIView * CusNavigationBar;

@property (nonatomic,strong)UIScrollView * contentScrollView;

@property (nonatomic,strong)NSArray * categorys;

@property(nonatomic,strong)NSMutableArray * subVcs;

@property (nonatomic,strong)NSMutableArray * segmentBtns;

@property (nonatomic,strong)UIButton * segmentBtnSel;

@property (nonatomic,strong)UIView * indicator;

@end

@implementation ViewController

-(NSMutableArray *)segmentBtns{

    if (_segmentBtns==nil) {
        _segmentBtns = [NSMutableArray array];
    }
    return _segmentBtns;
}

-(NSMutableArray *)subVcs{

    if (_subVcs==nil) {
        _subVcs = [NSMutableArray array];
    }
    return _subVcs;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categorys = @[@"1",@"2",@"在模拟器上面跑没有问题",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    
    [self setupUI];
    
    [self setupSegment];
    
    [self setupSubVcs];

   
    
    
    OrignalOffset = -(HeadViewHeight+SegmentViewHeight);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subTableViewDidScroll:) name:@"subTableViewDidScroll" object:nil];
    

}

CGFloat NavigationHeight = 64;
CGFloat HeadViewHeight=200;
CGFloat SegmentViewHeight = 40;
CGFloat OrignalOffset;

-(void)setupUI{
    self.segmentBtnSel = [[UIButton alloc]init];
    [self.segmentBtnSel setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
    
    self.CusNavigationBar = [[UIView alloc]init];
    self.CusNavigationBar.alpha = 0;
    self.CusNavigationBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.CusNavigationBar];
    [self.CusNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    self.headView = [[UIView alloc]init];
    [self.view addSubview:self.headView];
    self.headView.backgroundColor = [UIColor darkGrayColor];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    self.segmentView = [[UIScrollView alloc]init];
    [self.view addSubview:self.segmentView];
    self.segmentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];

    self.indicator = [[UIView alloc]init];
    _indicator.backgroundColor = [UIColor redColor];
    [self.segmentView addSubview:_indicator];
    [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.segmentView).offset(-2);
        
        make.height.mas_equalTo(1);
        
        make.left.mas_equalTo(40);
        
        make.width.mas_equalTo(40);
    }];
    

    
    self.contentScrollView = [[UIScrollView alloc]init];
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.contentSize = CGSizeMake(self.categorys.count*SCREEN_WIDTH, 0);
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];

    
    

    [self.view bringSubviewToFront:_CusNavigationBar];
}

-(void)setupSegment{
    
    for (int i = 0; i<self.categorys.count; ++i) {
        
        NSString * category = self.categorys[i];
        
        NSDictionary * attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
        
        CGSize size = [category boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        
        
        
        
        UIButton * btn = [[UIButton alloc]init];
        
        [self.segmentView addSubview:btn];
        
        
        
        
        if (self.segmentBtns.count>0) {
        
            UIButton * btnLast = self.segmentBtns[i-1];
            
            
            
            btn.frame = CGRectMake(CGRectGetMaxX(btnLast.frame)+40, 0, size.width<40?40:size.width, 40);
        }
        else{
            btn.frame = CGRectMake(40, 0, size.width<40?40:size.width, 40);
        }
        
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [btn setTitle:category forState:UIControlStateNormal];
        
        btn.tag = 2000+i;
        
        [btn addTarget:self action:@selector(btnSegmentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.segmentBtns addObject:btn];
    }
    
    UIButton * btnLast = self.segmentBtns[self.segmentBtns.count-1];
    
    self.segmentView.contentSize = CGSizeMake(CGRectGetMaxX(btnLast.frame)+40,0);
}



-(void)btnSegmentClick:(UIButton *)sender{
    
    self.segmentBtnSel.selected = NO;
    
    self.segmentBtnSel = sender;
    
    self.segmentBtnSel.selected = YES;
   
    UIButton * btnLast = self.segmentBtns[self.segmentBtns.count-1];

    NSLog(@"%f+++++%f",CGRectGetMidX(self.segmentBtnSel.frame),self.segmentView.contentSize.width+40-(SCREEN_WIDTH/2));
    NSLog(@"%f",SCREEN_WIDTH);
    
    if (CGRectGetMidX(self.segmentBtnSel.frame)<SCREEN_WIDTH/2) {
        [self.segmentView setContentOffset:CGPointMake(0, 0) animated:YES];

    }
    
    else if(CGRectGetMidX(self.segmentBtnSel.frame)>self.segmentView.contentSize.width+40-SCREEN_WIDTH/2){//最后几个
    
    }else{
        [self.segmentView setContentOffset:CGPointMake(CGRectGetMidX(self.segmentBtnSel.frame)-SCREEN_WIDTH/2, 0) animated:YES];
    }
    
    [self selectSubVc:sender.tag-2000];
    
}


//提供方法选中某一个子控制器
-(void)selectSubVc:(NSInteger)idx{

    [self.contentScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*idx, 0) animated:NO];
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    

    [self.segmentView bringSubviewToFront:self.indicator];
    
}


-(void)subTableViewDidScroll:(NSNotification *)notification{

    NSDictionary * userInfo = notification.userInfo;
    
    
    CGFloat currentOffsetY = [userInfo[@"currentOffsetY"] doubleValue];
    
    
    CGFloat delta = currentOffsetY - OrignalOffset;
    
    NSLog(@"哦哦,对他是滚了%f",240-currentOffsetY);
   
    
    if (currentOffsetY>-104) {
    
        for (subViewController * subVc in self.subVcs) {
            
            NSInteger idx = [self.subVcs indexOfObject:subVc];
            
            NSInteger tag = [userInfo[@"tag"] integerValue];
            
            NSLog(@"%ld===%ld",tag,1000+idx);
            
            if(tag!=1000+idx) {
                
                [subVc.tableView setContentOffset:CGPointMake(0, -104)];

            }
            
            
        }
 
    }else{
    
        for (subViewController * subVc in self.subVcs) {

            [subVc.tableView setContentOffset:CGPointMake(0, currentOffsetY)];

        }
    }
    
    if (delta>HeadViewHeight-NavigationHeight) {
        
        delta = HeadViewHeight-NavigationHeight;
    }

    CGFloat alpah = delta/(200-64);
    
    self.CusNavigationBar.alpha = alpah;
    
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(-delta);
        
    }];
    

    
}


//添加子控制器
-(void)setupSubVcs{
    
    
    for (NSString * category in self.categorys) {
        
        NSInteger idx = [self.categorys indexOfObject:category];
        
        subViewController * subVc = [[subViewController alloc]init];
        
        [self.subVcs addObject:subVc];
        
        subVc.category = category;
        
        subVc.tag = 1000+idx;
        
        [self addChildViewController:subVc];
        
        [self.contentScrollView addSubview:subVc.view];
        
        [subVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.view);
            
            make.left.mas_equalTo(idx*SCREEN_WIDTH);
            
            make.width.mas_equalTo(SCREEN_WIDTH);
            
            make.bottom.equalTo(self.view).offset(-44);
        }];
        
    }

    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

@end
