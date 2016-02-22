//
//  LoginView.h
//  yuyue
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTView;
@interface LoginView : UIView<UITextFieldDelegate>
@property (nonatomic,strong) LTView *userName;
@property (nonatomic,strong) LTView *passWord;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *registButton;
@end
