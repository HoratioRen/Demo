//
//  ElectricityCityPickerView.m
//  TimerDemo
//
//  Created by asdc-macpc08 on 15/1/28.
//  Copyright (c) 2015年 asdc-macpc08. All rights reserved.
//

#import "ElectricityCityPickerView.h"

#import "UIViewExt.h"
#import "XMLReader.h"
#import "Api.h"
#define REMOVE_TIME 0.35
#define CANCELBTNTAG 121

#define WIDTHSS [UIScreen mainScreen].bounds.size.width
#define HEIGHTSS [UIScreen mainScreen].bounds.size.height

@implementation ElectricityCityPickerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isEnble = NO;
        
        _oneCity = [NSString string];
        _twoCity = [NSString string];
        _threeCity = [NSString string];
        
        _oneID = [NSString string];
        _twoID = [NSString string];
        _threeID = [NSString string];
        
        _stateArray = [NSArray array];
        _cityArray = [NSArray array];
        _areaArray = [NSArray array];

        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _data = self.totalArray;
    
    if (self.modeStyle != CityOneStyle)
    {

        /**
         *  初始化城市数组
         */
        NSDictionary *cityDic = [_data objectAtIndex:0];
        NSArray *cityArray = [cityDic objectForKey:@"city"];
        _cityArray = cityArray;
        /**
         *  初始化地区数组
         */
        NSDictionary *areaDIc = [_cityArray objectAtIndex:0];
        NSArray *areaArray = [areaDIc objectForKey:@"area"];
        _areaArray = areaArray;
    }
    
    
    /**
     *  mask view  1
     */
    if (!maskView)
    {
        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSS, HEIGHTSS )];
        maskView.backgroundColor = [UIColor lightGrayColor];
        maskView.alpha = .5;
        if (_isEnble != YES)
        {
            UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTap:)];
            [maskView addGestureRecognizer:maskTap];
        }
        [self addSubview:maskView];
    }
    
    
    
    /**
     *  黑色背景    2  total
     */
    if (!OneView)
    {
        OneView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTSS , WIDTHSS, 200)];
        OneView.backgroundColor = [UIColor colorWithRed:0.45f green:0.45f blue:0.46f alpha:1.00f];
        [self addSubview:OneView];
    }
    
    /**
     *  cancel button
     */
    if (_isEnble != YES)
    {
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(10, 7, 67, 27);
        cancelButton.backgroundColor = [UIColor colorWithRed:0.70f green:0.69f blue:0.70f alpha:1.00f];
        cancelButton.layer.cornerRadius = 5.0f;
        cancelButton.tag = CANCELBTNTAG;
        [cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [OneView addSubview:cancelButton];
    }
  
    
    /**
     *  enter button
     */
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterButton.frame = CGRectMake(WIDTHSS-10-67 , 7, 67, 27);
    enterButton.backgroundColor = [UIColor colorWithRed:0.38f green:0.76f blue:0.72f alpha:1.00f];
    enterButton.layer.cornerRadius = 5.0f;
    [enterButton setTitle:@"确 定" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    enterButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [enterButton addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
    [OneView addSubview:enterButton];
    

    /**
     *  灰白色背景      3
     */
    if (!TwoView)
    {
        TwoView = [[UIView alloc] initWithFrame:CGRectMake(10, 40, WIDTHSS-20, 140)];
        TwoView.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        TwoView.layer.cornerRadius = 5.0f;
        [OneView addSubview:TwoView];
    }
    
    /**
     *  选中长条
     */
    selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(TwoView.left-15 , 44 , TwoView.width+10 , 35 )];
    selectImgView.image = [UIImage imageNamed:@"picker"];
    [TwoView addSubview:selectImgView];
    [TwoView sendSubviewToBack:selectImgView];
    
    
    /**
     *  picker
     */
    if (!picekr)
    {
        picekr = [[UIPickerView alloc] initWithFrame:CGRectMake(0, -10 , TwoView.width , TwoView.height )];
        picekr.delegate = self;
        picekr.dataSource = self;
        picekr.backgroundColor = [UIColor clearColor];
        [TwoView addSubview:picekr];
    }
    
    
    [UIView animateWithDuration:REMOVE_TIME  animations:^{
        OneView.bottom = HEIGHTSS;
    }];
    
}



#pragma mark - 多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (self.modeStyle) {
        case CityOneStyle:
            return 1;
            break;
        case CityTwoStyle:
            return 2;
            break;
        case CityThreeStyle:
            return 3;
            break;
            
        default:
            break;
    }

}

#pragma mark - 多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            return _data.count;
        }
            
        case 1:
        {
            return _cityArray.count;
        }
            
        case 2:
        {
            return _areaArray.count;
        }
            
        default:
            break;
    }
    return 1;
}

