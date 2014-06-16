//
//  MenuViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuViewController.h"
#import "DataProvider.h"


@interface MenuViewController ()
@property NSMutableArray *menuFromServer;
@property NSMutableArray *subMenu1;
@property (strong, nonatomic) IBOutlet UITableView *MenuTableView;
@end

@implementation MenuViewController
{
    DataProvider *_dataProvider;
    BOOL didReachBottomMenuLevel;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


-(void)didFinishMenuTree
{
    NSLog(@"Hello");
    _currentCategory = [_dataProvider getMenuData:nil];
    [self.MenuTableView reloadData];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)loadDataFromServer
{
    _dataProvider = [[DataProvider alloc] init];
    //    [_dataProvider setDelegate:self];
    [_dataProvider getMenuData:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add self as a listener of notification (notificationNameMenuTreeIsFinished) from _dataProvider
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishMenuTree) name:notificationNameMenuTreeIsFinished object:_dataProvider];
    
    if(!self.currentCategory)
        [self loadDataFromServer];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    int q;
    if (self.currentCategory.items)
        q=[self.currentCategory.items count];
    else
        q=[self.currentCategory.categories count];
    return  q;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    MenuCategory *tempmc=[[MenuCategory alloc]init];
    if (_currentCategory.categories)
    {
        tempmc=[self.currentCategory.categories objectAtIndex:indexPath.row];
        cell.textLabel.text=tempmc.name;
    }
    else
    {
        tempmc=[self.currentCategory.items objectAtIndex:indexPath.row];
        cell.textLabel.text=tempmc.name;
        cell.detailTextLabel.text=tempmc.description;
        didReachBottomMenuLevel = YES;
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!didReachBottomMenuLevel)
    {
        MenuViewController *vc = [[MenuViewController alloc] init];
        MenuCategory *selected = [self.currentCategory.categories objectAtIndex:indexPath.row];
    
        [vc setTitle: selected.name];
    
        vc.currentCategory = selected;
    //  if(vc.currentCategory.items)  vc.did  vc.didReachBottomMenuLevel=YES;
    
        [self.navigationController pushViewController:vc animated:YES];
    }
    {
        MenuViewController *vc = [[MenuViewController alloc] init];
        MenuItem *selected = [self.currentCategory.items objectAtIndex:indexPath.row];
        
        [vc setTitle: selected.name];
        
        //vc.currentCategory = selected;
        //  if(vc.currentCategory.items)  vc.did  vc.didReachBottomMenuLevel=YES;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
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
