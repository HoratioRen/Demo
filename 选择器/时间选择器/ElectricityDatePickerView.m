//
//  ElectricityDatePickerView.m
//  TimerDemo
//
//  Created by asdc-macpc08 on 15/1/28.
//  Copyright (c) 2015年 asdc-macpc08. All rights reserved.
//

#import "ElectricityDatePickerView.h"
#import "UIViewExt.h"

#define WIDTHSS [UIScreen mainScreen].bounds.size.width
#define HEIGHTSS [UIScreen mainScreen].bounds.size.height

#define REMOVE_TIME 0.35
#define ScaleY  HEIGHTSS/568
@implementation ElectricityDatePickerView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    /**
     *  year month day
     */
    year_string = [NSString string];
    month_string = [NSString string];
    day_string = [NSString string];
    
    self.startDate = [self convertDateFromStringssssssssssssssssss:@"1-01-01"];
    self.endDate = [self convertDateFromStringssssssssssssssssss:@"9999-01-01"];
    
    /**
     *  当前时间
     */
    NSDate *now_date = [NSDate date];
    NSString *now_string = [self dateTostringsssssssssssssssssssssssss:now_date];
    NSArray *now_array = [now_string componentsSeparatedByString:@"-"];
    self.selectedDate = now_date;
    
    year_string = now_array[0];
    month_string = now_array[1];
    day_string = now_array[2];
    
    
    

    /**
     *  mask view     1
     */
    if (!maskView)
    {
        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSS, HEIGHTSS)];
        maskView.backgroundColor = [UIColor darkGrayColor];
        maskView.alpha = .5;
        UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTap:)];
        [maskView addGestureRecognizer:maskTap];
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
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(10, 7, 67, 27);
    cancelButton.backgroundColor = [UIColor colorWithRed:0.70f green:0.69f blue:0.70f alpha:1.00f];
    cancelButton.layer.cornerRadius = 5.0f;
    [cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [OneView addSubview:cancelButton];
    
    /**
     *  enter button
     */
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterButton.frame = CGRectMake(WIDTHSS-10-67 , 7, 67, 27);
    enterButton.backgroundColor = [UIColor colorWithRed:0.38f green:0.76f blue:0.72f alpha:1.00f];
    enterButton.layer.cornerRadius = 5.0f;
    [enterButton setTitle:@"确 定" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    enterButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
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
    selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(TwoView.left-15 , 43 , TwoView.width+10 , 35 )];
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
    

 
    /**
     *  picker 当前选择为
     */
    [picekr selectRow:[now_array[0] intValue]-1  inComponent:0 animated:NO];
    [picekr selectRow:[now_array[1] intValue]-1  inComponent:1 animated:NO];
    [picekr selectRow:[now_array[2] intValue]-1  inComponent:2 animated:NO];
    
    
    
    [UIView animateWithDuration:REMOVE_TIME  animations:^{
        OneView.bottom = HEIGHTSS;
    }];
    
}
     



#pragma mark - 多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

#pragma mark - 多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
            /**
             *  component是栏目index，从0开始，后面的row也一样是从0开始
             */
        case 0:
        {
            /**
             *  第一栏为年，这里startDate和endDate为起始时间和截止时间，请自行指定
             */
            NSDateComponents *startCpts = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                                                          fromDate:self.startDate];
            NSDateComponents *endCpts = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                                                        fromDate:self.endDate];
            /**
             *  最大年，最小年
             */
            //NSLog(@"--year = %ld",[endCpts year] - [startCpts year] + 1 );
            
            return [endCpts year] - [startCpts year] + 1;
        }
        case 1:
            /**
             *  第二栏为月份
             */
            return 12;
        case 2: {
            /**
             *  共有多少天
             */
            NSRange dayRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay
                                                                  inUnit:NSCalendarUnitMonth
                                                                 forDate:self.selectedDate ];
            return dayRange.length;
        }
        default:
            return 0;
    }
}

#pragma mark - 自定义每一个cell样式
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *dateLabel = (UILabel *)view;
    if (!dateLabel) {
        dateLabel = [[UILabel alloc] init];
        [dateLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [dateLabel setTextColor:[UIColor blackColor]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
    }
    
    switch (component) {
        case 0: {
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                                                           fromDate:self.startDate];
            
            NSString *currentYear = [NSString stringWithFormat:@"%ld", [components year] + row];
            [dateLabel setText:currentYear];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            break;
        }
        case 1: {
            // 返回月份可以用DateFormatter，这样可以支持本地化
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            //简体中文
            NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            formatter.locale = locale;
            NSArray *monthSymbols = [formatter monthSymbols];
            [dateLabel setText:[monthSymbols objectAtIndex:row]];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            break;
        }
        case 2: {
            NSRange dateRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay
                                                                   inUnit:NSCalendarUnitMonth
                                                                  forDate:self.selectedDate];
            
            NSString *currentDay = [NSString stringWithFormat:@"%02lu", (row + 1) % (dateRange.length + 1)];
            [dateLabel setText:currentDay];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            break;
        }
        default:
            break;
    }
    
    return dateLabel;
}


