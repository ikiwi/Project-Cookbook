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

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark UI handlers

- (IBAction)loginButtonClick:(id)sender {
    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error) {
                                          if (error) {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:error.localizedDescription
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                              [alertView show];
                                          } else if (session.isOpen) {
                                              [self loginButtonClick:sender];
                                              
                                          }
                                      }];
        return;
    }
    
    if (self.friendPickerController == nil) {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Pick Friends";
        self.friendPickerController.delegate = self ;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    
    [self presentViewController:self.friendPickerController animated:YES completion:nil];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender {
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        NSLog(@"Name: %@ ID: %@", user.name, user.id);
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)fillTextBoxAndDismiss:(NSString *)text {
    self.selectedFriendsView.text = text;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

#pragma mark -

@end
