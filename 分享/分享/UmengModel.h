//
//  UmengModel.h
//  友盟分享
//
//  Created by David on 16/5/23.
//  Copyright © 2016年 育知同创. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UmengModel : NSObject


+ (instancetype)shareInstance ;

- (void)umengInit ;

- (void)weichat_qq_sina ;


- (void)shareQQ:(NSString *)content image:(id)img ;
- (void)shareWeichat:(NSString *)content ;
- (void)shareWeibo:(NSString *)content ;



@end
