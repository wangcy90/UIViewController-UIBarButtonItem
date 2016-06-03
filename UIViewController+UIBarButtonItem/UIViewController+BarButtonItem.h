//
//  UIViewController+BarButtonItem.h
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

#import <UIKit/UIKit.h>

typedef BOOL(^_leftBarButtonItemBlock)(id sender);//Default to NO, return YES if you control back manual.

typedef void(^_rightBarButtonItemBlock)();

@interface UIViewController(BarButtonItem)

@property(nonatomic,copy)NSString *leftBarButtonItemTitle;

@property(nonatomic,copy)NSString *leftBarButtonItemImageName;//if use highlighted image you should rename the image with suffix '_highlighted'.

@property(nonatomic,copy)NSString *rightBarButtonItemTitle;

@property(nonatomic,copy)NSString *rightBarButtonItemImageName;//if use highlighted image you should rename the image with suffix '_highlighted'.

@property(nonatomic,copy)_leftBarButtonItemBlock leftBarButtonItemBlock;

@property(nonatomic,copy)_rightBarButtonItemBlock rightBarButtonItemBlock;

@property(nonatomic,assign)BOOL noArrow;//Default to NO, control arrow image display or not.

@end
