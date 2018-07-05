//
//  DropdownMenuView.m
//  Closure
//
//  Created by knight on 2018/6/28.
//  Copyright © 2018年 knight. All rights reserved.
//

#import "DropdownMenuView.h"
#import "MenuTitleButton.h"
#import "MenuContentCollectionViewCell.h"
#import "UIView+Extensions.h"

// 屏幕宽高
#define kScreenWidth        [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height

#define DEFAULT_BACKCOLOR [UIColor colorWithWhite:0 alpha:0.5]
#define DEFAULT_VIEW_HRIGHT  60.f //默认的parentScrollview 高度
#define DEFAULT_BASEVIEW_HEIGHT 40.f //默认的baseView 高度
#define LBTITLE_WIDTH (kScreenWidth/3) //默认的lab宽度
#define FONTSIZE 15.f //字体大小

static NSString * const contentiditer   = @"MenuContentCollectionViewCell";

@interface DropdownMenuView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    DropdownMenuView * _menuView;
    UIView * _parentView;
    NSArray * _arrContentAll;
    MenuTitleButton * _currentBtn;
}
/** 底层视图 - UIView */
@property (nonatomic,strong) UIView *baseView;
/** 底层视图 - UIScrollView */
@property (nonatomic,strong) UIScrollView *parentScrollview;
/** 标题 */
@property (nonatomic,strong) UILabel *lbTitle;
/** 箭头指标 */
@property (nonatomic,strong) UIImageView *imgTitle;
/** 是否选中了当前的某一标题 */
@property ( nonatomic , assign) BOOL isSelect ;
/** 标题数组 */
@property (nonatomic,strong) NSArray *arrTitle;
/** 内容载体 */
@property (nonatomic,strong) UICollectionView *contentCollectionView;
/** strong */
@property (nonatomic,strong) NSArray *arrResults;
@end

@implementation DropdownMenuView

-(NSArray *)arrResults
{
    if (!_arrResults) {
        _arrResults = [NSArray array];
    }
    return _arrResults;
}
+(instancetype)showDropdownMenuViewinitWithFrame:(CGRect)frame parent:(UIView *)parent title:(NSArray *)titles
{
    return  [[self alloc] initWithFrame:frame parent:parent title:titles];
}

- (instancetype)initWithFrame:(CGRect)frame parent:(UIView *)parent title:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        //UIWindow * win = [[UIApplication sharedApplication]keyWindow];
        self.frame = frame;//CGRectMake(0, 0, kScreenWidth, DEFAULT_VIEW_HRIGHT);//DEFAULT_VIEW_HRIGHT
        [parent addSubview:self];
        self.backgroundColor = [UIColor whiteColor];
        _parentView  = parent;
        
        _arrTitle = titles;
        _isSelect = NO;
        //加载数据
        [self loadData];
        //操作
        [self setupAllView];
    }
    return self;
}

#pragma mark 设置所有视图
- (void)setupAllView
{
    [self baseView];
    [self parentScrollview];//标题滚动视图
    [self setupTitle]; //标题
    [self arrResults];
    //下拉菜单的内容
    [self contentCollectionView];
}

#pragma mark 底层 View
- (UIView *)baseView
{
    if (!_baseView ) {
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, DEFAULT_VIEW_HRIGHT)];
        _baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baseView];
    }
    return _baseView;
}

#pragma mark 标题滚动视图
- (UIScrollView *)parentScrollview
{
    if (!_parentScrollview) {
        _parentScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, DEFAULT_VIEW_HRIGHT) ];
        _parentScrollview.backgroundColor = [UIColor  whiteColor];// orangeColor];
        _parentScrollview.scrollEnabled = YES;
        _parentScrollview.showsHorizontalScrollIndicator = NO;
        _parentScrollview.showsVerticalScrollIndicator = NO;
        _parentScrollview.translatesAutoresizingMaskIntoConstraints = NO;
        [self.baseView addSubview:_parentScrollview];
    }
    return _parentScrollview;
}

