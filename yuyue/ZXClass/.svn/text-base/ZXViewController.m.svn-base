//
//  ZXViewController.m
//  yuyue
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ZXViewController.h"
#import "SisterViewController.h"
#import "HotVideoListViewController.h"
#import "NavigationViewController.h"

@interface ZXViewController ()
@property (nonatomic , strong ) SisterViewController *sisVC;
@property (nonatomic , strong ) HotVideoListViewController *hotVC;
@property (nonatomic , strong ) UISegmentedControl *segment;

@end

@implementation ZXViewController

- (SisterViewController *)sisVC {
    if (!_sisVC) {
        _sisVC = [[SisterViewController alloc]init];
    }
    return _sisVC;
}

- (HotVideoListViewController *)hotVC {
    if (!_hotVC) {
        _hotVC = [[HotVideoListViewController alloc]init];
    }
    return _hotVC;
}


- (UISegmentedControl *)segment{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc]initWithItems:@[@"最新",@"精品"]];
        _segment.frame = CGRectMake(0, 0, 150, 30);
        _segment.center = CGPointMake(self.navigationController.view.bounds.size.width/2, self.navigationController.navigationBar.bounds.size.height);
    }
    return _segment;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cm2_list_icn_order"] style:(UIBarButtonItemStylePlain) target:(NavigationViewController *)self.navigationController action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self addChildViewController:self.sisVC];
    [self.view addSubview:self.sisVC.view];
    
    self.segment.tintColor = [UIColor whiteColor];
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(turn:) forControlEvents:UIControlEventValueChanged];
    [((NavigationViewController *)self.navigationController).view addSubview:self.segment];
}

#pragma mark - segment
- (void)turn:(UISegmentedControl *)segment{
    segment.selectedSegmentIndex ? ([self.sisVC.view removeFromSuperview],[self.sisVC removeFromParentViewController],[self addChildViewController:self.hotVC],[self.view addSubview:self.hotVC.view]) : ([self.hotVC.view removeFromSuperview],[self.hotVC removeFromParentViewController],[self addChildViewController:self.sisVC],[self.view addSubview:self.sisVC.view]) ;

}

@end
