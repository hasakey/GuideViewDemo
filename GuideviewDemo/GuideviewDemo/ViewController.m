//
//  ViewController.m
//  GuideviewDemo
//
//  Created by 丁巍巍 on 2019/1/23.
//  Copyright © 2019年 丁巍巍. All rights reserved.
//

#import "ViewController.h"
#import "GuideView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showGuideview];
    
}

-(void)showGuideview
{
    //     判断是否已显示过
    if (![[NSUserDefaults standardUserDefaults] boolForKey:GuideViewPadKey]) {
        // 显示
        [[GuideView shareManager] showGuidePageWithType:GuideViewTypePad completion:^{
            [[GuideView shareManager] showGuidePageWithType:GuideViewTypeCreditIcon completion:^{
                [[GuideView shareManager] showGuidePageWithType:GuideViewTypetCreditTab completion:^{
                    //做一些要做的事情
                }];
            }];
        }];
    }
    
}


@end
