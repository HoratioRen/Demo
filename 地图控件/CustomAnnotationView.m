//
//  CustomAnnotationView.m
//  地图
//
//  Created by sks on 16/7/20.
//  Copyright © 2016年 任草木. All rights reserved.
//

#import "CustomAnnotationView.h"
#define kCalloutWidth       200.0
#define kCalloutHeight      70.0
#import "CustomCalloutView.h"


@interface CustomAnnotationView ()
@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end


@implementation CustomAnnotationView


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
   
    if (self.selected == selected)
    {
        return;
    }

    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                      -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
    
        self.calloutView.image = [UIImage imageNamed:@"123"];
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle = self.annotation.subtitle;
    
        [self addSubview:self.calloutView];
        
    }else{
        [self.calloutView removeFromSuperview];
    }
    
    
}



@end
