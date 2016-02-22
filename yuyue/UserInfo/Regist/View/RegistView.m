//
//  RegistView.m
//  yuyue
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RegistView.h"
#import "LTView.h"

#define kLeft 40
#define kLabelWidth 90
#define kLTViewHeight 30
#define kHorizonSpacing 10
#define kLTViewWidth kScreenWidth - 80

@interface RegistView ()<UITextFieldDelegate>
@end
@implementation RegistView

// 头像 ImageView

- (UIImageView *)headImageView
{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.4, kScreenWidth * 0.4)];
        _headImageView.center = CGPointMake(self.center.x, self.center.y - KScreenHeight * 0.2);
        _headImageView.layer.cornerRadius = _headImageView.frame.size.width * 0.5;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.image = [UIImage imageNamed:@"picholder"];
        _headImageView.userInteractionEnabled = YES;
        [self addSubview:_headImageView];
    }
    return _headImageView;
}

// 用户名
- (LTView *)userNameLTView
{
    if (_userNameLTView ==nil) {
        _userNameLTView = [[LTView alloc] initWithFrame:CGRectMake(kLeft, CGRectGetMaxY(self.headImageView.frame) + 30, kLTViewWidth, kLTViewHeight) labelWidth:kLabelWidth horizonSpacing:10 text:@"用户名:" placeholder:@"请输入英文用户名"];
        _userNameLTView.textField.keyboardType = UIKeyboardTypeDefault;
        _userNameLTView.textField.delegate = self;
        _userNameLTView.textField.tag = 100;
        [self addSubview:_userNameLTView];
    }
    return _userNameLTView;
}

// 密码
- (LTView *)passWordLTView
{
    if (_passWordLTView == nil) {
        _passWordLTView = [[LTView alloc] initWithFrame:CGRectMake(kLeft, CGRectGetMaxY(self.userNameLTView.frame) + 20, kLTViewWidth, kLTViewHeight) labelWidth:kLabelWidth horizonSpacing:kHorizonSpacing text:@"密码:" placeholder:@"请输入密码"];
        _passWordLTView.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _passWordLTView.textField.secureTextEntry = YES;
        _passWordLTView.textField.delegate = self;
        _passWordLTView.textField.tag = 101;
        [self addSubview:_passWordLTView];
        
        
    }
    return _passWordLTView;
}

// 确认密码
- (LTView *)affirmPassWordLTView
{
    if (_affirmPassWordLTView == nil) {
        _affirmPassWordLTView = [[LTView alloc] initWithFrame:CGRectMake(kLeft, CGRectGetMaxY(self.passWordLTView.frame) + 20, kLTViewWidth, kLTViewHeight) labelWidth:kLabelWidth horizonSpacing:kHorizonSpacing text:@"确认密码:" placeholder:@"请再次输入密码"];
        _affirmPassWordLTView.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _affirmPassWordLTView.textField.secureTextEntry = YES;
        _affirmPassWordLTView.textField.delegate = self;
        _affirmPassWordLTView.textField.tag = 102;
        [self addSubview:_affirmPassWordLTView];
    }
    return _affirmPassWordLTView;
}

// 邮箱地址
- (LTView *)mailLTView
{
    if (_mailLTView == nil) {
        _mailLTView = [[LTView alloc] initWithFrame:CGRectMake(kLeft, CGRectGetMaxY(self.affirmPassWordLTView.frame) + 20, kLTViewWidth, kLTViewHeight) labelWidth:kLabelWidth horizonSpacing:kHorizonSpacing text:@"邮箱:" placeholder:@"请输入邮箱"];
        _mailLTView.textField.keyboardType = UIKeyboardTypeEmailAddress;
        _mailLTView.textField.delegate = self;
        _mailLTView.textField.tag = 103;
        [self addSubview:_mailLTView];
    }
    return _mailLTView;
}

// 联系方式
- (LTView *)numLTView
{
    if (_numLTView == nil) {
        _numLTView = [[LTView alloc] initWithFrame:CGRectMake(kLeft, CGRectGetMaxY(self.mailLTView.frame) + 20, kLTViewWidth, kLTViewHeight) labelWidth:kLabelWidth horizonSpacing:kHorizonSpacing text:@"联系方式:" placeholder:@"请输入个人联系方式"];
        _numLTView.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _numLTView.textField.delegate = self;
        _numLTView.textField.tag = 104;
        [self addSubview:_numLTView];
    }
    return _numLTView;
}

// 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self numLTView];
}

// 键盘响应者
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 104) {
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
