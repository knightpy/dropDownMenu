//
//  SecondViewController.m
//  Menu
//
//  Created by knight on 2018/7/12.
//  Copyright © 2018年 knight. All rights reserved.
//

#import "SecondViewController.h"
#import "DropdownMenuView.h"

// 屏幕宽高
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height

@interface SecondViewController ()<DropdownMenuViewDelegate>
/** strong */
@property (nonatomic,weak) UILabel *lb;
/** strong */
@property (nonatomic,strong) DropdownMenuView *menuView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //基本操作
    [self Control];
}
-(void)Control
{
    NSArray * arr = [NSArray arrayWithObjects:@"位置",@"岗位",@"结算方式",@"企业性质", nil];
    DropdownMenuView * menu = [[DropdownMenuView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 60) parent:self.view title:arr];
    menu.menuDelagete = self; //签署代理
    [menu setLbSelectColor:[UIColor redColor]];
    self.menuView = menu;
    
    UILabel * lb = [self lableText:@"test" TextColor:[UIColor blueColor] fontSize:18 lableBackgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lableCGRectMake:CGRectMake(30, 550, 300, 30)];
    [self.view addSubview:lb];
    self.lb = lb;
}

#pragma mark  - 下拉菜单的协议
- (void)selectTitle:(NSString *)title currentItem:(NSInteger)item view:(DropdownMenuView *)view
{
    NSLog(@"你选择的是 ===== >> %@ >> %ld >> %@",title,item,view);
    //把title传出去, 以进行下一步操作
    
    
    self.lb.text = title;
}


-(UILabel *)lableText:(NSString *)strText TextColor:(UIColor *)color fontSize:(CGFloat)size lableBackgroundColor:(UIColor *)bColor textAlignment:(NSTextAlignment )textAlignment lableCGRectMake:(CGRect)rectMake {
    
    UILabel * lab = [[UILabel alloc]initWithFrame:rectMake] ;
    lab.text = strText ;
    lab.textAlignment = textAlignment ;
    lab.backgroundColor = bColor ;
    lab.textColor = color ;
    lab.font = [UIFont systemFontOfSize:size] ;
    return lab ;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)dealloc
{
    self.menuView.menuDelagete = nil;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
