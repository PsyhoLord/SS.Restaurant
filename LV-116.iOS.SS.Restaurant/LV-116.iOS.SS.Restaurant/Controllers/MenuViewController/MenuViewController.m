//
//  MenuViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Administrator on 6/6/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "NavigationController.h"
#import "MenuViewController.h"
#import "ItemCell.h"
#import "CategoryCell.h"
#import "TestCell.h"

#import "DataProvider.h"
#import "MenuCategoryModel.h"
#import "MenuItemModel.h"

@interface MenuViewController ()

#warning What about using self.tableView ? UITableViewController provides you built in "tableView" property
    @property (strong, nonatomic) IBOutlet UITableView *MenuTableView;
    @property (strong, nonatomic) MenuCategoryModel *currentCategory;
@end

@implementation MenuViewController
{
    DataProvider *_dataProvider;
    BOOL _didReachBottomMenuLevel;
}

#warning COMMENT YOUR CODE ONLY IN ENGLISH !!!!!!
- (id)initWithStyle:(UITableViewStyle)style //Ініціалізація з стилем
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

// called by NSNotificationCenter if is notificationNameMenuTreeIsFinished
-(void)didFinishMenuTreeCreation
{
    #warning It's not a good practice to use "nil" for some logic. At least you can encapsulate it in some method inside the DataProvider. Just add another method called "getAllMenu" and place [self getMenuData:nil] as a body of this method. It's your internal logic, so stay as more simple as you can for component which will use your DataProvider.
    _currentCategory = [_dataProvider getMenuData:nil];
    
    [self.MenuTableView reloadData];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [UIActivityIndicatorView setAnimationBeginsFromCurrentState:YES];
}

// test by Oleg & Roman
// called by NSNotiricationCenter if is connectionErrorNotification
- (void)didErrorAppear:(NSNotification*)notificationError
{
    #warning Again, no need to use Notifications at this point. You have
    NSLog(@"Connection error: code:%i, description:%@",
          [[notificationError.userInfo valueForKey:connectionErrorCode] integerValue],
          [notificationError.userInfo valueForKey:connectionErrorDescription]
          );
}

- (void)getMenuDataFromModel // Отримані дані з сервера
{
#warning Initialize DataProvider as part of MenuViewController. Get rid of custom navigation controller
//    get pointer to an object of DataProvider from NavigationController if it is
    _dataProvider = ((NavigationController*)self.navigationController).dataProvider;
#warning The same comment as above. It's not obvious for new developers (like me) why we pass nil here.
    _currentCategory = [_dataProvider getMenuData:nil];
}

#warning Try to move view events at the begginng of ViewController implementation. Also, make sure al events are placed in right order. For example: viewDidLoad goes before viewDidAppear
- (void)viewDidLoad // Завантажилось TableView
{
    [super viewDidLoad];

#warning use blocks instead of Notifications !!!
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishMenuTreeCreation) name:notificationNameMenuTreeIsFinished object:_dataProvider];
    // add self as a listener of notification (connectionErrorNotification) if it
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didErrorAppear:) name:connectionErrorNotification object:nil];
    
    if(!self.currentCategory)
        [self getMenuDataFromModel];
    
}

// remove self as observer when it deallocate from memory
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#warning I decided to skip this method because it looks incomplete. Right ? :)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath // повертає Cell для кожного з рядків. Саме тут ми вибираємо який Cell вантажити
{
    static NSString *CellIdentifier;
    id tempCellData;
    CellIdentifier = @"CellIdentifier";
    // Configure the cell...

    if (_currentCategory.categories) // if we need to show categories
    {
        //CellIdentifier = @"CategoryCell";
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if ( !cell )
        {
            cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            tempCellData=[self.currentCategory.categories objectAtIndex:indexPath.row];
            
            cell.CategoryName.text = ((MenuCategoryModel*)tempCellData).name;
            NSLog(@"%@",cell.CategoryName.text);
        }
        return cell;
    }
    else // if we need to show items
    {
        //CellIdentifier = @"ItemCell";
        ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if ( !cell )
        {
            cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            tempCellData=[self.currentCategory.items objectAtIndex:indexPath.row];
            cell.ItemName.text = ((MenuItemModel*)tempCellData).name;
            //cell.ItemDescription.text=((MenuItemModel*)tempCellData).description;
           // cell.ItemPrice.text  = [NSString stringWithFormat:@"%.2f", ((MenuItemModel*)tempCellData).price];
            // cell.ItemWeight.text = [NSString stringWithFormat:@"%ld",((MenuItemModel*)tempCellData).portions];
            
            _didReachBottomMenuLevel = YES;
            
        }
        return cell;
    }
    //return cell;
    
    
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

#warning DON'T COMMIT WORDS LIKE "X3" !!!!!

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
#warning Boolean flag usage leads to complex BUGS ! Try to avoid it !!!
    if (!_didReachBottomMenuLevel)
    {
#warning you can extract method here. Something like "showCategoryItems" or "navigateToCategoryItems"
        MenuViewController *vc = [[MenuViewController alloc] init];
        MenuCategoryModel *selected = [self.currentCategory.categories objectAtIndex:indexPath.row];
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
