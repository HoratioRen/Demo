//
//  RSMapView.h
//  地图
//
//  Created by sks on 16/7/20.
//  Copyright © 2016年 任草木. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSMapView : UIView




/**
 *  截图赋值
 *
 *  @param rect    在地图上截取位置
 *  @param imgView 截取图片的用处(自行修改)
 */
-(void)clipImage:(CGRect)rect ImgView:(id)imgView;



/**
 *  设置高德logo位置，
    指南针显示、位置，
    比例尺显示、位置
    设置地图手势
 */
-(void)setup;







/*   用法
 RSMapView * map = [[RSMapView alloc]initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 300)];
 [self.view addSubview:map];
 */




@end