#pragma mark - 自定义每一个cell样式
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *cityLabel = (UILabel *)view;
    if (!cityLabel) {
        cityLabel = [[UILabel alloc] init];
        [cityLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [cityLabel setTextColor:[UIColor blackColor]];
        [cityLabel setBackgroundColor:[UIColor clearColor]];
    }
    
    
    
    
    /****************************  只用一行的情况**************************** */
    if (self.modeStyle == CityOneStyle)
    {
        cityLabel.text = [self.totalArray objectAtIndex:row];
        cityLabel.textAlignment = NSTextAlignmentCenter;
        return cityLabel;
    }
    /************************************************************************/
    
    
    
    switch (component)
    {
        case 0: {
            NSDictionary *dic = _data[row];
            NSString *string = [dic objectForKey:@"name"];
            cityLabel.text = string;
            cityLabel.textAlignment = NSTextAlignmentCenter;
            
            _oneCity = string;
            _oneID = [dic objectForKey:@"id"];
            
            break;
        }
        case 1: {
            /**
             *  上海的时候，
             */
            if ([_cityArray objectAtIndex:row] && [_cityArray[row] isKindOfClass:[NSString class]])
            {
                NSString *cityStr = _cityArray[row];
                cityLabel.text = cityStr;
                cityLabel.textAlignment = NSTextAlignmentCenter;
                
                _twoCity = cityStr;
                break;
            }
            /**
             *  非直辖市
             */
            NSDictionary *cityDic = [_cityArray objectAtIndex:row];
            NSString *cityStr = [cityDic objectForKey:@"name"];
            cityLabel.text = cityStr;
            cityLabel.textAlignment = NSTextAlignmentCenter;
            
            _twoCity = cityStr;
            _twoID = [cityDic objectForKey:@"id"];
            
            break;
        }
        case 2: {
            NSDictionary *areaDic = [_areaArray objectAtIndex:row];
            NSString *name = [areaDic objectForKey:@"name"];
    
            cityLabel.text = name;
            cityLabel.textAlignment = NSTextAlignmentCenter;
            
            _threeCity = name;
            _threeID = [areaDic objectForKey:@"id"];
            
            break;
        }
        default:
            break;
    }
    
    return cityLabel;
}


#pragma mark - 选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    
    /****************************  只用一行的情况**************************** */
    if (self.modeStyle == CityOneStyle)
    {
        _oneCity = self.totalArray[row];
        [pickerView reloadAllComponents];
        return ;
    }
    /************************************************************************/
    
    
    
    
    
    
    
    
    
    switch (component)
    {
        case 0:
        {
            /**
             *  省份
             */
            NSDictionary *dic = _data[row];
            NSString *string = [dic objectForKey:@"name"];
          
            /**
             *
             */
            if ([dic objectForKey:@"city"] && [[dic objectForKey:@"city"] isKindOfClass:[NSArray class]]) {
                /**
                 *  城市数组
                 */
                NSArray *cityArr = [dic objectForKey:@"city"];
                _cityArray = cityArr;
                /**
                 *  地区数组
                 */
                NSDictionary *areaDic = [_cityArray objectAtIndex:0];
                NSArray *areaArr = [areaDic objectForKey:@"area"];
                _areaArray = areaArr;
            }else{
                /**
                 *  在上海的情况下 NSDictionary
                 */
                NSDictionary *cityDic = [dic objectForKey:@"city"];
                NSString *cityStr = [cityDic objectForKey:@"name"];
                _cityArray = @[cityStr];
                NSArray *areaArray = [cityDic objectForKey:@"area"];
                /**
                 *  地区数组
                 */
                _areaArray = areaArray;
                _twoID = [cityDic objectForKey:@"id"];
            }
            
            
            /**
             *  刷新
             */
            [pickerView  reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            
            /**
             *  当有3列的时候
             */
            if (self.modeStyle == CityThreeStyle)
            {
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
            }
            _oneCity = string;
            _oneID = [dic objectForKey:@"id"];

            break;
        }
        case 1:
        {

            if (_cityArray.count == 1)
            {
                break;
            }
            NSDictionary *cityDic = [_cityArray objectAtIndex:row];
            NSArray *areaArr = [cityDic objectForKey:@"area"];
            _areaArray = areaArr;
            
            NSString *cityStr = [cityDic objectForKey:@"name"];
            _twoCity = cityStr;
            _twoID = [cityDic objectForKey:@"id"];

            /**
             *  当有3列的时候
             */
            if (self.modeStyle == CityThreeStyle)
            {
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
            }
            break;
        }
        case 2:
        {

            NSDictionary *areaDic = [_areaArray objectAtIndex:row];
            NSString *name = [areaDic objectForKey:@"name"];
            _threeCity = name;
            _threeID = [areaDic objectForKey:@"id"];
            
            break;
        }
        default:
            break;
    }
    
    
    
    /**
     *  刷新
     */
    [pickerView reloadAllComponents];
    
}