#pragma mark - 标题数组
-(void)setupTitle{
    // _arrTitle = [NSMutableArray arrayWithObjects:@"位置",@"岗位",@"结算方式", nil];
    NSInteger lbCount = _arrTitle.count;
    
    //scrollView内容大小
    self.parentScrollview.contentSize = CGSizeMake(LBTITLE_WIDTH * lbCount, DEFAULT_VIEW_HRIGHT);
    
    for (int i=0; i<lbCount; i++) {
        if (lbCount <= 3) {
            self.parentScrollview.scrollEnabled = NO;
        }else{
            self.parentScrollview.scrollEnabled = YES;
        }
        
        //初始化UILable
        MenuTitleButton * mebuBtn = [MenuTitleButton newCreateButton];
        mebuBtn.frame = CGRectMake( i * LBTITLE_WIDTH , 0 , LBTITLE_WIDTH , DEFAULT_VIEW_HRIGHT);
        mebuBtn.lb.text = _arrTitle[i];
        mebuBtn.lb.textColor = [UIColor blackColor];
        mebuBtn.lb.font = [UIFont systemFontOfSize:FONTSIZE];
        
        mebuBtn.tag = 100 + i;
        mebuBtn.backgroundColor  =[UIColor whiteColor];
        [mebuBtn addTarget:self action:@selector(clickEventMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self.parentScrollview addSubview:mebuBtn];
        //self.lbTitle = mebuBtn.lb;
    }
}

#pragma mark  - UIcollectionView初始化
-(UICollectionView *)contentCollectionView
{
    if (!_contentCollectionView) {
        //布局对象
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        
        //self.height - self.baseView.height - 1
        //判断数据的个数. 进行设置网格的高度
        NSArray * first = (NSArray *)_arrContentAll.firstObject;
        CGFloat fff =0;
        if (first.count > 6) {
            fff = (first.count /3) + (first.count % 3 >= 1 ? 1 : 0);
        }else{
            fff = first.count ;
        }
        CGFloat h =  fff * 35 + fff;
        
        CGRect cRect = CGRectMake(0, self.baseView.height + 1, kScreenWidth, h);
        _contentCollectionView = [[UICollectionView alloc]initWithFrame:cRect collectionViewLayout:layout];
        _contentCollectionView.showsVerticalScrollIndicator = NO;//隐藏滚动条
        _contentCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _contentCollectionView.bounces = YES;
        _contentCollectionView.delegate = self;
        _contentCollectionView.dataSource = self;
        _contentCollectionView.hidden = YES;
        
        //注册item
        [_contentCollectionView registerNib:[UINib nibWithNibName:@"MenuContentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:contentiditer];
        
        [self addSubview:_contentCollectionView];
    }
    return _contentCollectionView;
}

#pragma mark - 设置颜色
- (void)setArrayTitle:(NSMutableArray *)arrayTitle
{
    _arrayTitle = arrayTitle;
    self.arrTitle = arrayTitle;
}

-(void)setLbSelectColor:(UIColor *)lbSelectColor
{
    _lbSelectColor = lbSelectColor;
    //    self.lbTitle.textColor = lbSelectColor;
}

-(void)setLbUnSelectColor:(UIColor *)lbUnSelectColor
{
    _lbUnSelectColor = lbUnSelectColor;
    //    self.lbTitle.textColor = lbUnSelectColor;
}

- (void)clickEventMenu:(MenuTitleButton *)button
{
    button.selected = !button.selected;
    _isSelect =  button.selected;
    
    if (_isSelect) {
        //整体View的frame
        self.backgroundColor = DEFAULT_BACKCOLOR;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = self.frame;
            rect.size.height = kScreenHeight ;//;- kTableView_Height;
            self.frame = rect;
        }];
        button.imgLine.image = [UIImage imageNamed:@"line_up.png"];
        //不隐藏
        [self.contentCollectionView setHidden:NO];
        
        //通过tag值,以 下标获取数据
        _arrResults = _arrContentAll[button.tag -100];
        
        //判断数据个数, 设置表格的高度
        [self setupCollevtionViewFrame:button];
        
        //遍历网格视图, 设置其他按钮不可用
        [self setupButtonEnable:button isBool:NO];
    }else{
        [UIView animateWithDuration:0.35 animations:^{
            CGRect rect = self.frame;
            rect.size.height = DEFAULT_VIEW_HRIGHT;
            self.frame = rect;
        }];
        button.imgLine.image = [UIImage imageNamed:@"line_down.png"];
        
        //隐藏网格视图
        [self.contentCollectionView setHidden:YES];
        //遍历网格视图, 设置其他按钮不可用
        [self setupButtonEnable:button isBool:YES];
    }
    _currentBtn = button;
}

#pragma mark - 判断数据个数, 设置表格的高度
- (void)setupCollevtionViewFrame:(MenuTitleButton *)button
{
    //判断数据个数, 设置表格的高度
    CGFloat fff =0;
    if (_arrResults.count > 6) { //大于6换行
        fff = (_arrResults.count /3) + (_arrResults.count % 3 >= 1 ? 1 : 0);
    }else{
        fff = _arrResults.count ;
    }
    CGFloat h =  fff * 35 + fff;
    self.contentCollectionView.frame = CGRectMake(0, self.baseView.height + 1, kScreenWidth, h);
    [self.contentCollectionView reloadData];
}
#pragma mark - 遍历网格视图, 设置其他按钮不可用
- (void)setupButtonEnable:(MenuTitleButton*)button isBool:(BOOL)bol{
    //遍历网格视图, 设置其他按钮不可用
    for (MenuTitleButton* btn  in self.parentScrollview.subviews) {
        if (bol) {
            if (![btn isEqual:button]) {
                [btn setEnabled:bol];
            }else{
                [btn setEnabled:YES];
            }
            btn.lb.textColor = [UIColor blackColor];
        }else{
            if (![btn isEqual:button]) {
                [btn setEnabled:bol];
                btn.lb.textColor = [UIColor darkGrayColor];
            }else{
                [btn setEnabled:YES];
                btn.lb.textColor = [self lbSelectColor];
            }
        }
        
    }
    //    for (MenuTitleButton* btn  in self.parentScrollview.subviews) {
    //        if (![btn isEqual:button]) {
    //            btn.lb.textColor = [UIColor blackColor];
    //            btn.imgLine.image = [UIImage imageNamed:@"line_down.png"];
    //            //                btn.selected  = !btn.selected;
    //        }else{
    //            button.lb.textColor = [self lbSelectColor];
    //            button.imgLine.image = [UIImage imageNamed:@"line_up.png"];
    //        }
    //    }
}
#pragma mark  - 加载数据
- (void)loadData
{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"MenuViewTitleList.plist" ofType:nil];
    NSArray * arrData = [ NSArray arrayWithContentsOfFile:path];
    _arrContentAll = arrData;
    NSLog(@"各种标题 ==== >>%@",arrData);
}

