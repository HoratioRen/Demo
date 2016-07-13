//
//  ElectricityCityPickerView.h
//  TimerDemo
//
//  Created by asdc-macpc08 on 15/1/28.
//  Copyright (c) 2015年 asdc-macpc08. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CityOneStyle,
    CityTwoStyle,
    CityThreeStyle
} MuchCityType;



@protocol electCityPickerDelegate <NSObject>
- (void)CityPickerSelect:(NSString *)City_Name idssss:(NSString *)idString;
@end


@interface ElectricityCityPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIView *maskView; //
    UIView *OneView; //黑色背景
    UIView *TwoView; //灰色背景
    UIImageView *selectImgView;//选中图片
    UIPickerView *picekr; //

    NSArray *_data; //城市数据
    
    NSString *_oneCity ;    // 省份
    NSString *_twoCity;     // 城市
    NSString *_threeCity;   // 地区
    NSString *_oneID;       // 省份ID
    NSString *_twoID;       // 城市id
    NSString *_threeID;     // 地区id
    
    NSArray *_stateArray;
    NSArray *_cityArray;
    NSArray *_areaArray;
}

@property(nonatomic)MuchCityType modeStyle;

@property(nonatomic, assign)id<electCityPickerDelegate>CityDelegate;

@property(nonatomic, strong)NSArray *totalArray;

@property(nonatomic, assign)BOOL isEnble; //没有取消事件

@end


/*
       用法：
 
         ElectricityCityPickerView *picker = [[ElectricityCityPickerView alloc] initWithFrame:self.view.bounds];
         picker.modeStyle = CityThreeStyle;
         picker.CityDelegate = self;
         [self.view addSubview:picker];

 
 //代理方法/
- (void)CityPickerSelect:(NSString *)City_string;
{
    NSLog(@"================================== %@ ================================",City_string);
}



 */