//
//  SecondCell.m
//  REMenuExample
//
//  Created by lin on 14-1-5.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        if (!self.doubleCell) {
            NSLog(@"NO");
            self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,kScreenWidth *0.38,40)];
            self.timeLabel.lineBreakMode = NSLineBreakByCharWrapping;
            self.timeLabel.textAlignment = NSTextAlignmentCenter;
            self.timeLabel.numberOfLines = 0;
            self.timeLabel.backgroundColor = [UIColor clearColor];
            self.timeLabel.textColor = [UIColor whiteColor];
            self.timeLabel.font = [UIFont fontWithName:@"Chalkduster" size:10];//AnnabelScript
            [self addSubview:self.timeLabel];
            
            self.weatherPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 30, 25)];
            [self addSubview:self.weatherPic];
            
            self.emotionPic = [[UIImageView alloc]initWithFrame:CGRectMake(55, 40, 40, 40)];
            [self addSubview:self.emotionPic];
            
            self.diaryPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 45, 45)];
            self.diaryPic.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:self.diaryPic];
            
            self.mainLine = [[UIImageView alloc]initWithFrame:CGRectMake(44.5+78,15,5,45)];
            [self.mainLine setImage:[UIImage imageNamed:@"mainRwLine@2x.png"]];
            //[self addSubview:self.mainLine];
            
            self.mainCircle = [[UIButton alloc]initWithFrame:CGRectMake(38+78,25,18,18)];
            [self.mainCircle setImage:[UIImage imageNamed:@"mainRwCircle@2x.png"] forState:UIControlStateNormal];//mainRwCircle@2x.png SexClose@2x.png
            [self.mainCircle setImage:[UIImage imageNamed:@"SexOpen@2x.png"] forState:UIControlStateHighlighted];
            [self addSubview:self.mainCircle];
            
            self.dkwysUp = [[UIImageView alloc]initWithFrame:CGRectMake(58+78,17,kScreenWidth-140,25)];
            [self.dkwysUp setImage:[UIImage imageNamed:@"dkwys-4_03@2x.png"]];
            [self addSubview:self.dkwysUp];
            
            UIImageView *dkwyMedil = [[UIImageView alloc]initWithFrame:CGRectMake(58+78,42,kScreenWidth-140,25)];
            [dkwyMedil setImage:[UIImage imageNamed:@"dkwys_06@2x.png"]];
            [self addSubview:dkwyMedil];
            
            self.dkwysDown = [[UIImageView alloc]initWithFrame:CGRectMake(58+78,42+25,kScreenWidth-140,15)];
            [self.dkwysDown setImage:[UIImage imageNamed:@"dkwys_09@2x.png"]];
            [self addSubview:self.dkwysDown];
            
            self.contentLabel = [[UITextView alloc]initWithFrame:CGRectMake(80+67,17,kScreenWidth-157,60)];
            self.contentLabel.editable = NO;
            self.contentLabel.backgroundColor = [UIColor clearColor];
            self.contentLabel.backgroundColor = [UIColor clearColor];
            self.contentLabel.textAlignment = NSTextAlignmentJustified;
            self.contentLabel.font = [UIFont fontWithName:@"经典行书简" size:17];
            [self addSubview:self.contentLabel];
        }else{
            NSLog(@"YES");
            self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,kScreenWidth *0.38 +10,kScreenWidth *0.38,40)];
            self.timeLabel.lineBreakMode = NSLineBreakByCharWrapping;
            self.timeLabel.textAlignment = NSTextAlignmentCenter;
            self.timeLabel.numberOfLines = 0;
            self.timeLabel.backgroundColor = [UIColor clearColor];
            self.timeLabel.textColor = [UIColor whiteColor];
            self.timeLabel.font = [UIFont fontWithName:@"Chalkduster" size:10];//AnnabelScript
            [self addSubview:self.timeLabel];
            
            self.mainLine = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth *0.38,15,5,45)];
            [self.mainLine setImage:[UIImage imageNamed:@"mainRwLine@2x.png"]];
            [self addSubview:self.mainLine];
            
            self.mainCircle = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth *0.38 - 6.5,25,18,18)];
            [self.mainCircle setImage:[UIImage imageNamed:@"SexClose@2x.png"] forState:UIControlStateNormal];//mainRwCircle@2x.png
            [self.mainCircle setImage:[UIImage imageNamed:@"SexOpen@2x.png"] forState:UIControlStateHighlighted];
            [self addSubview:self.mainCircle];
            
            self.dkwysUp = [[UIImageView alloc]initWithFrame:CGRectMake(3,17,kScreenWidth *0.38 ,25)];
            [self.dkwysUp setImage:[UIImage imageNamed:@"tc_001@2x.png"]];
            [self addSubview:self.dkwysUp];
            
            self.contentLabel = [[UITextView alloc]initWithFrame:CGRectMake(80+78,25,220,21)];
            self.contentLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:self.contentLabel];
        }
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];
    NSLog(@"selected");

//    [self.mainCircle setBackgroundColor:kGreenColor];
    // Configure the view for the selected state
}

@end
