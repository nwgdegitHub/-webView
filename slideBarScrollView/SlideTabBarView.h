//
//  SlideTabBarView.h
//  slideBarScrollView
//
//  Created by 刘伟 on 2017/4/27.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideTabBarView : UIView

@property (assign) NSInteger tabCount;

-(instancetype)initWithFrame:(CGRect)frame WithCount: (NSInteger) count;

@end
