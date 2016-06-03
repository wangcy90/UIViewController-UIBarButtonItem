//
//  DemoViewController.m
//  UIViewController+BarButtonItem
//
//  email：chongyangfly@163.com
//  QQ：1909295866
//  github：https://github.com/wangcy90
//  blog：http://wangcy90.github.io
//
//  Created by WangChongyang on 16/2/3.
//  Copyright © 2016年 WangChongyang. All rights reserved.
//

#import "DemoViewController.h"
#import "UIViewController+BarButtonItem.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self seupBackBarButtonItem];
    // Do any additional setup after loading the view.
}

- (void)seupBackBarButtonItem {
    
    switch (_index) {
        case 0:
            
            break;
            
        case 1:
            self.leftBarButtonItemTitle = @"点我返回";
            break;
            
        case 2: {
            self.leftBarButtonItemTitle = @"不带返回箭头";
            self.noArrow = YES;
            __weak UIViewController *vc = self;
            self.leftBarButtonItemBlock = ^(UIButton *button) {
                NSLog(@"自己控制返回操作，可以自定义一些操作");
                [vc.navigationController popViewControllerAnimated:YES];
                return YES;
            };
        }
            break;
            
            
        case 3: {
            self.rightBarButtonItemTitle = @"我是右边的";
        }
            break;
            
            
        case 4: {
            self.leftBarButtonItemTitle = @"返回";
        }
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
