//
//  RegistViewController.m
//  yuyue
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RegistViewController.h"
#import "LTView.h"
#import "UserInfo.h"
#import "RegistView.h"
#import <BmobSDK/Bmob.h>                        // Bmob服务器
#import "MBProgressHUD+MJ.h"                    // MJ提示框
#import <BmobSDK/BmobProFile.h>                 // 文件上传
#import "UIView+MLInputDodger.h"                // 键盘回收
#import "MeunTableViewController.h"
#import "LJNewsDetailViewController.h"



@interface RegistViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIImage *loadImage;                            // 本地选取的图片
@property (nonatomic,strong) RegistView *registView;
@property (nonatomic,strong) MeunTableViewController *meunTVC;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addControllerView];                // 添加控制器视图
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:(UIBarButtonItemStylePlain) target:self action:@selector(registUser)];
}

#pragma mark  - 添加控制器视图
- (void)addControllerView
{
    _registView = [[RegistView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 注册头像添加手势实现本地选取图片
    UITapGestureRecognizer *chooseHeadImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerImage)];
    [_registView.headImageView addGestureRecognizer:chooseHeadImage];
    _registView.backgroundColor = [UIColor whiteColor];
    
    // 添加字数限制功能
    _registView.userNameLTView.textField.delegate = self;
    
    
    self.view = _registView;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger loc = range.location;
    if (loc < 10) {
        return YES;
    }else
    {
        [MBProgressHUD showError:@"用户名限制为10个字符"];
        return NO;
    }
}






#pragma mark - 键盘上弹
// 键盘上弹第三方
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //please use the method in viewDidAppear
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodger];
}

// 键盘弹出 视图向上移动
//- (void)keyboardDidChangeFrame:(NSNotification *)noti
//{
//    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyY = frame.origin.y;
//    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    [UIView animateWithDuration:keyDuration animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0, keyY - KScreenHeight);
//    } ];
//}

#pragma mark  - 实现协议中的 完成图片选择方法
// 从相册选择头像
- (void)pickerImage
{
    // 1.创建pickerController
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // 2.设置选择图片的源
    [picker setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
    
    // 3. 设置代理
    picker.delegate = self;
    
    // 4.模态显示
    [self presentViewController:picker animated:YES completion:nil];
}


// 参数 info 为选择后的图片信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 设置 info 图片信息 kvc 设置
    _loadImage = [info objectForKey:UIImagePickerControllerOriginalImage];  // 原图
    
    // 赋值
    _registView.headImageView.image = _loadImage;
    
    [UserInfo sharedUserInfo].headImage = _loadImage;
    
    // 模态消失
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark - rightBarButtonItem点击注册事件
- (void)registUser
{
    if (_registView.userNameLTView.textField.text.length == 0 || _registView.passWordLTView.textField.text.length == 0) {
        [MBProgressHUD showError:@"用户名和密码不能为空"];
        return;
    }else if (NO == [_registView.passWordLTView.textField.text isEqualToString:_registView.affirmPassWordLTView.textField.text]) {
        [MBProgressHUD showError:@"两次输入密码不一致"];
        return;
    }else if ([self checkChinese:_registView.userNameLTView.textField.text]){
        [MBProgressHUD showError:@"请输入英文用户名"];
        return;
    }else if (_loadImage == nil){
        [MBProgressHUD showError:@"请添加你萌萌哒的头像!"];
        return;
    }else{
        // 遍历服务器表单数据 判断用户名是否被注册
        BmobQuery *query = [BmobQuery queryWithClassName:@"User"];
        [query orderByAscending:@"updatedAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                if ([_registView.userNameLTView.textField.text isEqualToString:[obj objectForKey:@"userName"]]) {
                    [MBProgressHUD showError:@"该用户名已被注册，请重新输入"];
                    return;
                }
            }
            // 键盘回收
            [self.view endEditing:YES];
            [UserInfo sharedUserInfo].userName = _registView.userNameLTView.textField.text;
// ----------------------------------------------------------------------------------------
            // 添加提示框
            [MBProgressHUD showMessage:@"正在注册，请稍等……" toView:self.navigationController.view];
            // 上传头像图片文件
            [self updateUserHeadImage];
    
        }];
    }
}

// 判断注册名是否为中文
- (BOOL)checkChinese:(NSString *)string
{
    for(int i = 0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}



// 返回到登陆界面
-(void)goback{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [MBProgressHUD showSuccess:@"注册成功，请登录"];
}

// 上传头像文件
- (void)updateUserHeadImage
{
    // 上传头像图片
    NSData *headImageData = UIImagePNGRepresentation([UserInfo sharedUserInfo].headImage);
    //上传文件
    [BmobProFile uploadFileWithFilename:@"headImage.png" fileData:headImageData block:^(BOOL isSuccessful, NSError *error, NSString *filename, NSString *url,BmobFile *bmobFile) {
        if (isSuccessful) {
            [UserInfo sharedUserInfo].headImageUrl = [BmobProFile signUrlWithFilename:filename url:url validTime:INT_MAX accessKey:@"c257cb6fbfeac76351b94e44e0fcf768" secretKey:@"5d1df0761bd0d04f"];
            // 填写用户表单
            [self writeUserMessage];
        } else {
            if (error) {
                NSLog(@"error %@",error);
            }
        }
    } progress:^(CGFloat progress) {
        //上传进度，此处可编写进度条逻辑
        NSLog(@"progress %f",progress);
    }];
}

// 填写用户注册表单
- (void)writeUserMessage
{
    BmobObject *usersObj = [BmobObject objectWithClassName:@"User"];
    [usersObj setObject:_registView.userNameLTView.textField.text forKey:@"userName"];
    [usersObj setObject:_registView.passWordLTView.textField.text forKey:@"userPassWord"];
    [usersObj setObject:_registView.mailLTView.textField.text forKey:@"userMail"];
    [usersObj setObject:_registView.numLTView.textField.text forKey:@"userPhoneNumber"];
    [usersObj setObject:[UserInfo sharedUserInfo].headImageUrl forKey:@"userHeadImageUrl"];
    [usersObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        if (!error) {
            [MBProgressHUD hideHUDForView:self.navigationController.view];
            NSLog(@"提交成功");
            [self performSelector:@selector(goback) withObject:nil afterDelay:0.7f];
            
        }else{
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                                message:[[error userInfo] objectForKey:@"error"]
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"ok", nil];
            [alertview show];
        }
    }];
    
}

@end
