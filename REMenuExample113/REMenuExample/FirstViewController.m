//
//  FirstViewController.m
//  REMenuExample
//
//  Created by jiawei on 14-1-9.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "FirstViewController.h"


@interface FirstViewController (){
    UITextField *inputPass;
}

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)hideKeyboardAction{
    
    [_userNumber resignFirstResponder];
    [_password resignFirstResponder];
    
}

- (void)inputPassWord{
    
    NSDictionary *userIfo = [NSDictionary dictionaryWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]];
    NSLog(@"my dic == %@",userIfo);
    if ([[userIfo objectForKey:@"password"] isEqualToString:_password.text]) {
        [self passWordRight];
    }else{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"mmcw", nil)];
    }
    
}


- (void)passWordRight{
    
    [self.navigationController pushViewController:[[HomeViewController alloc]init] animated:YES];
    
}

- (void)userLog{
    
    if ([_userNumber.text isEqualToString:_password.text]) {
        
        if (_userNumber.text.length == 0 || _password.text.length == 0){
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"mmbnwk", nil)];
            return;
        }
        
        if (![[NSFileManager defaultManager]fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]]) {
            NSLog(@"creat a doc");
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
            [mDic setObject:_password.text forKey:@"password"];
            [mDic setObject:@"YES" forKey:@"needpassword"];
            [mDic writeToFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation] atomically:YES];
            [self.navigationController pushViewController:[[HomeViewController alloc]init] animated:YES];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"lcmmbyz", nil)];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *keyView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [keyView setImage:[UIImage imageNamed:@"glyphicons_044_keys.png"]];
    self.navigationItem.titleView = keyView;
    
    UITapGestureRecognizer *tapHide = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboardAction)];
    [self.view addGestureRecognizer:tapHide];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1.png"]];
    self.navigationItem.leftBarButtonItem = nil;

    //已经创建用户
    if ([[NSFileManager defaultManager]fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]]) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]];
        NSString *needPassWord = [dic objectForKey:@"needpassword"];
        if ([needPassWord isEqualToString:@"NO"]) {
            [self.navigationController pushViewController:[[HomeViewController alloc]init] animated:YES];
            return;
        }
        
        _password = [[UITextField alloc]initWithFrame:CGRectMake(15, 57, kScreenWidth-30, 35)];
        _password.placeholder = NSLocalizedString(@"srmm", nil);
        _password.secureTextEntry = YES;//隐藏输入密码
        _password.delegate = self;
        _password.keyboardType = UIKeyboardTypeASCIICapable;
        _password.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _password .borderStyle = UITextBorderStyleRoundedRect;
        _password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *imgv1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 19)];
        imgv1.image = [UIImage imageNamed:@"key_head.png"];
        _password.leftView = imgv1;
        _password.leftViewMode = UITextFieldViewModeAlways;
        _password.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_password];
        
        UIButton *loginBT = [UIButton buttonWithType:UIButtonTypeCustom];
        //loginBT.backgroundColor = kGreenColor;
        
        loginBT.layer.cornerRadius = 8;

        if ([[UIDevice currentDevice].systemVersion floatValue]<=5.0) {
            [loginBT addTarget:self action:@selector(inputPassWord) forControlEvents:UIControlEventTouchDown];
        }else{
            [loginBT addTarget:self action:@selector(inputPassWord) forControlEvents:UIControlEventTouchUpInside];
        }//
        [loginBT setBackgroundImage:[UIImage imageNamed:@"rwScheduleTop@2x.png"] forState:UIControlStateNormal];
        [loginBT setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forState:UIControlStateHighlighted];
        
        [loginBT setTintColor:[UIColor whiteColor]];
        [loginBT setTitle:NSLocalizedString(@"dl", nil) forState:UIControlStateNormal];
        loginBT.frame = CGRectMake(15, 103, kScreenWidth-30, 35);
        [self.view addSubview:loginBT];

        
        UITextView *aboutemotion = [[UITextView alloc]initWithFrame:CGRectMake(15, 145, kScreenWidth-30, 80)];
        aboutemotion.backgroundColor = [UIColor clearColor];
        aboutemotion.font = [UIFont systemFontOfSize:16];
        aboutemotion.text = NSLocalizedString(@"bqsz", nil);
        aboutemotion.textColor = kGreenColor;
        [self.view addSubview:aboutemotion];
        aboutemotion.editable = NO;
        
    }else {
       //未创建用户
        [self creatUserPassWordViews];
        
    }
    
}

- (void)creatUserPassWordViews{
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"Hello!" message:NSLocalizedString(@"bqsz", nil) delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil, nil];
    [aler show];
    
    _logView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 150)];
    _logView.backgroundColor = [UIColor clearColor];
    _logView.layer.cornerRadius = 10;
    [self.view addSubview:_logView];
    
    //用户名
    _userNumber = [[UITextField alloc]initWithFrame:CGRectMake(15, 11, _logView.bounds.size.width-30, 35)];
    //[_userNumber becomeFirstResponder];
    _userNumber.placeholder = NSLocalizedString(@"cjmm", nil);
    [_userNumber placeholderRectForBounds:CGRectMake(30, 150, 120, 30)];
    _userNumber.delegate = self;
    _userNumber.secureTextEntry = YES;//隐藏输入密码
    _userNumber.keyboardType = UIKeyboardTypeASCIICapable;
    _userNumber.borderStyle = UITextBorderStyleRoundedRect;
    _userNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *imgv=[[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, 25, 19)];
    imgv.image = [UIImage imageNamed:@"lock_head.png"];//mmxgImage@2x_.png
    _userNumber.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
    _userNumber.layer.borderWidth = 2.0;
    _userNumber.leftView.contentMode = UIViewContentModeBottomLeft;
    _userNumber.leftView = imgv;
    _userNumber.leftViewMode = UITextFieldViewModeAlways;
    [_logView addSubview:_userNumber];
    _userNumber.backgroundColor = [UIColor whiteColor];
    
    
    //密码
    _password = [[UITextField alloc]initWithFrame:CGRectMake(15, 57, _logView.bounds.size.width-30, 35)];
    _password.placeholder = NSLocalizedString(@"qrmm", nil);
    _password.secureTextEntry = YES;//隐藏输入密码
    _password.delegate = self;
    _password.keyboardType = UIKeyboardTypeASCIICapable;
    _password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _password .borderStyle = UITextBorderStyleRoundedRect;
    _password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *imgv1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 19)];
    imgv1.image = [UIImage imageNamed:@"key_head.png"];
    _password.leftView = imgv1;
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.backgroundColor = [UIColor whiteColor];
    [_logView addSubview:_password];
    
    
    //登录
    UIButton *loginBT = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBT.layer.cornerRadius = 8;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<=5.0) {
        [loginBT addTarget:self action:@selector(userLog) forControlEvents:UIControlEventTouchDown];
    }else{
        [loginBT addTarget:self action:@selector(userLog) forControlEvents:UIControlEventTouchUpInside];
    }
    [loginBT setBackgroundImage:[UIImage imageNamed:@"rwScheduleTop@2x.png"] forState:UIControlStateNormal];
    [loginBT setImage:[UIImage imageNamed:@"bottom_bg.png"] forState:UIControlStateHighlighted];
    [loginBT setTintColor:[UIColor whiteColor]];
    [loginBT setTitle:NSLocalizedString(@"dl", nil) forState:UIControlStateNormal];
    loginBT.frame = CGRectMake(15, 103, _logView.bounds.size.width-30, 35);
    [_logView addSubview:loginBT];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
