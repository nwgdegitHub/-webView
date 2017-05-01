//
//  BottomBaseView.m
//  slideBarScrollView
//
//  Created by 刘伟 on 2017/5/1.
//  Copyright © 2017年 刘伟. All rights reserved.
//

#import "BottomBaseView.h"

@interface BottomBaseView()<WKUIDelegate>

@end

@implementation BottomBaseView

-(WKWebView *)WebView {
    if (!_WebView) {
        _WebView = [[WKWebView alloc]init];
    }
    return _WebView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        
        self.WebView.UIDelegate=self;
        
        [self addSubview:self.WebView];
    }
    return self;
}

-(void)layoutSubviews {
    self.WebView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.WebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

//-(void)webViewDidStartLoad:(UIWebView *)webView{
//    NSLog(@"webViewDidStartLoad");
//}
//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//NSLog(@"webViewDidFinishLoad");
//}
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//NSLog(@"didFailLoadWithError %@",error);
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
