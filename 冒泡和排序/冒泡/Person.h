//
//  Person.h
//  ArraySort
//
//  Created by Lucien老师 on 16/4/6.
//  Copyright © 2016年 Lucien老师. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSInteger _age;//年龄
    NSString *_name;//姓名
}
//初始化方法
- (instancetype)initWithAge:(NSInteger)age andName:(NSString *)name;
// 类方法
+ (Person *)personWithAge:(NSInteger)age andName:(NSString *)name;

- (NSInteger)age;


- (NSString *)name;

@end









