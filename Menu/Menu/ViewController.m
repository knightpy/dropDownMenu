//
//  ViewController.m
//  Menu
//
//  Created by knight on 2018/6/29.
//  Copyright © 2018年 knight. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //基本操作
   
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:[[SecondViewController alloc]init] animated:YES completion:^{
        
    }];
}
@end
