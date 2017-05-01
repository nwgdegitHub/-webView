//
//  ViewController.m
//  slideBarScrollView
//
//  Created by mac on 16/2/5.
//  Copyright © 2016年 刘伟. All rights reserved.
//

#import "ViewController.h"
#import "SlideTabBarView.h"


@interface ViewController ()
@property (assign) NSInteger tabCount;
@property (strong, nonatomic) SlideTabBarView *slideTabBarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tabCount = 6;//一开始的个数
    [self initSlideWithCount:_tabCount];
    
}

-(void) initSlideWithCount: (NSInteger) count{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    screenBound.origin.y = 60;
    
    _slideTabBarView = [[SlideTabBarView alloc] initWithFrame:screenBound WithCount:count];
    [self.view addSubview:_slideTabBarView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
