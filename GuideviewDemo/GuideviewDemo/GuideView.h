//
//  GuideView.h
//  GuideviewDemo
//
//  Created by 丁巍巍 on 2019/1/23.
//  Copyright © 2019年 丁巍巍. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^FinishBlock)(void);

typedef NS_ENUM(NSInteger, GuideViewType) {
    GuideViewTypePad = 0,     //拨号盘
    GuideViewTypeCreditIcon = 1,  //右上角图标
    GuideViewTypetCreditTab = 2,  //tabbar图标
};

extern NSString * const GuideViewPadKey;
extern NSString * const GuideViewCreditIconKey;
extern NSString * const GuideViewCreditTabKey;

@interface GuideView : UIView

// 获取单例
+ (instancetype)shareManager;

/**
 显示方法
 
 @param type 指引页类型
 */
- (void)showGuidePageWithType:(GuideViewType)type;

/**
 显示方法
 
 @param type 指引页类型
 @param completion 完成时回调
 */
- (void)showGuidePageWithType:(GuideViewType)type completion:(FinishBlock)completion;

@end

NS_ASSUME_NONNULL_END
