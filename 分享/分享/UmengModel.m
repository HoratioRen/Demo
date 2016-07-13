//
//  UmengModel.m
//  友盟分享
//
//  Created by David on 16/5/23.
//  Copyright © 2016年 育知同创. All rights reserved.
//

#import "UmengModel.h"
#import "UMSocial.h"


#import "UMSocialQQHandler.h"
static UmengModel *myModel = nil ;

@implementation UmengModel

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myModel = [[UmengModel alloc] init];
    });
    return myModel ;
}

- (void)umengInit
{
    [UMSocialData setAppKey:APPKey];
}

- (void)weichat_qq_sina
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:APPKey];
    //设置微信AppId、appSecret，分享url
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    

    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}


/**
 *  qq分享 
 *  content : 分行啊内容
 *  img : 分享图片
 */
- (void)shareQQ:(NSString *)content image:(id)img
{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:content image:img location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}




@end
