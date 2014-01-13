//
//  FirstViewController.h
//  REMenuExample
//
//  Created by jiawei on 14-1-9.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "CustemTextField.h"
#import "HomeViewController.h"

@interface FirstViewController : RootViewController<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *userNumber;
@property (strong, nonatomic) UIView *logView;
@end
