//
//  IFlyModel.m
//  讯飞语音
//
//  Created by sks on 16/7/21.
//  Copyright © 2016年 任草木. All rights reserved.
//

#import "IFlyModel.h"
#import "iflyMSC/IFlyMSC.h"


@implementation IFlyModel


+(void)create{
    
    //显示SDK的版本号
    NSLog(@"verson=%@",[IFlySetting getVersion]);
    
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:NO];
    
    //设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"5790b1c3"];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];

}

+ (void)openURLAct:(NSURL *)url
{
    [[IFlySpeechUtility getUtility] handleOpenURL:url];
}










@end
