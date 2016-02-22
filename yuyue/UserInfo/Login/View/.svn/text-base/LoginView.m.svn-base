//
//  LoginView.m
//  yuyue
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoginView.h"
#import "LTView.h"

#define kLeft 20
#define kTop 20
#define kHorizonSpacing 10
#define kVercialSpacing 10
@implementation LoginView

// 添加控件
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat userNameX = kLeft;
        CGFloat userNameY = 2 *kTop + 44;
        CGFloat userNameWidth = kScreenWidth - 2 * kLeft;
        CGFloat userNameHeight = 40;
        CGRect rec1 = CGRectMake(userNameX, userNameY, userNameWidth, userNameHeight);
        
        _userName = [LTView ltViewWithFrame:rec1 labelWidth:80 horizonSpacing:10 text:@"用户名:" placeholder:@"请输入用户名"];
        _userName.textField.delegate = self;
        _userName.textField.tag = 100;
        [self addSubview:_userName];
        
        
        CGFloat pwdX = userNameX;
        CGFloat pwdY = userNameY + userNameHeight + kHorizonSpacing;
        CGFloat pwdWidth = userNameWidth;
        CGFloat pwdHeight = userNameHeight;
        CGRect rec2 = CGRectMake(pwdX, pwdY, pwdWidth, pwdHeight);
        
        _passWord = [LTView ltViewWithFrame:rec2 labelWidth:80 horizonSpacing:10 text:@"密码:" placeholder:@"请输入密码"];
        _passWord.textField.tag = 101;
        _passWord.textField.delegate = self;
        _passWord.textField.secureTextEntry = YES;
        [self addSubview:_passWord];
        
        CGFloat loginButtonX = userNameX;
        CGFloat loginButtonY = pwdY + pwdHeight + 2 * kHorizonSpacing;
        CGFloat loginButtonWidth =  0.45 * userNameWidth;
        CGFloat loginButtonHeight = userNameHeight + 10;
        CGRect rec3 = CGRectMake(loginButtonX, loginButtonY, loginButtonWidth, loginButtonHeight);
        
        _loginButton = [[UIButton alloc] initWithFrame:rec3];
        [_loginButton setTitle:@"登陆" forState:(UIControlStateNormal)];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _loginButton.backgroundColor = [UIColor greenColor];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 10;
        [self addSubview:_loginButton];
        
        
        CGFloat registButtonX = loginButtonX + loginButtonWidth + 3 * kHorizonSpacing;
        CGFloat registButtonY = loginButtonY;
        CGFloat registButtonWidth = loginButtonWidth;
        CGFloat registButtonHeight = loginButtonHeight;
        CGRect rec4 = CGRectMake(registButtonX, registButtonY, registButtonWidth, registButtonHeight);
        
        _registButton = [[UIButton alloc] initWithFrame:rec4];
        [_registButton setTitle:@"注册" forState:(UIControlStateNormal)];
        [_registButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _registButton.backgroundColor = [UIColor orangeColor];
        _registButton.layer.masksToBounds = YES;
        _registButton.layer.cornerRadius = 10;
        [self addSubview:_registButton];
        
        
        
        
    }
    return self;
}

// 键盘响应者
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 101) {
        return [textField resignFirstResponder];
    }else
    {
        // 说明 textField 不是tf4 让焦点跳转到tf4 tf4称为第一响应者
        UITextField *myTextField = (UITextField *)[self.superview.window viewWithTag:(textField.tag + 1)];
        [myTextField becomeFirstResponder];
        return YES;
    }
    
}

@end
