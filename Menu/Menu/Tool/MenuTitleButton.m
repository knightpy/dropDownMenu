//
//  MenuTitleButton.m
//  Closure
//
//  Created by knight on 2018/6/28.
//  Copyright © 2018年 knight. All rights reserved.
//

#import "MenuTitleButton.h"
#import "UIView+Extensions.h"

#define FONTSIZE 15.f //字体大小

@implementation MenuTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //按钮点击响应事件
        [self addTarget:self action:@selector(clickResponce:) forControlEvents:UIControlEventTouchUpInside] ;
        [self lb];
        [self imgLine];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imgSize = [UIImage imageNamed:@"line_down.png"].size;
    CGFloat lbW = [self resultsHeight:self.lb.text withFont:15.f];
    
    //标题位置
    _lb.frame = CGRectMake(0, 0,lbW, self.height);
    _lb.x = (self.width - lbW - imgSize.width )/2;
    _lb.centerY = self.centerY;
    
    //指示位置
    _imgLine.frame  = CGRectMake(0, 0, imgSize.width, imgSize.height);
    _imgLine.centerY = _lb.centerY;
    _imgLine.x = _lb.maxX +5;
    
    
}

-(UILabel *)lb
{
    if (!_lb) {
        _lb = [[UILabel alloc]init];
        _lb.textAlignment = NSTextAlignmentCenter;
        [_lb sizeToFit];
        [self addSubview:_lb];
    }
    return _lb;
}

-(UIImageView *)imgLine
{
    if (!_imgLine) {
        _imgLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_down.png"]];
        [self addSubview:_imgLine];
    }
    return _imgLine;
}

- (void) clickResponce : (MenuTitleButton *)btn
{
    if (_block) {
        _block(btn);
    }
    
}
//初始化
+ (instancetype)newCreateButton
{
    
    return [MenuTitleButton buttonWithType:UIButtonTypeCustom] ;
}


- (CGFloat)resultsHeight:(NSString *)str withFont:(CGFloat)font
{
    CGSize maxSize = CGSizeMake(MAXFLOAT,self.height);
    CGFloat btnPromptW = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:(font)]} context:nil].size.width ;
    return btnPromptW;
}
@end
