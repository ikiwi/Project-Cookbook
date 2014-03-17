//
//  Menu.h
//  Project Cookbook
//
//  Created by Kalai Wei on 3/16/14.
//  Copyright (c) 2014 Kiwi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet UIButton *addIngButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
