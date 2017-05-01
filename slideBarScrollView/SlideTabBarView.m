//
//  SlideTabBarView.m
//  slideBarScrollView
//
//  Created by 刘伟 on 2017/4/27.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import "SlideTabBarView.h"
#import "BottomBaseView.h"

//顶部naviBar高度
#define TOPHEIGHT 60

@interface SlideTabBarView()<UIScrollViewDelegate,UIWebViewDelegate>

///@brife 整个视图的大小
@property (assign) CGRect mViewFrame;

///@brife 下方的ScrollView
@property (strong, nonatomic) UIScrollView *scrollView;

///@brife 上方的按钮数组
@property (strong, nonatomic) NSMutableArray *topViews;

///@brife 下方的表格数组
@property (strong, nonatomic) NSMutableArray *scrollTableViews;

///@brife TableViews的数据源
@property (strong, nonatomic) NSMutableArray *dataSource;

///@brife 当前选中页数
@property (assign) NSInteger currentPage;

///@brife 下面滑动的View
@property (strong, nonatomic) UIView *slideView;

///@brife 上方的ScrollView
@property (strong, nonatomic) UIScrollView *topScrollView;

///@brife 上方的view
@property (strong, nonatomic) UIView *topMainView;

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) NSMutableArray *urlArr;

@property (strong, nonatomic)BottomBaseView *bbv;

@end

@implementation SlideTabBarView

#pragma 懒加载
-(UIWebView *)webView {
    
    if (!_webView) {
        _webView=[[UIWebView alloc]init];
    }
    return _webView;
}

//-(BottomBaseView *)bbv {
//    if (!_bbv) {
//        
//    }
//    return _bbv;
//}


-(instancetype)initWithFrame:(CGRect)frame WithCount:(NSInteger)count {
    self = [super initWithFrame:frame];
    if (self) {
        _mViewFrame = frame;
        _tabCount = count;
        _topViews = [[NSMutableArray alloc] init];
        _scrollTableViews = [[NSMutableArray alloc] init];
        _urlArr = [NSMutableArray arrayWithObjects:@"https://www.zhihu.com/",@"https://www.baidu.com",@"https://www.sina.com.cn/",@"https://qiye.163.com/",@"https://qiye.163.com/",@"https://www.sina.com.cn", nil];
        
        [self initDataSource];
        
        [self initScrollView];
        
        [self initTopTabs];
        
        //[self initDownScrollViews];
        
        [self initDataSource];
        
        [self initSlideView];
    }
    return self;
}

-(void)initDataSource {
    for (int i = 0; i<_tabCount; i++) {
        
    }
}

//下面的内容
-(void) initScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _mViewFrame.origin.y, _mViewFrame.size.width, _mViewFrame.size.height - TOPHEIGHT)];
    _scrollView.contentSize = CGSizeMake(_mViewFrame.size.width * _tabCount, _mViewFrame.size.height - 60);
    _scrollView.backgroundColor = [UIColor yellowColor];
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    
    for (int i =0; i<_tabCount; i++) {
        
        _bbv = [[BottomBaseView alloc]init];
        _bbv.frame = CGRectMake(i * _mViewFrame.size.width,0, _mViewFrame.size.width,  _mViewFrame.size.height-TOPHEIGHT);
        _bbv.url =_urlArr[i];
        [_scrollView addSubview:_bbv];
        
//        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(i * _mViewFrame.size.width,0, _mViewFrame.size.width,  _mViewFrame.size.height-TOPHEIGHT)];
//        
//        _webView.delegate=self;
//        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlArr[i]]]];
//        [_scrollView addSubview:_webView];
    }
    
    [self addSubview:_scrollView];
}

-(void)initTopTabs {
    
    CGFloat width = _mViewFrame.size.width/6;
    
    _topMainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _mViewFrame.size.width, TOPHEIGHT)];
    //    _topMainView.backgroundColor=[UIColor yellowColor];
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _mViewFrame.size.width, TOPHEIGHT)];
    
    [self addSubview:_topMainView];
    
    [_topMainView addSubview:_topScrollView];
    
    for (int i = 0; i < _tabCount; i ++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, TOPHEIGHT)];
        
        view.backgroundColor = [UIColor lightGrayColor];
        
        if (i % 2) {
            view.backgroundColor = [UIColor grayColor];
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, TOPHEIGHT)];
        button.tag = i;
        [button setTitle:[NSString stringWithFormat:@"按钮%d", i+1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tabButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        
        [_topViews addObject:view];
        [_topScrollView addSubview:view];
    }

}

#pragma mark --点击顶部的按钮所触发的方法
-(void) tabButton: (id) sender{
    UIButton *button = sender;
    [_scrollView setContentOffset:CGPointMake(button.tag * _mViewFrame.size.width, 0) animated:YES];
}

-(void)initDownScrollViews {
    
    //下面scrollView已经一次全部初始化好了
    for (int i =0 ; i<_tabCount; i++) {
        
        NSLog(@"_mViewFrame.origin.y %f",_mViewFrame.origin.y);
        //包含复用机制
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(i * _mViewFrame.size.width,0, _mViewFrame.size.width,  _mViewFrame.size.height-TOPHEIGHT)];
        self.webView.delegate=self;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlArr[i]]]];
        [_scrollView addSubview:self.webView];
        
    }
    
    NSLog(@"_scrollView.subviews :%@",_scrollView.subviews);
}

#pragma mark -- 初始化滑动的指示View
-(void) initSlideView {
    
    CGFloat width = _mViewFrame.size.width / 6;
    if(self.tabCount <=6){
        width = _mViewFrame.size.width / self.tabCount;
    }
    _slideView = [[UIView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT - 2, width, 2)];
    [_slideView setBackgroundColor:[UIColor redColor]];
    [_topScrollView addSubview:_slideView];
    
}

#pragma UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView==_scrollView) {
        NSLog(@"%f",_scrollView.contentOffset.x);
        _currentPage = _scrollView.contentOffset.x/_mViewFrame.size.width;
        NSLog(@"_currentPage %ld",_currentPage);
        //[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlArr[_currentPage]]]];
        NSLog(@"加载的url %@",_urlArr[_currentPage]);

        //切换上面的slideView的frame
        [self modifyTopScrollViewPositiong:scrollView];

    }
    
}

//滑动下方scrollView对应联动上面的slideView
-(void) modifyTopScrollViewPositiong: (UIScrollView *) scrollView {
    
    if (_scrollView == scrollView) {
        
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        CGFloat width = self.frame.size.width;
        
        //当前是第几页
        int count = (int)contentOffsetX/(int)width;

//        NSLog(@"count %d",count);
        CGFloat step = (int)contentOffsetX%(int)width;
        
        CGFloat sumStep = width * count;
        
        if (step > width/2) {
            
            sumStep = width * (count + 1);
            
        }
//        NSLog(@"sumStep %f",sumStep);
        
        [UIView animateWithDuration:0.1 animations:^{
            _slideView.frame = CGRectMake(count*_mViewFrame.size.width / 6, TOPHEIGHT - 2, _mViewFrame.size.width / 6, 2);
        }];
        
        //[_topScrollView setContentOffset:CGPointMake(sumStep, 0) animated:YES];
        return;
        
    }
}


#pragma UIWebViewDeleagte



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
