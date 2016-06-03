//
//  UIViewController+BarButtonItem.m
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

#import "UIViewController+BarButtonItem.h"
#import <objc/runtime.h>

static void *leftBarButtonItemTitleKey = &leftBarButtonItemTitleKey;

static void *rightBarButtonItemTitleKey = &rightBarButtonItemTitleKey;

static void *leftBarButtonItemImageNameKey = &leftBarButtonItemImageNameKey;

static void *rightBarButtonItemImageNameKey = &rightBarButtonItemImageNameKey;

static void *leftBarButtonItemBlockKey = &leftBarButtonItemBlockKey;

static void *rightBarButtonItemBlockKey = &rightBarButtonItemBlockKey;

static void *noArrowKey = &noArrowKey;

@implementation UIViewController(BarButtonItem)

+ (void)load {
    
    Method originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    
    Method replaceMethod = class_getInstanceMethod(self, @selector(wcy_viewWillAppear:));
    
    if (!originalMethod || !replaceMethod) return;
    
    method_exchangeImplementations(originalMethod, replaceMethod);
    
}

- (void)wcy_viewWillAppear:(BOOL)animated {

    [self wcy_viewWillAppear:animated];
    
    if (self.navigationController && !self.navigationItem.leftBarButtonItem && self.leftBarButtonItemTitle.length) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:self.leftBarButtonItemTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (!self.noArrow) {
            [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"back_highlighted"] forState:UIControlStateHighlighted];
        }
        
        NSString *imageName = self.leftBarButtonItemImageName;
        
        if (imageName) {
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"_highlighted"]] forState:UIControlStateHighlighted];
        }
        
        [button sizeToFit];

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    
    if (!self.navigationItem.rightBarButtonItem && (self.rightBarButtonItemTitle.length || self.rightBarButtonItemImageName.length)) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.rightBarButtonItemTitle) {
            [button setTitle:self.rightBarButtonItemTitle forState:UIControlStateNormal];
        }
        
        NSString *imageName = self.rightBarButtonItemImageName;
        
        if (imageName) {
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"_highlighted"]] forState:UIControlStateHighlighted];
        }
        
        [button sizeToFit];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
}

- (void)backClick:(UIButton *)button {
    
    BOOL manualBack = !self.leftBarButtonItemBlock ? NO : self.leftBarButtonItemBlock(button);
    
    BOOL isPresent = self.isPresent;
    
    if (manualBack) {
        return;
    }
    
    if (isPresent) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightItemClick:(UIButton *)button {
    !self.rightBarButtonItemBlock ? : self.rightBarButtonItemBlock();
}

- (BOOL)isPresent {
    if (self.navigationController && self.navigationController.presentingViewController)
        return ([self.navigationController.viewControllers indexOfObject:self] == 0);
    else
        return ([self presentingViewController] != nil);
}

#pragma mark - leftBarButtonItem

- (NSString *)leftBarButtonItemTitle {
    
    NSString *title = objc_getAssociatedObject(self, leftBarButtonItemTitleKey);
    
    if (!title) {
        if (self.navigationController.viewControllers.count > 1) {
            NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
            if (index != NSNotFound) {
                UIViewController *vc = self.navigationController.viewControllers[index - 1];
                if (vc.navigationItem.backBarButtonItem.title) {
                    title = vc.navigationItem.backBarButtonItem.title;
                }else {
                    title = vc.navigationItem.title;
                }
            }
        }else {
            title = @"";
        }
    }
    
    return title;
}

- (void)setLeftBarButtonItemTitle:(NSString *)leftBarButtonItemTitle {
    objc_setAssociatedObject(self, leftBarButtonItemTitleKey, leftBarButtonItemTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (_leftBarButtonItemBlock)leftBarButtonItemBlock {
    return objc_getAssociatedObject(self, leftBarButtonItemBlockKey);
}

- (void)setLeftBarButtonItemBlock:(_leftBarButtonItemBlock)leftBarButtonItemBlock {
    objc_setAssociatedObject(self, leftBarButtonItemBlockKey, leftBarButtonItemBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)leftBarButtonItemImageName {
    return objc_getAssociatedObject(self, leftBarButtonItemImageNameKey);
}

- (void)setLeftBarButtonItemImageName:(NSString *)leftBarButtonItemImageName {
    objc_setAssociatedObject(self, leftBarButtonItemImageNameKey, leftBarButtonItemImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)noArrow {
    NSNumber *number = objc_getAssociatedObject(self, noArrowKey);
    if (number) {
        return number.boolValue;
    }
    return NO;
}

- (void)setNoArrow:(BOOL)noArrow {
    objc_setAssociatedObject(self, noArrowKey, @(noArrow), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - rightBarButtonItem

- (NSString *)rightBarButtonItemTitle {
    return objc_getAssociatedObject(self, rightBarButtonItemTitleKey);
}

- (void)setRightBarButtonItemTitle:(NSString *)rightBarButtonItemTitle {
    objc_setAssociatedObject(self, rightBarButtonItemTitleKey, rightBarButtonItemTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (_rightBarButtonItemBlock)rightBarButtonItemBlock {
    return objc_getAssociatedObject(self, rightBarButtonItemBlockKey);
}

- (void)setRightBarButtonItemBlock:(_rightBarButtonItemBlock)rightBarButtonItemBlock {
    objc_setAssociatedObject(self, rightBarButtonItemBlockKey, rightBarButtonItemBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)rightBarButtonItemImageName {
    return objc_getAssociatedObject(self, rightBarButtonItemImageNameKey);
}

- (void)setRightBarButtonItemImageName:(NSString *)rightBarButtonItemImageName {
    objc_setAssociatedObject(self, rightBarButtonItemImageNameKey, rightBarButtonItemImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
