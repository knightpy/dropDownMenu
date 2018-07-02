//
//  MenuTitleButton.h
//  Closure
//
//  Created by knight on 2018/6/28.
//  Copyright © 2018年 knight. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuTitleButton;

typedef void(^MenuTitleButtonClickButton)(MenuTitleButton *btn);

@interface MenuTitleButton : UIButton


@property(nonatomic,copy)MenuTitleButtonClickButton block ;

+ (instancetype ) newCreateButton ;

/** 标题 */
@property (nonatomic,strong) UILabel *lb;
/** 箭头 */
@property (nonatomic,strong) UIImageView *imgLine;
@end
