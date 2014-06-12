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
@property NSMutableArray *toView;
@property (strong, nonatomic) IBOutlet UITableView *MenuTableView;
@end

@implementation MenuViewController

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
    //My code
   // DataProvider *provider = [[DataProvider alloc] init];
    /*//[provider getMenuData:nil];
    [NSThread sleepForTimeInterval:6];
    UIAlertView *greeting=[[UIAlertView alloc] initWithTitle:@"You WELCOM" message:@"We are glad to see You" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [greeting show];
    self.menuFromServer=[[NSMutableArray alloc] initWithArray:[provider getMenuData:0]];
    BOOL isLoad=NO;
    while (!isLoad) {
        if([self.menuFromServer count]>0) isLoad=YES;
    }*/
    
    
    
    //Hardcode for init
    self.menuFromServer=[[NSMutableArray alloc] init];
    self.subMenu1=[[NSMutableArray alloc] init];
    self.toView=[[NSMutableArray alloc] init];
   
    for (int i=0;i<5;i++)
    {
        MenuCategory *temp=[[MenuCategory alloc] init];
        //MenuCategory *temp=[[MenuCategory alloc] init];
        temp.Id=10+i;
        temp.parentId=1;
        temp.name=[NSString stringWithFormat:@"SubNumero - %d",i];
        temp.items=nil;
        [self.subMenu1 addObject:temp];
        //int q=[self.menuFromServer count];
        /*  NSString *q1=[[NSString alloc] initWithString: temp.name ];
         NSLog(q1);*/
        //NSLog(self.menuFromServer);
        //  [self.menuFromServer ];
    }

    for (int i=0;i<10;i++)
    {
        MenuCategory *temp=[[MenuCategory alloc] init];
    //MenuCategory *temp=[[MenuCategory alloc] init];
        temp.Id=i;
        temp.parentId=0;
        temp.name=[NSString stringWithFormat:@"Numero - %d",i];
        temp.items=nil;
        [self.menuFromServer addObject:temp];
        //int q=[self.menuFromServer count];
      /*  NSString *q1=[[NSString alloc] initWithString: temp.name ];
        NSLog(q1);*/
        //NSLog(self.menuFromServer);
      //  [self.menuFromServer ];
    }
    MenuCategory *temp=[[MenuCategory alloc] init];
    
    temp.Id=1;
    temp.parentId=0;
    temp.name=[NSString stringWithFormat:@"WithSub"];
    temp.items=nil;
    temp.categories=  self.subMenu1;
    [self.menuFromServer addObject:temp];
    //Quite bad :(
    self.toView=self.menuFromServer;
    
    
    
    


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    DataProvider *provider = [[DataProvider alloc] init];
    
    // testing ...
    __block MenuCategory *_menu = [[MenuCategory alloc] init];
    [provider getMenuData:nil responseBlock:^(MenuCategory *menu, NSError *error) {
        
        _menu = menu;
        for ( MenuCategory *tmp in _menu.categories ) {
            NSLog(@"%@", tmp.name);
        }
        
//        [provider getMenuData:_menu.categories[2] responseBlock:^(MenuCategory *menu, NSError *error) {
//            _menu = menu;
//            for ( MenuCategory *tmp in _menu.categories ) {
//                NSLog(@"%@", tmp.name);
//            }
//            
//            [provider getMenuData:_menu.categories[1] responseBlock:^(MenuCategory *menu, NSError *error) {
//                _menu = menu;
//                for ( MenuCategory *tmp in _menu.categories ) {
//                    NSLog(@"%@", tmp.name);
//                }
//                
//                [provider getMenuData:_menu.categories[0] responseBlock:^(MenuCategory *menu, NSError *error) {
//                    _menu = menu;
//                    for ( MenuItem *tmp in _menu.items ) {
//                        NSLog(@"%@", tmp.name);
//                    }
//                }];
//            }];
//        }];
    }];
    
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
    
    int q=[self.toView count];
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
        //NSString *temp=[[NSString alloc]init ];
        MenuCategory *tempmc=[[MenuCategory alloc]init];
        tempmc=[self.toView objectAtIndex:[indexPath row]];
        cell.textLabel.text=tempmc.name;
    return cell;
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCategory *currentRow=[[MenuCategory alloc] init];
    currentRow =[self.toView objectAtIndex:[indexPath item]];
    if(currentRow.items==nil)
    {
        self.toView=currentRow.categories;
    }
    [self.MenuTableView reloadData];
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
