//
//  BottomBaseView.h
//  slideBarScrollView
//
//  Created by 刘伟 on 2017/5/1.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BottomBaseView : UIView
@property(strong,nonatomic) WKWebView *WebView;
@property(strong,nonatomic) NSString *url;
@end
