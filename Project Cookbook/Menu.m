//
//  Menu.m
//  Project Cookbook
//
//  Created by Kalai Wei on 3/16/14.
//  Copyright (c) 2014 Kiwi. All rights reserved.
//

#import "Menu.h"
#import "FriendsViewController.h"
#import "RecipesViewController.h"
#import "AppDelegate.h"

@interface Menu ()

@end

NSArray *friendsList;
NSMutableArray * inventoryList;
NSInteger MAXINV = 100;
NSInteger totalIng = 0;
NSInteger defaultRowHeight = 114;
NSInteger collapsedRowHeight = 54;

@implementation Menu

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewFriends:(NSObject*)button
{
    FriendsViewController *fvc = [self.storyboard instantiateViewControllerWithIdentifier:@"friendsvc"];
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)viewRecipes:(NSObject*)button
{
    RecipesViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"recipesvc"];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    friendsList = [[NSArray alloc] init];
    inventoryList = [[NSMutableArray alloc] initWithCapacity:MAXINV];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Friends" style: UIBarButtonItemStyleBordered target:self action:@selector(viewFriends:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Recipe" style: UIBarButtonItemStyleBordered target:self action:@selector(viewRecipes:)];
    if (IS_IPHONE_5) {
        [_addIngButton setFrame:CGRectMake(140, 524, 40, 40)];
        [_menuTableView setFrame:CGRectMake(0,32,320,457)];
        [_scrollView setFrame:CGRectMake(0,32,320,497)];
        _menuTableView.rowHeight = 114;
    } else {
        [_addIngButton setFrame:CGRectMake(140,435,40,40)];
        [_menuTableView setFrame:CGRectMake(0,32,320,367)];
        [_scrollView setFrame:CGRectMake(0,32,320,407)];
        _menuTableView.rowHeight = 124;
        defaultRowHeight = 124;
        collapsedRowHeight = 54;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return totalIng;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
