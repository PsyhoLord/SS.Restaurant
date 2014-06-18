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
    }
    return self;
}


// called by NSNotificationCenter if is notificationNameMenuTreeIsFinished
-(void)didFinishMenuTree
{
    NSLog(@"Hello");
    _currentCategory = [_dataProvider getMenuData:nil];
    [self.MenuTableView reloadData];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [UIActivityIndicatorView setAnimationBeginsFromCurrentState:YES];
}

// test by Oleg & Roman
// called by NSNotiricationCenter if is connectionErrorNotification
- (void)didErrorAppear:(NSNotification*)notificationError
{
    NSLog(@"Connection error: code:%i, description:%@",
          [[notificationError.userInfo valueForKey:connectionErrorCode] integerValue],
          [notificationError.userInfo valueForKey:connectionErrorDescription]
          );
}

- (void)loadDataFromServer
{
    _dataProvider = [[DataProvider alloc] init];
    [_dataProvider getMenuData:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishMenuTree) name:notificationNameMenuTreeIsFinished object:_dataProvider];
    // add self as a listener of notification (connectionErrorNotification) if it
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didErrorAppear:) name:connectionErrorNotification object:nil];
;
    
    if(!self.currentCategory)
        [self loadDataFromServer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.currentCategory.items)
        return [self.currentCategory.items count];
    else
        return [self.currentCategory.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MenuCategory *tempVariableForTitle=[[MenuCategory alloc]init];
    if (_currentCategory.categories)
    {
        tempVariableForTitle=[self.currentCategory.categories objectAtIndex:indexPath.row];
        cell.textLabel.text=tempVariableForTitle.name;
    }
    else
    {
        tempVariableForTitle=[self.currentCategory.items objectAtIndex:indexPath.row];
        cell.textLabel.text=tempVariableForTitle.name;
        cell.detailTextLabel.text=tempVariableForTitle.description;
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
       // MenuCategory *selected = [_dataProvider getMenuData:[self.currentCategory.categories objectAtIndex:indexPath.row]];
    
        [vc setTitle: selected.name];
    
        vc.currentCategory = selected;
    
        [self.navigationController pushViewController:vc animated:YES];
    } /*else {
        MenuViewController *vc = [[MenuViewController alloc] init];
        MenuItem *selected = [self.currentCategory.items objectAtIndex:indexPath.row];
        
        [vc setTitle: selected.name];
        
        [self.navigationController pushViewController:vc animated:YES];
    }*/
}

@end
