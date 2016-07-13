//
//  CacheModel.h
//  YZProj
//
//  Created by PG on 16/6/3.
//  Copyright © 2016年 PG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface CacheModel : NSObject

//计算缓存
+ (CGFloat)totalByte ;
//清空缓存
+ (void)clearSandbox ;

@end
