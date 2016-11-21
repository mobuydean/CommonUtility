//
//  UINavigationBar+Custom.h
//  Coach
//
//  Created by jianghao on 16/11/21.
//  Copyright © 2016年 oradt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Custom)
//这个是参考其他开源代码写的，具体哪个不记得了
- (void)ct_setBackgroundColor:(UIColor *)backgroundColor;
- (void)ct_setBackgroundColorWithCAGradientLayer:(CAGradientLayer *)gradientLayer;
- (void)ct_setElementsAlpha:(CGFloat)alpha;
- (void)ct_setTranslationY:(CGFloat)translationY;
- (void)ct_reset;

@end
