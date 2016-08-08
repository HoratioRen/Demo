//
//  CustomCalloutView.h
//  地图
//
//  Created by sks on 16/7/20.
//  Copyright © 2016年 任草木. All rights reserved.
//

#import <UIKit/UIKit.h>
//气泡类
@interface CustomCalloutView : UIView

@property (nonatomic, strong) UIImage *image; //商户图
@property (nonatomic, copy) NSString *title; //商户名
@property (nonatomic, copy) NSString *subtitle; //地址


@property (nonatomic, strong) UIImageView *portraitView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;


@end
