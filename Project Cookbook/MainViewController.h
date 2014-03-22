//
//  MainViewController.h
//  Project Cookbook
//
//  Created by Kalai Wei on 3/21/14.
//  Copyright (c) 2014 Kiwi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainViewController : UIViewController
{
}
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextView *selectedFriendsView;
@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;

- (IBAction)loginButtonClick:(id)sender;

@end
