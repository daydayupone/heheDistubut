//
//  ExploreViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ExploreViewController.h"
#import "SecondCell.h"
#import "DetileDiaryViewController.h"
#import "CHCSVWriter.h"
#import "DiaryModle.h"

@interface ExploreViewController (){
//    CGFloat origin_y;
//    CGFloat ios7Height;
    NSArray *tableAr;
    UITableView *diayTable;
}


@end

@implementation ExploreViewController

#pragma mark -- 将考勤内容写入text
static CHCSVWriter *sharedWriter = nil;
+ (CHCSVWriter *)sharedWriter{
    @synchronized (self) {
        if (sharedWriter == nil) {
            sharedWriter = [[CHCSVWriter alloc] initWithCSVFile:[DOCUMENT stringByAppendingPathComponent:@"汇报日志.text"] atomic:NO];
        }
        return sharedWriter;
    }
}

- (void)sendMailAction{
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    if(mailCompose)
    {
        //设置代理
        [mailCompose setMailComposeDelegate:self];
        
        NSArray *toAddress = [NSArray arrayWithObject:@""];
        NSArray *ccAddress = [NSArray arrayWithObject:@""];;
        NSString *emailBody = @"<H1>日志信息</H1>";
        
        //设置收件人
        [mailCompose setToRecipients:toAddress];
        //设置抄送人
        [mailCompose setCcRecipients:ccAddress];
        //设置邮件内容
        [mailCompose setMessageBody:emailBody isHTML:YES];
        
        NSData* pData = [[NSData alloc]initWithContentsOfFile:[DOCUMENT stringByAppendingPathComponent:@"汇报日志.text"]];
        
        //设置邮件主题
        [mailCompose setSubject:@"myDiary"];
        
        //设置邮件附件{mimeType:文件格式|fileName:文件名}
        [mailCompose addAttachmentData:pData mimeType:@"txt" fileName:@"工作日志.txt"];
        //设置邮件视图在当前视图上显示方式
        [self presentModalViewController:mailCompose animated:YES];
    }
}

#pragma mark -- 导出日记
- (void)exportTxtToEmail{
    
    UIAlertView *exportAlert = [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"dcrj", nil) delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES",@"NO", nil];
    
    [exportAlert show];
    
}

- (void)reloadViewAndDate{
    NSLog(@"11111111111reloadViewAndDate");
    tableAr = [NSArray arrayWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName]];
    [diayTable reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"lsjl", nil);

    self.view.backgroundColor = kBlueColor;
    
    if ([UIDevice currentDevice]) {
        nil;
    }
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"bg_1.png"]stretchableImageWithLeftCapWidth:100 topCapHeight:100]]];
    
    
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kDiaryName] isDirectory:nil]) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            tableAr = [NSArray arrayWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                diayTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44)];
                
                UIImageView * mainLine = [[UIImageView alloc]initWithFrame:CGRectMake(44.5+78,0,5,kScreenHeight)];
                [mainLine setImage:[UIImage imageNamed:@"mainRwLine@2x.png"]];
                [self.view addSubview:mainLine];
                diayTable.backgroundColor = [UIColor clearColor];
                
                [self.view addSubview:diayTable];
                diayTable.separatorStyle = UITableViewCellSeparatorStyleNone;
                diayTable.delegate = self;
                diayTable.dataSource = self;
                [SVProgressHUD showSuccessWithStatus:@"OK!"];

            });
        });
        
        
       
    }else{
        [SVProgressHUD showErrorWithStatus:@":("];
    }
    
    UIButton *exportText = [UIButton buttonWithType:UIButtonTypeCustom];
    [exportText setImage:[UIImage imageNamed:@"glyphicons_359_file_export.png"] forState:UIControlStateNormal];
    exportText.frame = CGRectMake(0, 0, 30, 30);
    [exportText addTarget:self action:@selector(exportTxtToEmail) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:exportText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadViewAndDate) name:@"sxjm" object:nil];
    
}

#pragma mark -- 导出日记
- (void)exportDiaryText{
    NSArray *resultArray = tableAr;
    
    CHCSVWriter *csvWriter = [ExploreViewController sharedWriter];
    
    [csvWriter writeField:NSLocalizedString(@"lsjl", nil)];
    
    [csvWriter writeLine];
    
    [resultArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictionary = [resultArray objectAtIndex:idx];
        //        AttendanceModel *dictionary = [resultArray objectAtIndex:idx];
        NSString *time = [dictionary objectForKey:@"time"];
        NSString *content = [dictionary objectForKey:@"content"];
        [csvWriter writeField:time];
        [csvWriter writeLine];
        [csvWriter writeField:content];
        [csvWriter writeLine];
    }];
    [csvWriter closeFile];
    
    sharedWriter = nil;
    
    //发送邮件
    [self sendMailAction];
    
}
#pragma mark - UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            [self exportDiaryText];
        }
        break;
        
        default:
        break;
    }
}

#pragma mark -- 邮件delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
    {
        
        switch (result)
        {
            case MFMailComposeResultCancelled:
            
            NSLog( @"邮件发送取消");
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"qxfs", nil)];
            break;
            case MFMailComposeResultSaved:
            
            NSLog( @"邮件保存成功");
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"fscg", nil)];
            break;
            case MFMailComposeResultSent:
            
            NSLog( @"邮件发送成功");
            [[NSFileManager defaultManager] removeItemAtPath:[DOCUMENT stringByAppendingPathComponent:@"汇报日志.text"] error:nil];
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"fscg", nil)];
            
            break;
            case MFMailComposeResultFailed:
            
            NSLog( @"邮件发送失败");
            [SVProgressHUD showSuccessWithStatus:@"send error!"];
            break;
            
            default:
            break;
        }
        [self dismissModalViewControllerAnimated:YES];
        
    }

    
#pragma mark - UITableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return tableAr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (!cell) {
        cell = [[SecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        int a = indexPath.row%2;
        NSLog(@"%d",a);
        if (a == 1) {
            cell.doubleCell = YES;
        }else{
            cell.doubleCell = NO;
        }
    }
    
    NSDictionary *diaryContentDic = [tableAr objectAtIndex:indexPath.row];
    
    cell.timeLabel.text = [[tableAr objectAtIndex:indexPath.row]objectForKey:@"time"];
    cell.contentLabel.text = [[tableAr objectAtIndex:indexPath.row]objectForKey:@"content"];

    cell.emotionPic.image = [UIImage imageNamed:[diaryContentDic objectForKey:dicEmotion]];
    cell.weatherPic.image = [UIImage imageNamed:[diaryContentDic objectForKey:dicWeather]];
        
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexPath.row == %d",indexPath.row);
    DetileDiaryViewController *detileVC = [[DetileDiaryViewController alloc]init];
    detileVC.dairyDic = [tableAr objectAtIndex:indexPath.row];
    detileVC.plistIndx = indexPath.row;
    [self.navigationController pushViewController:detileVC  animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil)
    {
        //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"sxjm" object:nil];
        self.view = nil;
    }
}



@end