#pragma mark - 选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    switch (component)
    {
        case 0: {
            NSDateComponents *indicatorComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                                                                    fromDate:self.startDate];
            
            NSInteger year = [indicatorComponents year] + row;
            
            NSDateComponents *targetComponents = [[NSCalendar currentCalendar] components:unitFlags
                                                                                 fromDate:nil ];
            [targetComponents setYear:year];
            
            year_string = [NSString stringWithFormat:@"%ld",(long)year];
            
            break;
        }
        case 1: {
            
            NSDateComponents *targetComponents = [[NSCalendar currentCalendar] components:unitFlags
                                                                                 fromDate:nil ];
            [targetComponents setMonth:row + 1];
            
            month_string = [NSString stringWithFormat:@"%ld",row+1];
            
            NSString *yearMonthString = [NSString stringWithFormat:@"%@-%@-01",year_string, month_string];
            NSRange dayRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay
                                                                  inUnit:NSCalendarUnitMonth
                                                                 forDate:[self convertDateFromStringssssssssssssssssss:yearMonthString]];
            if (day_string.intValue > dayRange.length)
            {
                //NSLog(@"----range.length-- %ld -----",(unsigned long)dayRange.length);
                [pickerView selectRow:dayRange.length inComponent:2 animated:YES];
                day_string = [NSString stringWithFormat:@"%ld",(unsigned long)dayRange.length];
            }
            
            break;
        }
        case 2: {
            
            NSDateComponents *targetComponents = [[NSCalendar currentCalendar] components:unitFlags
                                                                                 fromDate:nil ];
            [targetComponents setDay:row + 1];
            
            day_string = [NSString stringWithFormat:@"%ld",row+1];
            
            break;
        }
        default:
            break;
    }
    
   
   
    /**
     *  如果月份是单数
     */
    if (month_string.length == 1)
    {
        month_string = [NSString stringWithFormat:@"0%@",month_string];
    }
    /**
     *  如果日期是单数
     */
    if (day_string.length == 1)
    {
        day_string = [NSString stringWithFormat:@"0%@",day_string];
    }
    /**
     *  选择超出当前时间，picker设置成当前时间
     */
    NSString *seleStr = [NSString stringWithFormat:@"%@%@%@",year_string, month_string, day_string];
    NSString *currStr = [self dateToStr_int:[NSDate date]];
    NSDate *currDate =  [NSDate date];
    NSString *cust =    [self dateTostringsssssssssssssssssssssssss:currDate];
    NSArray *cuArr =    [cust componentsSeparatedByString:@"-"];
    
    if (seleStr.intValue > currStr.intValue)
    {
        year_string = cuArr[0];
        month_string = cuArr[1];
        day_string = cuArr[2];
        
        [pickerView selectRow:[cuArr[0] intValue]-1 inComponent:0 animated:YES];
        [pickerView selectRow:[cuArr[1] intValue]-1 inComponent:1 animated:YES];
        [pickerView selectRow:[cuArr[2] intValue]-1 inComponent:2 animated:YES];
    }
    
    /**
     *  选择后
     */
    NSString *now_String = [NSString stringWithFormat:@"%@-%@-%@",year_string, month_string, day_string];
    NSDate *now_date = [self convertDateFromStringssssssssssssssssss:now_String];
    self.selectedDate = now_date;
    NSLog(@"当前的选择时间 ＝ %@", [self dateTostringsssssssssssssssssssssssss:self.selectedDate]);
    
    
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
            return 50.0f;
            break;
            
        case 1:
            return 160.0f;
            break;
            
        case 2:
            return 50.0f;
            break;
            
        default:
            break;
    }
    return 0;
}


/*******************************************************************************************************                               date ------> string     string ------> date
******************************************************************************************************************************************************************************************************************************************************************/
#pragma mark - NSString -> NSDate
- (NSDate*)convertDateFromStringssssssssssssssssss:(NSString*)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:uiDate];
    return date;
}


- (NSString *)dateTostringsssssssssssssssssssssssss:(NSDate *)selectDate
{
    NSDateFormatter *selectDateFormater = [[NSDateFormatter alloc] init];
    [selectDateFormater setDateFormat:@"yyyy-MM-dd"];
    NSString *selectDataString = [selectDateFormater stringFromDate:selectDate];
    return selectDataString;
}

#pragma mark --------------------
- (NSString *)dateToStr_int:(NSDate *)date
{
    NSDateFormatter *selectDateFormater = [[NSDateFormatter alloc] init];
    [selectDateFormater setDateFormat:@"yyyyMMdd"];
    NSString *selectDataString = [selectDateFormater stringFromDate:date];
    return selectDataString;
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
    NSString *selectTimeString = [self dateTostringsssssssssssssssssssssssss:self.selectedDate];
    if (selectTimeString.length<=0 || [selectTimeString isEqualToString:@""])
    {
        selectTimeString = [self dateTostringsssssssssssssssssssssssss:[NSDate date]];
    }
    
    if (self.timeDelegate && [self.timeDelegate respondsToSelector:@selector(datePickerSelect:)])
    {
        [self.timeDelegate datePickerSelect:selectTimeString];
    }
    
    if (self.block) {
        self.block(selectTimeString) ;
    }
    
    [self removeView];
    
}





@end
