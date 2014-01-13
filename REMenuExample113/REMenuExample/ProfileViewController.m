//
//  ProfileViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController (){
    UITableView *setTableView;
    UIButton *loginBT;
}

@end

@implementation ProfileViewController

- (void)saveLogIfo{
    NSLog(@"%d,%d",_userNumber.text.length,_password.text.length);
    if ([_userNumber.text isEqualToString:_password.text]) {
        
        if (_userNumber.text.length == 0 || _password.text.length == 0){
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"mmbnwk", nil)];
            return;
        }
        if ([[NSFileManager defaultManager]fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]]) {
            NSLog(@"creat a doc");
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
            [mDic setObject:_password.text forKey:@"password"];
            [mDic writeToFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation] atomically:YES];
            [SVProgressHUD showSuccessWithStatus:@"OK"];
            [_password resignFirstResponder];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"lcmmbyz", nil)];
    }
}

- (void)hideKeyboardAction{
    [_userNumber resignFirstResponder];
    [_password resignFirstResponder];
}

- (void)changeSwich:(UISwitch *)sender{
    if (sender.on) {
        NSLog(@"YES");
        if ([[NSFileManager defaultManager] fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]];
            [dic setObject:@"YES" forKey:@"needpassword"];
            [dic writeToFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation] atomically:YES];
        }
        _password.hidden = NO;
        _userNumber.hidden = NO;
        loginBT.hidden = NO;
    }else{
        NSLog(@"no");
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]];
            [dic setObject:@"NO" forKey:@"needpassword"];
            [dic writeToFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation] atomically:YES];
        }
        
        _userNumber.hidden = YES;
        _password.hidden = YES;
        loginBT.hidden = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            kScreenHeight-94,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];//设置位置
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = MY_BANNER_UNIT_ID;//调用你的id
    bannerView_.backgroundColor = kBlueColor;
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];//添加bannerview到你的试图
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:[GADRequest request]];
    */
    
    self.title = NSLocalizedString(@"sz", nil);
    
    UITapGestureRecognizer *tapHide = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboardAction)];
    [self.view addGestureRecognizer:tapHide];
    
    UISwitch *needPassWord = [[UISwitch alloc]initWithFrame:CGRectMake(15, 11, kScreenWidth/2, 35)];
    [needPassWord addTarget:self action:@selector(changeSwich:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:needPassWord];
    
    UILabel *openOrClose = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3, 8, 200, 35)];
    openOrClose.backgroundColor = [UIColor clearColor];
    openOrClose.text = NSLocalizedString(@"kg", nil);
    openOrClose.textColor = [UIColor lightGrayColor];
    [self.view addSubview:openOrClose];
    
    //用户名
    _userNumber = [[UITextField alloc]initWithFrame:CGRectMake(15, 40+11, kScreenWidth-30, 35)];
    //[_userNumber becomeFirstResponder];
    _userNumber.placeholder = NSLocalizedString(@"xmm", nil);
    _userNumber.delegate = self;
    _userNumber.secureTextEntry = YES;
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
    [self.view addSubview:_userNumber];
    _userNumber.backgroundColor = [UIColor whiteColor];
    
    
    //密码
    _password = [[UITextField alloc]initWithFrame:CGRectMake(15, 40+57, kScreenWidth-30, 35)];
    _password.placeholder = NSLocalizedString(@"qrxmm", nil);
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
    
    
    //登录
    loginBT = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBT.layer.cornerRadius = 8;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<=5.0) {
        [loginBT addTarget:self action:@selector(saveLogIfo) forControlEvents:UIControlEventTouchDown];
    }else{
        [loginBT addTarget:self action:@selector(saveLogIfo) forControlEvents:UIControlEventTouchUpInside];
    }
    [loginBT setBackgroundImage:[UIImage imageNamed:@"rwScheduleTop@2x.png"] forState:UIControlStateNormal];
    [loginBT setImage:[UIImage imageNamed:@"bottom_bg.png"] forState:UIControlStateHighlighted];
    [loginBT setTintColor:[UIColor whiteColor]];
    [loginBT setTitle:NSLocalizedString(@"bc", nil) forState:UIControlStateNormal];
    loginBT.frame = CGRectMake(15, 40+103, kScreenWidth-30, 35);
    [self.view addSubview:loginBT];
    
    //是否需要输入密码
    if ([[NSFileManager defaultManager] fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]];
        NSString *need = [dic objectForKey:@"needpassword"];
        if ([need isEqualToString:@"YES"]) {
            needPassWord.on = YES;
        }else{
            needPassWord.on = NO;
            _userNumber.hidden = YES;
            _password.hidden = YES;
            loginBT.hidden = YES;
        }
    }
    
}
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 2;
        default:
            return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"resueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.imageView.image = [UIImage imageNamed:@"fontNameMark.png"];
                    break;
                case 1:
                    cell.imageView.image = [UIImage imageNamed:@"fontColorMark.png"];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.imageView.image = [UIImage imageNamed:@"glyphicons_203_lock_g.png"];
                    break;
                case 1:
                    cell.imageView.image = [UIImage imageNamed:@"fontColorMark.png"];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = kGreenColor;
    return cell;
    
}
*/


@end
