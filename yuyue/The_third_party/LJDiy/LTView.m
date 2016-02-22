//
//  LTView.m
//  UI3_customView\controller
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 刘杰. All rights reserved.
//

#import "LTView.h"

@implementation LTView



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [_textField resignFirstResponder];
}



- (instancetype)initWithFrame:(CGRect)frame labelWidth:(CGFloat)labelWidth horizonSpacing:(CGFloat)HSpacing text:(NSString *)text placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        
    // label 控件
        // ltview总宽度
        CGFloat totalWidth = frame.size.width;
        // ltview 总高度
        CGFloat totalHeight = frame.size.height;
        // ltview 中有两个控件 一个 label 一个 textfield
        _label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, labelWidth, totalHeight))];
        _label.text = text;
        _label.font = [UIFont systemFontOfSize:20];
        [self addSubview:_label];// 将 label 添加到 LTView 上
        
    
    // textfield 控件
        // 计算 textfield 的原点和宽度
        CGFloat tfWidth = totalWidth - labelWidth - HSpacing;
        CGFloat tfx = labelWidth + HSpacing;
        
        _textField = [[UITextField alloc] initWithFrame:(CGRectMake(tfx, 0, tfWidth, totalHeight))];
        _textField.placeholder = placeholder;
        _textField.delegate = self;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:_textField];
        
        
        
        
       
        
    }
    return self;
}


+ (LTView *)ltViewWithFrame:(CGRect)frame labelWidth:(CGFloat)labelWidth horizonSpacing:(CGFloat)HSpacing text:(NSString *)text placeholder:(NSString *)placeholder
{
    return [[LTView alloc] initWithFrame:frame labelWidth:labelWidth horizonSpacing:HSpacing text:text placeholder:placeholder];
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
