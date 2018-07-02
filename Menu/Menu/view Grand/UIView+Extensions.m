//
//  UIView+Extensions.m
//  pal
//
//  Created by feel on 2017/11/25.
//  Copyright © 2017年 aihuoba. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)
#pragma mark 重写set get 方法
#pragma mark - x
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

#pragma mark - y
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}

#pragma mark - width
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

#pragma mark - height
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
}
- (CGFloat)height
{
    return self.frame.size.height;
}

#pragma mark - centerX
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}

#pragma mark - centerY
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}

#pragma mark - size
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}

#pragma mark - max X
- (void)setMaxX:(CGFloat)maxX
{
    //    CGFloat mxX = CGRectGetMaxX(self.frame);
    //    mxX = maxX;
}
- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

#pragma mark - max Y
-(void)setMaxY:(CGFloat)maxY
{}
-(CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

#pragma mark - minX
- (void)setMinX:(CGFloat)minX
{}

- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

#pragma mark - minY
- (void)setMinY:(CGFloat)minY
{}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}

#pragma mark - midX
- (void)setMidX:(CGFloat)midX
{}

- (CGFloat)midX
{
    return  CGRectGetMidX(self.frame);
}

#pragma mark  - midY
- (void)setMidY:(CGFloat)midY
{}

- (CGFloat)midY
{
    return CGRectGetMinY(self.frame);
}
@end
