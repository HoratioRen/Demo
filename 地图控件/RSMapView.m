//
//  RSMapView.m
//  地图
//
//  Created by sks on 16/7/20.
//  Copyright © 2016年 任草木. All rights reserved.
//

#import "RSMapView.h"
#import <MAMapKit/MAMapKit.h>
#import "CustomAnnotationView.h"

@interface RSMapView ()<MAMapViewDelegate>
{
    MAMapView * _mapView;
}
@end

@implementation RSMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//      1.显示地图
        [self createMap];
//    2.定位
        [self dingwei];
//    3.自定义定位图层
        [self dingweituceng];
//    4.大头针
        [self datouzhen];
//    5.自定义大头针
//        [self datouzhen];
        
//    6.其他设置
        [self setup];
        
        
    }
    return self;
}
#pragma mark ---- 创建地图

-(void)createMap{

    //    1.显示地图   #import <MAMapKit/MAMapKit.h>    协议：MAMapViewDelegate
    _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
    _mapView.delegate = self;
    _mapView.mapType = MAMapTypeStandard;       //地图类型（常规，卫星）
    _mapView.showTraffic= YES;                  //显示交通
    
    [self addSubview:_mapView];


}




#pragma mark -----定位
//2.定位
-(void)dingwei{
    
    //    info.plist添加NSLocationWhenInUseUsageDescription或NSLocationAlwaysUsageDescription字段
    
    _mapView.showsUserLocation = YES;
    
    /*
     NSLocationWhenInUseUsageDescription表示应用在前台的时候可以搜到更新的位置信息。
     NSLocationAlwaysUsageDescription表示应用在前台和后台（suspend或terminated)都可以获取到更新的位置数据。
     */
    
}

//2.当位置更新时，会进定位回调，通过回调函数，能获取到定位点的经纬度坐标，示例代码如下：
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

#pragma mark ---- 定位图层
-(void)dingweituceng{
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    
    
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    [_mapView setZoomLevel:16.1 animated:YES];
    
}


//3.自定义定位标注和精度圈的样式
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor clearColor];
        pre.strokeColor = [UIColor greenColor];
        pre.image = [UIImage imageNamed:@"123"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }
}






#pragma mark ------- 大头针

-(void)datouzhen{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(40.063278, 116.346880);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    
    [_mapView addAnnotation:pointAnnotation];
    
}

////实现 <MAMapViewDelegate> 协议中的 mapView:viewForAnnotation:回调函数，设置标注样式。
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorGreen;
//        
//        //  自定义大头针图片
//        //        annotationView.image = [UIImage imageNamed:@"restaurant"];
//        //        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        //        annotationView.centerOffset = CGPointMake(0, -18);
//        
//        return annotationView;
//    }
//    return nil;
//}
#pragma mark ---- 自定义大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
                annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
                annotationView.draggable = YES;        //设置标注可以拖动，默认为NO

        annotationView.image = [UIImage imageNamed:@"123"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = YES;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}


/**
 *  截图
 *
 *  @param rect 在地图的某个位置截图
 *
 *  @return 获得的截图
 */
-(void)clipImage:(CGRect)rect ImgView:(id)imgView{

    __block UIImage *screenshotImage = nil;
    [_mapView takeSnapshotInRect:rect withCompletionBlock:^(UIImage *resultImage, CGRect rect) {
        
        screenshotImage = resultImage;
        UIImageView * hsa = (UIImageView *)imgView;
        hsa.image = screenshotImage;
       
        NSLog(@"-----%@",screenshotImage);
    }];

}





#pragma mark ---- 其他功能
/**
 *  设置高德logo位置，
 指南针显示、位置，
 比例尺显示、位置
 设置地图手势
 */
-(void)setup{
    
    //地图Logo位置
    _mapView.logoCenter = CGPointMake(CGRectGetWidth(self.bounds)-55, 450);
    //指南针
    _mapView.showsCompass= YES; // 设置成NO表示关闭指南针；YES表示显示指南针
    
    _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 22); //设置指南针位置
    //比例尺
    _mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
    
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22);  //设置比例尺位置
    
    //地图手势
    //    _mapView.zoomEnabled = NO;    //NO表示禁用缩放手势，YES表示开启
    //  _mapView.scrollEnabled = NO;    //NO表示禁用滑动手势，YES表示开启
    //    地图平移时，缩放级别不变，可通过改变地图的中心点来移动地图，示例代码如下：
    //    [_mapView setCenterCoordinate:center animated:YES];
    
}












@end
