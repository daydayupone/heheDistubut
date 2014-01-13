//
//  NavigationViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//
//  Sample icons from http://icons8.com/download-free-icons-for-ios-tab-bar
//

#import "NavigationViewController.h"
#import "HomeViewController.h"
#import "ExploreViewController.h"
#import "ActivityViewController.h"
#import "ProfileViewController.h"
//#import "SPhotoStoreViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationItem.t
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"mainChooseLine@2x.png"] forBarMetrics:UIBarMetricsDefault];
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0){
        self.navigationBar.tintColor = [UIColor whiteColor];
    }else{
        self.navigationBar.tintColor = kBlueColor;
    }
   
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    self.navigationBar.titleTextAttributes = dict;
    //self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    
    
    // Blocks maintain strong references to any captured objects, including self,
    // which means that it’s easy to end up with a strong reference cycle if, for example,
    // an object maintains a copy property for a block that captures self
    // (which is the case for REMenu action blocks).
    //
    // To avoid this problem, it’s best practice to capture a weak reference to self:
    //
    __typeof (&*self) __weak weakSelf = self;
    
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:NSLocalizedString(@"xrj", nil)
                                                    subtitle:NSLocalizedString(@"xrjx", nil)
                                                       image:[UIImage imageNamed:@"yjfkImage@2x_.png"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                          HomeViewController *controller = [[HomeViewController alloc] init];
                                                          [weakSelf setViewControllers:@[controller] animated:NO];
                                                      }];
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:NSLocalizedString(@"lsjl", nil)
                                                       subtitle:NSLocalizedString(@"lsjlx", nil)
                                                          image:[UIImage imageNamed:@"rwxqTimeImage@2x_.png"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             
                                        
[SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeGradient];
                                                     
                                                                                                                                                                      NSLog(@"Item: %@", item);
                                                             ExploreViewController *controller = [[ExploreViewController alloc] init];
                                                             [weakSelf setViewControllers:@[controller] animated:NO];
                                                         }];
    /*
    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:NSLocalizedString(@"wdxc", nil)
                                                        subtitle:NSLocalizedString(@"wdxcx", nil)
                                                           image:[UIImage imageNamed:@"glyphicons_071_book.png"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                           
                                                              [SVProgressHUD showWithStatus:@"loading"];
                                                              NSLog(@"Item: %@", item);
                                                              SPhotoStoreViewController *controller = [[SPhotoStoreViewController alloc] init];
                                                              [weakSelf setViewControllers:@[controller] animated:NO];
                                                          }];
    */
    REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:NSLocalizedString(@"sz", nil)
                                                          image:[UIImage imageNamed:@"mmxgImage@2x_.png"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             ProfileViewController *controller = [[ProfileViewController alloc] init];
                                                             [weakSelf setViewControllers:@[controller] animated:NO];
                                                         }];
    
    // You can also assign custom view for items
    // Uncomment the code below and add customViewItem to `initWithItems` array, e.g.
    // [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem, customViewItem]]
    //
    /*
    UIView *customView = [[UIView alloc] init];
    customView.backgroundColor = [UIColor blueColor];
    customView.alpha = 0.4;
    REMenuItem *customViewItem = [[REMenuItem alloc] initWithCustomView:customView action:^(REMenuItem *item) {
        NSLog(@"Tap on customView");
    }];
    */
    
    homeItem.tag = 0;
    exploreItem.tag = 1;
    //activityItem.tag = 2;
    profileItem.tag = 3;
    
    _menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, profileItem]];
    _menu.cornerRadius = 4;
    _menu.shadowRadius = 4;
    _menu.shadowColor = [UIColor blackColor];
    _menu.shadowOffset = CGSizeMake(0, 1);
    _menu.shadowOpacity = 1;
    _menu.imageOffset = CGSizeMake(5, -1);
    _menu.waitUntilAnimationIsComplete = NO;
    _menu.textColor = [UIColor whiteColor];
    _menu.subtitleTextColor = kBlueColor;
}

- (void)toggleMenu
{
    if (_menu.isOpen)
        return [_menu close];
    
    [_menu showFromNavigationController:self];
}

@end
