//
//  DetileDiaryViewController.m
//  REMenuExample
//
//  Created by jiawei on 14-1-8.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "DetileDiaryViewController.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface DetileDiaryViewController ()

@end

@implementation DetileDiaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backAction{
    
    NSLog(@"backAction");
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark -- 放大图片
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    //NSLog(@"url == %@",urlArray);
    //NSString *url = urlArray[i];
    MJPhoto *photo = [[MJPhoto alloc] init];
    //photo.url = [NSURL URLWithString:url]; // 图片路径
    UIImageView *imgView = self.myPicture;
    photo.srcImageView = imgView; // 来源于哪个UIImageView
    [photos addObject:photo];
    
    photo = nil;
    NSLog(@"显示相册");
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    //browser.currentPhotoIndex = tap.view.tag-1000; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    //[self.navigationController setNavigationBarHidden:YES];
    browser = nil;
}
    
- (void)deleteAction{
    
    UIAlertView *sureDelete = [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"qdscrj", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"qd", nil),NSLocalizedString(@"qx", nil), nil];
    [sureDelete show];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.emotion.enabled = NO;
    [self.emotion setImage:[UIImage imageNamed:[self.dairyDic objectForKey:dicEmotion]] forState:UIControlStateDisabled];
    
    self.weather.enabled = NO;
    [self.weather setImage:[UIImage imageNamed:[self.dairyDic objectForKey:dicWeather]] forState:UIControlStateDisabled];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 30, 40);
    [backButton setImage:[UIImage imageNamed:@"backBtnImage_.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.navigationItem.titleView = nil;
    self.navigationItem.rightBarButtonItem = nil;
    
    self.contentTextView.text = [self.dairyDic objectForKey:dicContent];
    self.contentTextView.frame = CGRectMake(10, 10, kScreenWidth-40, kScreenHeight-220);
    self.contentTextView.editable = NO;
    
    CGFloat height = self.contentTextView.contentSize.height;
    CGRect rect = self.contentTextView.frame;
    rect.size.height = height;
    [self.contentTextView setFrame:rect];
    
    
    if (![[self.dairyDic objectForKey:dicImage] isEqualToString:@"nil"]) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UIImage *img = [UIImage imageWithContentsOfFile:[self.dairyDic objectForKey:dicImage]];
            
            //[self.myPicture setImage:[UIImage imageNamed:@"AlbumBtnNormal_.png"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.myPicture.frame =  CGRectMake(0, 10, kScreenWidth-60, 120);
                [self.myPicture setImage:img];
                
                self.myPicture.backgroundColor = [UIColor clearColor];
                self.contentTextView.frame = CGRectMake(10, 130, kScreenWidth-40, kScreenHeight-220);
                self.myPicture.userInteractionEnabled = YES;
                [self.myPicture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            });
        });
        
        
    }
    
    UIButton *delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delectBtn.frame = CGRectMake(0, 0, 30, 30);
    [delectBtn setImage:[UIImage imageNamed:@"glyphicons_016_bin_.png"] forState:UIControlStateNormal];
    [delectBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:delectBtn];
    
    
    
}
#pragma mark -- UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"deleteAtion idx == %d",self.plistIndx);
            NSMutableArray *diaryAr = [NSMutableArray arrayWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName]];
            [diaryAr removeObjectAtIndex:self.plistIndx];
            [diaryAr writeToFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName] atomically:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sxjm" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
        break;
        
        default:
        break;
    }
}
    
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil)
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;
    }
}


- (void) viewDidUnload {
    NSLog(@"viewDidUnload");
    [super viewDidUnload];
    super.myPicture = nil;
    self.myPicture = nil;
    self.timeLabel = nil;
    self.contentTextView = nil;
    self.emotion = nil;
    self.weather = nil;
    self.emotionMenu = nil;
    self.weatherMenu = nil;
}
@end
