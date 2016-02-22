//
//  LoginViewController.m
//  yuyue
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoginViewController.h"
#import "LTView.h"
#import "UserInfo.h"
#import "LoginView.h"
#import "FileHandle.h"                    // 实现数据持久化的单例
#import <BmobSDK/Bmob.h>
#import "MBProgressHUD+MJ.h"
#import "RegistViewController.h"
#import "LJNewsDetailViewController.h"


@interface LoginViewController ()
@property (nonatomic,strong) LoginView *loginView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleAndButtonAction];
}

#pragma mark - 添加 title 和按钮事件
- (void)addTitleAndButtonAction
{
    self.title =@"用户登陆";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(backToLastController)];;
    // 注册按钮
    [self.loginView.registButton addTarget:self action:@selector(pushToRegistViewController:) forControlEvents:(UIControlEventTouchUpInside)];
    // 登陆按钮
    [self.loginView.loginButton addTarget:self action:@selector(loginProgram:) forControlEvents:(UIControlEventTouchUpInside)];
}

// 控制器视图懒加载
- (LoginView *)loginView
{
    if (_loginView == nil) {
        // 设置视图
        _loginView = [[LoginView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _loginView.backgroundColor = [UIColor whiteColor];
        [_loginView.userName.textField becomeFirstResponder];
        self.view = _loginView;
        
    }
    return _loginView;
}

// 注册按钮事件-->|跳转到注册页面|
- (void)pushToRegistViewController:(UIButton *)button
{
    RegistViewController *registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

// leftBarButtonItem点击事件-->|返回上一界面|
- (void)backToLastController
{
    // 键盘回收
    [_loginView.passWord.textField becomeFirstResponder];
    [_loginView.passWord.textField resignFirstResponder];
    [self dismissToController];
}


- (void)dismissToController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 登陆按钮事件
- (void)loginProgram:(UIButton *)button
{
    if (_loginView.userName.textField.text.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
    }else if (_loginView.passWord.textField.text.length == 0){
        [MBProgressHUD showError:@"请输入密码"];
    }
    else
    {
        [self userMessageIsRight];
    }
}

- (void)userMessageIsRight
{
    __block typeof(self) blockSelf = self;
    BmobQuery *query = [BmobQuery queryWithClassName:@"User"];
    [query orderByAscending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([_loginView.userName.textField.text isEqualToString:[obj objectForKey:@"userName"]]) {
                if ([_loginView.passWord.textField.text isEqualToString:[obj objectForKey:@"userPassWord"]]) {
                    // 键盘回收
                    [_loginView.passWord.textField becomeFirstResponder];
                    [_loginView.passWord.textField resignFirstResponder];
                    [MBProgressHUD showSuccess:@"登陆成功"];
                    
                    // 添加用户信息
                    [UserInfo sharedUserInfo].userName = [obj objectForKey:@"userName"];
                    [UserInfo sharedUserInfo].headImageUrl = [obj objectForKey:@"userHeadImageUrl"];
                    
                    [UserInfo sharedUserInfo].isLogin = YES;
                    // 登陆成功 发布通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:UserSuccessLogin object:nil];
                    // 登陆之后 dimissLoginViewController
                    [blockSelf performSelector:@selector(dismissToController) withObject:nil afterDelay:0.5];
                    
                    // 如果 plist 存在 就调用plist 不存在 就创建plist
                    [[FileHandle fileHandle] foundUserName:_loginView.userName.textField.text];
                    // userInfo代理方法
                    [[UserInfo sharedUserInfo].delegate userInfo:[UserInfo sharedUserInfo] select:YES];
                    
                    return;
                }
            }
        }
        [MBProgressHUD showError:@"请输入正确的用户名和密码"];
    }];
}


@end
