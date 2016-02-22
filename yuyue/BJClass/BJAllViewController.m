//
//  BJAllViewController.m
//  yuyue
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BJAllViewController.h"
#import "BJPictureViewController.h"
#import "BJTextTableViewController.h"
#import "NavigationViewController.h"
#import "FileHandle.h"
#import "Masonry.h"

@interface BJAllViewController ()
@property (nonatomic , strong ) BJPictureViewController *pictureVC;
@property (nonatomic , strong ) BJTextTableViewController *textTVC;
@property (nonatomic , strong ) UISegmentedControl *segment;
@end

@implementation BJAllViewController

- (BJPictureViewController *)pictureVC{
    if (!_pictureVC) {
        _pictureVC = [[BJPictureViewController alloc]init];
        [self addChildViewController:_pictureVC];
    }
    return _pictureVC;
}
- (BJTextTableViewController *)textTVC{
    if (!_textTVC) {
        _textTVC = [[BJTextTableViewController alloc]init];
    }
    return _textTVC;
}

- (UISegmentedControl *)segment{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc]initWithItems:@[@"娱文",@"娱图"]];
        _segment.frame = CGRectMake(0, 0, 150, 30);
        _segment.center = CGPointMake(self.navigationController.view.bounds.size.width/2, self.navigationController.navigationBar.bounds.size.height);
    }
    return _segment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cm2_list_icn_order"] style:(UIBarButtonItemStylePlain) target:(NavigationViewController *)self.navigationController action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self addChildViewController:self.textTVC];
    [self.view addSubview:self.textTVC.view];
    

    self.segment.tintColor = [UIColor whiteColor];
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(turn:) forControlEvents:UIControlEventValueChanged];
    [((NavigationViewController *)self.navigationController).view addSubview:self.segment];
}


#pragma mark - segment
- (void)turn:(UISegmentedControl *)segment{
    segment.selectedSegmentIndex ? ([self.textTVC.view removeFromSuperview],[self.textTVC removeFromParentViewController],[self addChildViewController:self.pictureVC],[self.view addSubview:self.pictureVC.view]) : ([self.pictureVC.view removeFromSuperview],[self.pictureVC removeFromParentViewController],[self addChildViewController:self.textTVC],[self.view addSubview:self.textTVC.view]) ;
}


@end
