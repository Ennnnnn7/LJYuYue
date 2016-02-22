//
//  NavigationViewController.m
//  text
//
//  Created by lanou3g on 15/9/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NavigationViewController.h"
#import "MeunTableViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "REFrostedViewController.h"

@interface NavigationViewController ()

@property (nonatomic , strong , readwrite) MeunTableViewController *menuVC;

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    self.navigationBar.barTintColor= [UIColor colorWithRed:0.1 green:0.7 blue:0.9 alpha:1];
}

- (void)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.frostedViewController panGestureRecognized:sender];
}

@end
