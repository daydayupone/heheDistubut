//
//  ExploreViewController.h
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface ExploreViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>


@end
