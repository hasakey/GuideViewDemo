//
//  GuideView.m
//  GuideviewDemo
//
//  Created by 丁巍巍 on 2019/1/23.
//  Copyright © 2019年 丁巍巍. All rights reserved.
//

//Frame区域
#define SCHeight [UIScreen mainScreen].bounds.size.height
#define SCWidth  [UIScreen mainScreen].bounds.size.width
#define SCMainBounds  [UIScreen mainScreen].bounds
#define SCFrame(x,y,w,h) CGRectMake(x, y, w, h)

#define IS_IPHONEX (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896))||CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)))

#import "GuideView.h"
#import "AppDelegate.h"


NSString * const GuideViewPadKey = @"GuideViewPadKey";
NSString * const GuideViewCreditIconKey = @"GuideViewCreditIconKey";
NSString * const GuideViewCreditTabKey = @"GuideViewCreditTabKey";

@interface GuideView ()

@property (nonatomic, copy) FinishBlock finish;
@property (nonatomic, copy) NSString *guidePageKey;
@property (nonatomic, assign) GuideViewType guidePageType;

@end

@implementation GuideView

+ (instancetype)shareManager
{
    static GuideView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)showGuidePageWithType:(GuideViewType)type
{
    [self creatControlWithType:type completion:nil];
}

- (void)showGuidePageWithType:(GuideViewType)type completion:(FinishBlock)completion
{
    [self creatControlWithType:type completion:completion];
}

- (void)creatControlWithType:(GuideViewType)type completion:(FinishBlock)completion
{
    _finish = completion;
    
    // 遮盖视图
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    
    UILabel *knowLabel = [UILabel new];
    knowLabel.userInteractionEnabled = YES;
    [knowLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    knowLabel.backgroundColor = [UIColor whiteColor];
    knowLabel.text = @"I Know";
    knowLabel.textColor = [UIColor whiteColor];
    knowLabel.textAlignment = NSTextAlignmentCenter;
    knowLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:177/255.0 blue:34/255.0 alpha:1.0];
    knowLabel.layer.cornerRadius = 2;
    knowLabel.layer.masksToBounds = YES;
    knowLabel.font = [UIFont systemFontOfSize:14];
    
    
    UIImageView *tipImg = [UIImageView new];
    
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    [bgView addSubview:knowLabel];
    [bgView addSubview:tipImg];
    CGFloat pathx ;
    CGFloat pathy ;
    CGFloat pathWidth ;
    CGFloat pathHight ;
    
    
    // 第一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    switch (type) {
            
            //UIBarButtonItem距离屏幕边缘 15
            
        case GuideViewTypePad:
            // 下一个路径，拨号键
            pathx = SCWidth - 128;
            pathy = IS_IPHONEX?44:20;
            pathWidth = 40;
            pathHight = 40;
            [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:SCFrame(pathx, pathy, pathWidth, pathHight) cornerRadius:4] bezierPathByReversingPath]];
            tipImg.image = [UIImage imageNamed:@"making-global-calls"];
            tipImg.frame = SCFrame(SCWidth - 117 - 180, pathy + 9, 180, 84);
            knowLabel.frame = SCFrame(CGRectGetMinX(tipImg.frame) + 36, CGRectGetMaxY(tipImg.frame) + 49, 109, 36);
            _guidePageKey = GuideViewPadKey;
            break;
            
        case GuideViewTypeCreditIcon:
            // 下一个路径，右上角图标
            pathx = SCWidth - 92;
            pathy = IS_IPHONEX?44:20;
            pathWidth = 88;
            pathHight = 40;
            [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:SCFrame(pathx, pathy, pathWidth, pathHight) cornerRadius:4] bezierPathByReversingPath]];
            tipImg.image = [UIImage imageNamed:@"call-credit"];
            tipImg.frame = SCFrame(SCWidth - 65 - 116, pathy + 22, 116, 71);
            knowLabel.frame = SCFrame(CGRectGetMinX(tipImg.frame) + 4, CGRectGetMaxY(tipImg.frame) + 49, 109, 36);
            _guidePageKey = GuideViewCreditIconKey;
            break;
        case GuideViewTypetCreditTab:
            // 下一个路径，tabbar按钮
            pathx = (SCWidth - 88)/2;
            pathy = SCHeight - 54 - (IS_IPHONEX?34:0);
            pathWidth = 88;
            pathHight = 54;
            [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:SCFrame(pathx, pathy, pathWidth, pathHight) cornerRadius:4] bezierPathByReversingPath]];
            tipImg.image = [UIImage imageNamed:@"free"];
            tipImg.frame = SCFrame(pathx-51, pathy -47, 197, 74);
            knowLabel.frame = SCFrame(CGRectGetMinX(tipImg.frame) + 45,  CGRectGetMinY(tipImg.frame) - 49 - 36, 109, 36);
            _guidePageKey = GuideViewCreditTabKey;
            break;
            
        default:
            break;
    }
    
    // 绘制透明区域
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [bgView.layer setMask:shapeLayer];
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    UILabel *knowLabel = (UILabel *)recognizer.view;
    UIView *bgView = knowLabel.superview;
    [bgView removeFromSuperview];
    [[bgView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    bgView = nil;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_guidePageKey];
    
    if (_finish) _finish();
}

@end

