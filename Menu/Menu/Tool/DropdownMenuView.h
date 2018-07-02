//
//  DropdownMenuView.h
//  Closure
//
//  Created by knight on 2018/6/28.
//  Copyright © 2018年 knight. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropdownMenuView;

@protocol DropdownMenuViewDelegate <NSObject>

- (void)selectTitle:(NSString *)title currentItem:(NSInteger )item view:(DropdownMenuView *)view;

@end

@interface DropdownMenuView : UIView
/** 标题数量 */
@property (nonatomic,strong) NSMutableArray *arrayTitle;

/** 标题 - 选中的颜色 */
@property (nonatomic,strong) UIColor *lbSelectColor;
/** 标题 - 非选中的颜色 */
@property (nonatomic,strong) UIColor *lbUnSelectColor;

+(instancetype)showDropdownMenuViewinitWithFrame:(CGRect)frame parent:(UIView *)parent title:(NSArray *)titles;


- (instancetype)initWithFrame:(CGRect)frame parent:(UIView *)parent title:(NSArray *)titles;

/** weak - 协议 */
@property (nonatomic,weak) id<DropdownMenuViewDelegate> menuDelagete;
@end
