//
//  ViewController.m
//  Menu
//
//  Created by knight on 2018/6/29.
//  Copyright © 2018年 knight. All rights reserved.
//

#import "ViewController.h"
#import "DropdownMenuView.h"

@interface ViewController ()<DropdownMenuViewDelegate>
/** strong */
@property (nonatomic,strong) DropdownMenuView *dropdownMenuView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDropdownMenuView];
}


#pragma mark - 下拉菜单
- (void)setupDropdownMenuView
{
    
    NSArray * arr = [NSArray arrayWithObjects:@"位置",@"岗位",@"结算方式", nil];
    DropdownMenuView * menu = [[DropdownMenuView alloc]initWithFrame:CGRectZero parent:self.view title:arr];
    menu.menuDelagete = self; //签署代理
    [menu setLbSelectColor:[UIColor redColor]];
    self.dropdownMenuView = menu;
}


#pragma mark  - 下拉菜单的协议
- (void)selectTitle:(NSString *)title currentItem:(NSInteger)item view:(DropdownMenuView *)view
{
    NSLog(@"你选择的是 ===== >> %@ >> %ld >> %@",title,item,view);
    //把title传出去, 以进行下一步操作
}


@end
