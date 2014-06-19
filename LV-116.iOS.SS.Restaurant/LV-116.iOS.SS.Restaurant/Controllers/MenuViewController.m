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

- (id)initWithStyle:(UITableViewStyle)style //Ініціалізація з стилем
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

- (void)loadDataFromServer // Отримані дані з сервера
{
    _dataProvider = [[DataProvider alloc] init];
    [_dataProvider getMenuData:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)viewDidLoad // Завантажилось TableView
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishMenuTree) name:notificationNameMenuTreeIsFinished object:_dataProvider];
    // add self as a listener of notification (connectionErrorNotification) if it
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didErrorAppear:) name:connectionErrorNotification object:nil];
    
    if(!self.currentCategory)
        [self loadDataFromServer];
    
}

- (void)didReceiveMemoryWarning // Попередження про память
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView // Кількість секцій в TableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section // Кількість рядків в секції // Як зробити різну кількість? Через index
{
    // Return the number of rows in the section.
    if (self.currentCategory.items)
        return [self.currentCategory.items count];
    else
        return [self.currentCategory.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath // повертає Cell для кожного з рядків. Саме тут ми вибираємо який Cell вантажити
{
    static NSString *CellIdentifier;
    
    
    // Configure the cell...
    
        
    //MenuCategory *tempmc=[[MenuCategory alloc]init];
    id tempCellData;// = [[MenuCategory alloc]init];
    if (_currentCategory.categories)
    {
        CellIdentifier = @"CategoryCell";
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if ( !cell )
        {
            cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            tempCellData=[self.currentCategory.categories objectAtIndex:indexPath.row];
            
            cell.CategoryName.text = ((MenuCategory*)tempCellData).name;
            NSLog(@"%@",cell.CategoryName.text);
            
        }
        return cell;
    }
    else
    {
        CellIdentifier = @"ItemCell";
        ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if ( !cell )
        {
            cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            tempCellData=[self.currentCategory.items objectAtIndex:indexPath.row];
            //cell.textLabel.text=tempmc.name;
            cell.ItemName.text = ((MenuItem*)tempCellData).name;
            cell.ItemDescription.text=((MenuItem*)tempCellData).description;
            cell.ItemPrice.text  = [NSString stringWithFormat:@"%.2f", ((MenuItem*)tempCellData).price];
            cell.ItemWeight.text = [NSString stringWithFormat:@"%ld",((MenuItem*)tempCellData).portions];
            
            //didReachBottomMenuLevel = YES;
        }
        return cell;
    }
        
    
    
    /*NSString *CellIdentifier = @"CustomCell";
    TableViewCell *CustomCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ( !CustomCell ) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        CustomCell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    return CustomCell;*/
    
    /*NSString *CellIdentifier = @"CustomCategoryCell";
     TableViewCell *CustomCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     
     // Configure the cell...
     if ( !CustomCell ) {
     //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     CustomCell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     
     }
     return CustomCell;*/
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView customCellForRowAtIndexPath:(NSIndexPath *)indexPath // то мій темплорарі код. Хотів би його викликати, але хз як
{
    
    
    NSString *CellIdentifier = @"CustomCell";
    TableViewCell *CustomCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
    if ( !CustomCell ) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        CustomCell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    }
    return CustomCell;
}*/


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath // обробник кліків за індексом
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
