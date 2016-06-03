//
//  ViewController.m
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

#import "ViewController.h"
#import "NavigationController.h"
#import "DemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DemoViewController *vc = [DemoViewController new];
    vc.index = indexPath.row;
    
    if (indexPath.row == 4) {
        UINavigationController *nc = [[NavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nc animated:YES completion:NULL];
    }else {
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
