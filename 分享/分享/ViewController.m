//
//  ViewController.m
//  分享
//
//  Created by sks on 16/7/12.
//  Copyright © 2016年 任草木. All rights reserved.
//

#import "ViewController.h"

#import "UMSocialControllerService.h"

@interface ViewController ()<UMSocialUIDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(99,99, 99, 99);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(sharedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];



    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(199,99, 99, 99);
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 addTarget:self action:@selector(customSharedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];









}


//需要自定义面板样式的开发者需要自己绘制UI，在对应的分享按钮中调用此接口
-(void)customSharedAction:(UIButton *)btn{

    [UMSocialData defaultData].extConfig.qqData.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                        @"http://www.baidu.com/img/bdlogo.gif"];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"分享内嵌文字" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];

}

-(void)sharedAction:(UIButton *)btn{

    [self loginQQ];
    [self sharedUM];
}




-(void)sharedUM{
//分享URL图片资源
//    当URL图片和UIImage同时存在时，只有URL图片生效
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com/img/bdlogo.gif"];
    
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:APPKey
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"2.png"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];


    
    
    
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

-(void)loginQQ{

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            
        }});

}

@end
