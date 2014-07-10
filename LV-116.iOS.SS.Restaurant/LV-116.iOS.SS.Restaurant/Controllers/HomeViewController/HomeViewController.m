//
//  ViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Alexander on 26.05.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "SidebarViewController.h"
#import "AuthorizationProvider.h"
#import "UserRole.h"

static NSString *const kRootMenuName        = @"Home page";
static NSString *const kRoleClientIconName  = @"role_client_icon.png";
static NSString *const kRoleWaiterIconName  = @"role_waiter_icon.png";

@implementation HomeViewController
{
    __weak IBOutlet UIImageView *_roleImageView;
    __weak IBOutlet UIButton    *_buttonLogIn;
    __weak IBOutlet UIButton    *_buttonLogOut;
    __weak IBOutlet UITextField *_textFieldUserName;
    __weak IBOutlet UITextField *_textFieldPassword;
    UITapGestureRecognizer      *tapRecognizer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSidebarConfiguration];
    
    self.title = kRootMenuName;
    
    EnumUserRole enumUserRole = ([UserRole getInstance]).enumUserRole;
    [self setHomePageConfiguration:enumUserRole];
    
    _sidebarViewController =  ((SidebarViewController*)self.revealViewController.rearViewController);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
}

// set configuration for sidebar
- (void) setSidebarConfiguration
{
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

// set home page configuration according to user role
- (void) setHomePageConfiguration:(EnumUserRole)userRole
{
    [self setRoleImage:userRole];
    switch ( userRole ) {
        case UserRoleClient:
            _buttonLogIn.enabled  = YES;
            _buttonLogOut.enabled = NO;
            break;
        case UserRoleWaiter:
            _buttonLogIn.enabled  = NO;
            _buttonLogOut.enabled = YES;
            break;
    }
}

// set image on scrin according to user role
- (void) setRoleImage:(EnumUserRole)userRole
{
    switch ( userRole ) {
        case UserRoleClient:
            _roleImageView.image = [UIImage imageNamed:kRoleClientIconName];
            break;
        case UserRoleWaiter:
            _roleImageView.image = [UIImage imageNamed:kRoleWaiterIconName];
            break;
    }
}

- (IBAction)LogIn:(id)sender
{
    [AuthorizationProvider logInWithLogin: _textFieldUserName.text
                                 password: _textFieldPassword.text
                                    block: ^(EnumUserRole enumUserRole, NSError *error) {
        [UserRole getInstance].enumUserRole = enumUserRole;
        [self setHomePageConfiguration:enumUserRole];
        [self.sidebarViewController reloadData];
    }];
}

- (IBAction)LogOut:(id)sender
{
    [AuthorizationProvider logOutWithBlock:^(EnumUserRole enumUserRole, NSError *error) {
        [UserRole getInstance].enumUserRole = enumUserRole;
        [self setHomePageConfiguration:enumUserRole];
        [self.sidebarViewController reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*)recognizer {
    [_textFieldUserName resignFirstResponder];
}

@end
