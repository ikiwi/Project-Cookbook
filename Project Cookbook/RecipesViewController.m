//
//  RecipesViewController.m
//  Project Cookbook
//
//  Created by Kalai Wei on 3/16/14.
//  Copyright (c) 2014 Kiwi. All rights reserved.
//

#import "RecipesViewController.h"

@interface RecipesViewController ()

@end

NSString *APPID = @"1a9b9fea";
NSString *APPKEY = @"0ed770d030e2d8431c3788b1aa613fb5";

@implementation RecipesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSMutableArray*)queryRecipe:(NSString*)queryData
{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://api.yummly.com/v1/api/recipes?_app_id=%@&_app_key=%@&q=%@", APPID, APPKEY, queryData]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    // this will perform a synchronous GET operation passing the values you specified in the header (typically you want asynchrounous, but for simplicity of answering the question it works)
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSScanner *theScanner = [NSScanner scannerWithString:responseString];
    NSString * recipeName;
    NSString * recipeId;
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [theScanner scanUpToString:@"recipeName" intoString:NULL];
    [theScanner scanString:@"recipeName\":\"" intoString:NULL];
    [theScanner scanUpToString:@"\",\"" intoString:&recipeName];
    [theScanner scanString:@"id" intoString:NULL];
    [theScanner scanUpToString:@"id\",\"" intoString:&recipeId];
    url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.yummly.com/recipe/%@", recipeId]];
    request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    response = nil;
    error = nil;
    // this will perform a synchronous GET operation passing the values you specified in the header (typically you want asynchrounous, but for simplicity of answering the question it works)
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
/*    while ([theScanner isAtEnd] == NO) {
        [theScanner scanString:@"minutes=\"" intoString:NULL];
        [theScanner scanInteger:&firstPred];
        [theScanner scanUpToString:@"dirTag=\"" intoString:NULL];
        [theScanner scanString:@"dirTag=\"" intoString:NULL];
        [theScanner scanUpToString:@"\"" intoString:&tmp];
        if (dirTag == nil) {
            dirTag = tmp;
        }
        if ([tmp length] > 0) {
            // outbound and inbound stop have different id
            // so if the dirTag is different, that means there
            // are multiple lines in the same direction.
            // we'll just pick one.
            idx++;
            [result addObject:[NSString stringWithFormat:@"%ld", (long)firstPred]];
        }
        [theScanner scanUpToString:@"minutes" intoString:NULL];
    }
    NSInteger count = [result count];
    while (count < 5) {
        //if there no more predictions, pad the rest of the array
        [result addObject:@"-"];
        count++;
    }*/
    
    return result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