#pragma mark - 每一栏的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 90;
            break;

        case 1:
            return 90;
            break;
            
        case 2:
            return 90;
            break;
            
        default:
            break;
    }
    return 0;
}




















#pragma mark - 点击消失
- (void)maskTap:(UITapGestureRecognizer *)tap
{
    [self removeView];
}
- (void)cancelAction
{
    [self removeView];
}
/***** remove *****/
- (void)removeView
{
    [UIView animateWithDuration:REMOVE_TIME animations:^{
        OneView.top = HEIGHTSS;
        maskView.alpha = 0;
    }];
    [self performSelector:@selector(removeAtion) withObject:self afterDelay:REMOVE_TIME];
}
- (void)removeAtion
{
    
    [picekr removeFromSuperview];
    [TwoView removeFromSuperview];
    [OneView removeFromSuperview];
    [maskView removeFromSuperview];
    picekr = nil;
    TwoView = nil;
    OneView = nil;
    maskView = nil;
    [self removeFromSuperview];
}


#pragma mark - 确定
- (void)enterAction
{
    NSString *selectString = [NSString string];
    NSString *idString = [NSString string];
    
    switch (self.modeStyle) {
        case CityOneStyle:
            selectString = [NSString stringWithFormat:@"%@", _oneCity];
            idString = [NSString stringWithFormat:@"%@",_oneID];
            break;
            
        case CityTwoStyle:
            selectString = [NSString stringWithFormat:@"%@-%@", _oneCity, _twoCity];
            idString = [NSString stringWithFormat:@"%@-%@",_oneID, _twoID];
            break;
            
        case CityThreeStyle:
            selectString = [NSString stringWithFormat:@"%@-%@-%@",_oneCity, _twoCity, _threeCity];
            idString = [NSString stringWithFormat:@"%@-%@-%@",_oneID, _twoID, _threeID];
            break;
            
        default:
            break;
    }
    
    if (self.CityDelegate && [self.CityDelegate respondsToSelector:@selector(CityPickerSelect:idssss:)])
    {
        [self.CityDelegate CityPickerSelect:selectString idssss:idString];
    }
    
    
    [self removeView];
    
    
    
    /**
     *  第一次登陆的时候
     */
    [self initFirst_run:selectString idss:idString];
    
}











/********************** 当第一次走的时候 ******************************/
- (void)initFirst_run:(NSString *)selectString idss:(NSString *)idString
{
    if (self.isEnble == YES)
    {
        //  NSLog(@",,,,,,,北京市－市辖区,,,,,%@,,,,,,,城市编号＝,%@",selectString , idString);
        //  引导页 key 值
        [[NSUserDefaults standardUserDefaults] setObject:@"yindao" forKey:@"yindaoye"];
        [[NSUserDefaults standardUserDefaults] synchronize];


        /**
         *  省份
         */
        if (idString && idString.length > 0)
        {
            /**
             *  id
             */
            NSArray *idArr      = [idString componentsSeparatedByString:@"-"];
            NSString *proID     = idArr[0];   // 省份id
            NSString *cityID    = idArr[1];   // 城市id
            /**
             *  名称
             */
            NSArray *nameArr = [selectString componentsSeparatedByString:@"-"];
            NSString *proName = nameArr[0];
            NSString *cityName = nameArr[1];
            
            
            
//            
//            RQSTDataObj *obj = [[RQSTDataObj alloc] init];
//            /**
//             *  省份
//             */
//            [RQSTDataObj saveStringDataToUserDefault:[obj getAreaCode2:proID] withKey:@"areaName3"]; // 5
//            [RQSTDataObj saveStringDataToUserDefault:proID withKey:@"areaName"];  //6
//            [RQSTDataObj saveStringDataToUserDefault:[RQSTDataObj getStringDataFromUserDefault:@"areaName3"] withKey:@"loginProvinceNo"];
//            /**
//             *  城市
//             */
//            [RQSTDataObj saveStringDataToUserDefault:cityID withKey:@"areaName2"];
//            [RQSTDataObj saveStringDataToUserDefault:cityName  withKey:@"cityName"];
//            
//            
//            /**
//             *  custom
//             */
//            [[NSUserDefaults standardUserDefaults] setObject:proName  forKey:NAMEPROVINCE];
//            [[NSUserDefaults standardUserDefaults] setObject:proID forKey:CURRENTSELECTPROVINCE];
//            [[NSUserDefaults standardUserDefaults] setObject:cityID forKey:CURRENTSELECTCITY];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        
    }
}
/*******************************************************************/


@end
