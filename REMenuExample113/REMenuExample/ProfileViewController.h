//
//  ProfileViewController.h
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "GADBannerView.h"
//#import "GADAdSize.h"
@interface ProfileViewController : RootViewController<UITextFieldDelegate>{
//    GADBannerView *bannerView_;
}

@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *userNumber;

@end
