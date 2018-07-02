//
//  UIView+Extensions.h
//  pal
//
//  Created by feel on 2017/11/25.
//  Copyright © 2017年 aihuoba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;

@property (nonatomic,assign) CGFloat maxX;
@property (nonatomic,assign) CGFloat maxY;

@property (nonatomic,assign) CGFloat minX;
@property (nonatomic,assign) CGFloat minY;

@property (nonatomic,assign) CGFloat midX;
@property (nonatomic,assign) CGFloat midY;
@end
