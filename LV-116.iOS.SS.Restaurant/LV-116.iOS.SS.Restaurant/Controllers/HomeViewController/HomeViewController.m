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
    __weak SidebarViewController *_sidebarViewController;   // need for reload data on sidebar table view
    __weak IBOutlet UIImageView  *_roleImageView;
    __weak IBOutlet UIButton     *_buttonLogIn;
    __weak IBOutlet UIButton     *_buttonLogOut;
    __weak IBOutlet UITextField  *_textFieldUserName;
    __weak IBOutlet UITextField  *_textFieldPassword;
    UITapGestureRecognizer       *_tapRecognizer;           // need for recognize gesture for keyboard
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSidebarConfiguration];
    
    self.title = kRootMenuName;
    
    [self setHomePageConfiguration: ([UserRole getInstance]).enumUserRole];
    
    // set pointer to sidebar view controller
    // which needs for reload data on sidebar according to change of user role
    _sidebarViewController =  ((SidebarViewController*)self.revealViewController.rearViewController);
    
    [self setKeyboardConfiguration];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sidebar configuration

// set configuration for sidebar
- (void) setSidebarConfiguration
{
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
}

#pragma mark - home page configuration

// set home page configuration according to user role
- (void) setHomePageConfiguration:(EnumUserRole)userRole
{
    [self setRoleImage: userRole];
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
- (void) setRoleImage: (EnumUserRole)userRole
{
    switch ( userRole ) {
        case UserRoleClient:
            _roleImageView.image = [UIImage imageNamed: kRoleClientIconName];
            break;
        case UserRoleWaiter:
            _roleImageView.image = [UIImage imageNamed: kRoleWaiterIconName];
            break;
    }
}

#pragma mark - action for buttons

// logic of button login
- (IBAction) LogIn: (id)sender
{
    [AuthorizationProvider logInWithLogin: _textFieldUserName.text
                                 password: _textFieldPassword.text
                                    block: ^(EnumUserRole enumUserRole, NSError *error) {
        [UserRole getInstance].enumUserRole = enumUserRole;
        [self setHomePageConfiguration: enumUserRole];
        [_sidebarViewController reloadData];
    }];
}

// logic of button logout
- (IBAction) LogOut: (id)sender
{
    [AuthorizationProvider logOutWithBlock: ^(EnumUserRole enumUserRole, NSError *error) {
        [UserRole getInstance].enumUserRole = enumUserRole;
        [self setHomePageConfiguration: enumUserRole];
        [_sidebarViewController reloadData];
    }];
}

#pragma mark - Keyboard configuration

// set keyboard configuration
- (void) setKeyboardConfiguration
{
    // add self as observer for UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(keyboardWillShow:)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil];
    
    // add self as observer for UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(keyboardWillHide:)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil];
    
    // create object of UITapGestureRecognizer
    // for recognize gesture
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                            action: @selector(didTapAnywhere:)];
}

#pragma mark - keyboard control methods

- (void) keyboardWillShow: (NSNotification*)note
{
    // add gesture recognizer for hide key board
    [self.view addGestureRecognizer: _tapRecognizer];
}

- (void) keyboardWillHide: (NSNotification*)note
{
    // remove gesture recognizer for hide key board
    [self.view removeGestureRecognizer: _tapRecognizer];
}

- (void) didTapAnywhere: (UITapGestureRecognizer*)recognizer
{
    [_textFieldUserName resignFirstResponder];
    [_textFieldPassword resignFirstResponder];
}

@end
