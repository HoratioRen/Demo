

//
//  Person.m
//  ArraySort
//
//  Created by Lucien老师 on 16/4/6.
//  Copyright © 2016年 Lucien老师. All rights reserved.
//

#import "Person.h"

@implementation Person

//初始化方法
- (instancetype)initWithAge:(NSInteger)age andName:(NSString *)name {

    if (self = [super init]) {
        
        _age = age;
        _name = name;
    }
    
    return self;
}
// 类方法
+ (Person *)personWithAge:(NSInteger)age andName:(NSString *)name {

    Person *person = [[Person alloc] initWithAge:age andName:name];
    return person;
}

- (NSInteger)age {

    return _age;
}

- (NSString *)name {

    return _name;
}

- (NSString *)description {

    NSString *des = [NSString stringWithFormat:@"_age = %ld  _name = %@",_age,_name];
    return des;
}

@end







