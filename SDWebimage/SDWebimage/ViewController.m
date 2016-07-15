//
//  ViewController.m
//  SDWebimage
//
//  Created by sks on 16/7/14.
//  Copyright © 2016年 任草木. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSString * picURLStr = @"http://pic51.nipic.com/file/20141016/24066_130156779281_2.jpg";
    UIImageView * imgView  = [[UIImageView alloc]initWithFrame:CGRectZero];
    imgView.backgroundColor = [UIColor redColor];
    imgView.layer.borderColor = [UIColor redColor].CGColor;
    imgView.layer.borderWidth = 2;
    
    
//    [imgView sd_setImageWithURL:[NSURL URLWithString:picURLStr] placeholderImage:nil
//     
//                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                           imgView.frame = CGRectMake(99, 99, 120, 199);
//
//                          
//                          
//                      }];
    
//  图片下载进度
    [imgView sd_setImageWithURL:[NSURL URLWithString:picURLStr] placeholderImage:nil options:0|1|2|3|4|5|6|7|8  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
//        NSLog(@"%ld------%ld------下载百分比%f",(long)receivedSize,(long)expectedSize, receivedSize*1.0/expectedSize*1.0);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        NSLog(@"%@",image);
        
        imgView.frame = CGRectMake(0, 99, image.size.width/3, image.size.height/3);
    }];
    
    
    

    [self.view addSubview:imgView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
