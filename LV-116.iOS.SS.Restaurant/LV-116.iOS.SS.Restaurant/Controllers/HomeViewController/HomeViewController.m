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

#import "SidebarViewController+ConfigurationForOtherViewControllers.h"

#import "Alert.h"
#import "UserRole.h"
#import "AuthorizationProvider.h"
#import "HomeViewController.h"


static NSString *const kRootMenuName         = @"Home page";
static NSString *const kRoleClientIconName   = @"home_restaurant.png";
static NSString *const kRoleWaiterIconName   = @"home_restaurant.png";
static NSString *const kLoginIconUserName    = @"user.png";
static NSString *const kLoginIconPassword    = @"password.png";
static NSString *const kLoginBackgroundImage = @"blurred2.jpg";


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
    
    [SidebarViewController setupSidebarConfigurationForViewController: self
                                                        sidebarButton: self.sidebarButton
                                                            isGesture: YES];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blur2.jpg"]];
    self.title = kRootMenuName;
    
    [self setHomePageConfiguration: ([UserRole getInstance]).enumUserRole];
    
    _textFieldUserName.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:kLoginIconUserName];
    _textFieldUserName.leftView = imageView;
    
    
    _textFieldPassword.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView2.image = [UIImage imageNamed:kLoginIconPassword];
    _textFieldPassword.leftView = imageView2;
    
    
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, _textFieldUserName.frame.size.height -1 , _textFieldUserName.frame.size.width, 1);
    bottomBorder.backgroundColor = [UIColor blackColor].CGColor;

//    [_textFieldUserName.layer addSublayer:bottomBorder];

    
    
    // set pointer to sidebar view controller
    // which needs for reload data on sidebar according to change of user role
    _sidebarViewController =  ((SidebarViewController*)self.revealViewController.rearViewController);
    
    [self setKeyboardConfiguration];
}

#pragma mark - home page configuration

// set home page configuration according to user role
- (void) setHomePageConfiguration: (EnumUserRole)userRole
{
    [self setRoleImage: userRole];
    switch ( userRole ) {
        case UserRoleClient:
            _textFieldUserName.enabled  = YES;
            _textFieldPassword.enabled  = YES;
            _buttonLogIn.enabled        = YES;
            _buttonLogOut.enabled       = NO;
            break;
        case UserRoleWaiter:
            _textFieldUserName.enabled  = NO;
            _textFieldPassword.enabled  = NO;
            _buttonLogIn.enabled        = NO;
            _buttonLogOut.enabled       = YES;
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

#pragma mark - handle of log in and log out

// logic of button login
- (IBAction) logIn: (id)sender
{
    
    [AuthorizationProvider logInWithLogin: _textFieldUserName.text
                                 password: _textFieldPassword.text
                            responseBlock: ^(BOOL isAutorizated, UserRole *userRole, NSError *error) {
                                
                                if ( isAutorizated ) {
                                    dispatch_async( dispatch_get_main_queue(), ^{
                                        [self setHomePageConfiguration: userRole.enumUserRole];
                                        [_sidebarViewController reloadData];
                                        [self clearTextFields];
                                    });
                                } else {
                                    dispatch_async( dispatch_get_main_queue(), ^{
                                        [Alert showAuthorizationAlert];
                                    });
                                    // Alert ...
                                }
                            }];
    [self hideKeyboard];
}

// logic of button logout
- (IBAction) logOut: (id)sender
{
    [AuthorizationProvider logOutWithResponseBlock: ^(UserRole *userRole, NSError *error) {
        dispatch_async( dispatch_get_main_queue(), ^{
            [self setHomePageConfiguration: userRole.enumUserRole];
            [_sidebarViewController reloadData];
        });
        
    }];
}

// remove text from textFields
- (void) clearTextFields
{
    _textFieldUserName.text = @"";
    _textFieldPassword.text = @"";
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

// calls before keyboard has showed
- (void) keyboardWillShow: (NSNotification*)note
{
    // add gesture recognizer for hide key board
    [self.view addGestureRecognizer: _tapRecognizer];
}

// calls after keyboard has hided
- (void) keyboardWillHide: (NSNotification*)note
{
    // remove gesture recognizer for hide key board
    [self.view removeGestureRecognizer: _tapRecognizer];
}

// calls when user has taped anywhere on view
- (void) didTapAnywhere: (UITapGestureRecognizer*)recognizer
{
    [self hideKeyboard];
}

// hide keyboard
- (void) hideKeyboard
{
    [_textFieldUserName resignFirstResponder];
    [_textFieldPassword resignFirstResponder];
}

#pragma mark - handle of editing text fileds user name and password

// calls after user has started editing test field
- (void) textFieldDidBeginEditing: (UITextField*)textField
{
    [self animateTextField: textField up: YES];
}

// calls after user has ended editing test field
- (void) textFieldDidEndEditing: (UITextField*)textField
{
    [self animateTextField: textField up: NO];
}

// need for move view up or down when keyboard shows or end shows
// (UITextField*)textField - what text field is started for editing
// (BOOL)up - if YES, move view up. if No, move view down
- (void) animateTextField: (UITextField*)textField up: (BOOL)up
{
    const int movementDistance = 80;        // tweak as needed
    const float movementDuration = 0.3f;    // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}



@end
