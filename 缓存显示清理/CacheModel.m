//
//  CacheModel.m
//  YZProj
//
//  Created by PG on 16/6/3.
//  Copyright © 2016年 PG. All rights reserved.
//

#import "CacheModel.h"
@implementation CacheModel



#pragma mark - 计算缓存
+ (CGFloat)totalByte
{
    NSString *totalPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *totalArray = [fileManager subpathsOfDirectoryAtPath:totalPath error:nil];
    
    CGFloat sumSize = 0;
    
    for (NSString *subNameStr in totalArray) {
        
        NSString *subFielPath = [totalPath stringByAppendingPathComponent:subNameStr];
        
        //        NSLog(@"111 : %@",subFielPath);
        
        NSDictionary *dic = [fileManager attributesOfItemAtPath:subFielPath error:nil];
        
        NSNumber *size = [dic objectForKey:NSFileSize];
        
        //        NSLog(@"222    %@",size);
        
        sumSize += size.longValue;
        
    }
    
    NSLog(@"ddd   %f",sumSize);
    
    CGFloat f =  sumSize/1024.0/1024.0;
    
    NSLog(@"总大小  %.5fM",f);
    
    return f ;
    
}

#pragma mark - 清空缓存
+ (void)clearSandbox
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    
    NSArray *subFileArray = [fileManager subpathsOfDirectoryAtPath:filePath error:nil];
    
    for (NSString *subString  in subFileArray) {
        
        NSString *subFilePath = [filePath stringByAppendingPathComponent:subString];
        
        NSLog(@"dddd     %@",subFilePath);
        
        BOOL success = [fileManager removeItemAtPath:subFilePath error:nil];
        
        if (success) {
            
            NSLog(@"perfected");
        }
    }
}




@end
