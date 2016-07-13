//
//  ElectricityDatePickerView.h
//  TimerDemo
//
//  Created by asdc-macpc08 on 15/1/28.
//  Copyright (c) 2015年 asdc-macpc08. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol electDatePickerDelegate <NSObject>
- (void)datePickerSelect:(NSString *)Time_string;
@end

typedef void (^ElectDatePickerBlock) (NSString *dateStr);

@interface ElectricityDatePickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSString *year_string;
    NSString *month_string;
    NSString *day_string ;
    
    UIView *maskView; //
    UIView *OneView; //黑色背景
    UIView *TwoView; //灰色背景
    UIImageView *selectImgView;//选中图片
    UIPickerView *picekr; //
}
@property(nonatomic, strong)NSDate *startDate;  // 显示开始时间
@property(nonatomic, strong)NSDate *endDate; // 最大时间
@property(nonatomic, strong)NSDate *selectedDate;  //选中时间 (一直选中)


//反回选定时间
@property (nonatomic , copy)ElectDatePickerBlock block  ;
@property(nonatomic, assign)id<electDatePickerDelegate>timeDelegate;

@end


/*                              方法一
 
 ElectricityDatePickerView *picker = [[ElectricityDatePickerView alloc] initWithFrame:self.view.bounds];
 picker.timeDelegate = self;
 [self.view addSubview:picker];
 
 //代理方法
 - (void)datePickerSelect:(NSString *)Time_string
 {
 NSLog(@"================================== %@ ================================",Time_string);
 }
 
 */




/*                                  方法二
 
        ElectricityDatePickerView *picker = [[ElectricityDatePickerView alloc] initWithFrame:self.view.bounds];
        picker.block = ^(NSString *dateStr){
            NSLog(@"%@", dateStr ) ;
        } ;
        [self.view addSubview:picker];

*/