#pragma mark  - UIcollectionView 协议
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrResults.count != 0 ?_arrResults.count : 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuContentCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:contentiditer forIndexPath:indexPath];
    if (_arrResults.count != 0) {
        cell.labContent.text = _arrResults[indexPath.item];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //按钮的状态改变
    _currentBtn.selected = !_currentBtn.selected;
    
    if (self.menuDelagete && [self.menuDelagete respondsToSelector:@selector(selectTitle:currentItem:view:)]) {
        [self.menuDelagete selectTitle:_arrResults[indexPath.item] currentItem:indexPath.item view:self];
    }
    
    //当前分类标题改变
    _currentBtn.lb.text = _arrResults[indexPath.item];
    
    [UIView animateWithDuration:0.35 animations:^{
        CGRect rect = self.frame;
        rect.size.height = DEFAULT_VIEW_HRIGHT;
        self.frame = rect;
    }];
    //默认黑色
    _currentBtn.imgLine.image = [UIImage imageNamed:@"line_down.png"];
    
    // 网格视图是否隐藏
    [self.contentCollectionView setHidden:YES];
    // 遍历网格视图, 设置其他按钮不可用
    [self setupButtonEnable:_currentBtn isBool:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_arrResults.count > 6) {
        return CGSizeMake((kScreenWidth - 2)/3, 35);
    }else{
        return CGSizeMake(kScreenWidth, 35);
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (MenuTitleButton* btn  in self.parentScrollview.subviews) {
        btn.selected = !btn.selected;
        [btn setEnabled:YES];
        btn.lb.textColor = [UIColor blackColor];
        btn.imgLine.image = [UIImage imageNamed:@"line_down.png"];
    }
    [UIView animateWithDuration:0.35 animations:^{
        CGRect rect = self.frame;
        rect.size.height = DEFAULT_VIEW_HRIGHT;
        self.frame = rect;
    }];
    [self.contentCollectionView setHidden:YES];
}

@end
