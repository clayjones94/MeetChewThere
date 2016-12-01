//
//  MCTRegisterViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/5/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTRegisterViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "MCTUtils.h"
#import "Masonry.h"
#import "MCTUser.h"
#import "MCTContentManager.h"
#import "MCTConstants.h"
#import "MCTRegisterPickDietViewController.h"

@implementation MCTRegisterViewController {
    UITextField *_nameField;
    UITextField *_usernameField;
    UITextField *_passwordField;
    
    UIButton *_registerButton;
    
    MCTContentManager *_contentManager;
}

-(void)viewDidLoad {
    _contentManager = [MCTContentManager sharedManager];
    [self.view setBackgroundColor:[MCTUtils gradientBackgroundColorWithFrame:self.view.frame]];
    [self setThemeUsingPrimaryColor:[UIColor whiteColor] withSecondaryColor:[MCTUtils defaultBarColor] andContentStyle:UIContentStyleLight];
    [self setupFields];
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

-(void) setupFields {
    _nameField = [UITextField new];
    [self.view addSubview:_nameField];
    
    _usernameField = [UITextField new];
    [self.view addSubview:_usernameField];
    
    _passwordField = [UITextField new];
    [self.view addSubview:_passwordField];
    
    [_usernameField setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:18]];
    [_usernameField setPlaceholder:@"Username"];
    [_usernameField setTextAlignment:NSTextAlignmentCenter];
    [_usernameField setBackgroundColor:[UIColor whiteColor]];
    
    
    [_usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-60);
        make.width.mas_equalTo(self.view.frame.size.width * .8);
        make.height.mas_equalTo(40);
    }];
    
    UIView *separator = [UIView new];
    [separator setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(_usernameField);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(1.0f);
    }];
    
    [_nameField setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:18]];
    [_nameField setPlaceholder:@"Name"];
    [_nameField setTextAlignment:NSTextAlignmentCenter];
    [_nameField setBackgroundColor:[UIColor whiteColor]];
    
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_usernameField.mas_top);
        make.left.right.equalTo(_usernameField);
        make.height.equalTo(_usernameField);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(_nameField);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(1.0f);
    }];
    
    [_passwordField setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:18]];
    [_passwordField setPlaceholder:@"Password"];
    [_passwordField setTextAlignment:NSTextAlignmentCenter];
    [_passwordField setSecureTextEntry:YES];
    [_passwordField setBackgroundColor:[UIColor whiteColor]];
    
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_usernameField.mas_bottom);
        make.left.right.equalTo(_usernameField);
        make.height.equalTo(_usernameField);
    }];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerButton setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:18]];
    [_registerButton setTitle:@"Create Account" forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerButton];
    
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordField.mas_bottom);
        make.left.right.equalTo(_usernameField);
        make.height.equalTo(_usernameField);
    }];
}

-(void) registerAccount {
    MCTUser *new_user = [[MCTUser alloc] init];
    BOOL complete = YES;
    if (_nameField.text.length == 0) {
        [self noTextError: _nameField];
        complete = NO;
    } else {
        [new_user setName:_nameField.text];
    }
    if (_usernameField.text.length == 0) {
        [self noTextError: _usernameField];
        complete = NO;
    } else {
        [new_user setUsername:_usernameField.text];
    }
    if (_passwordField.text.length == 0) {
        [self noTextError: _passwordField];
        complete = NO;
    } else {
        [new_user setPassword:_passwordField.text];
    }
    if (complete) {
        [_contentManager setUser:new_user];
        [self.navigationController pushViewController:[MCTRegisterPickDietViewController new] animated:YES];
    }
}

-(void) noTextError: (UITextField *) field{
    NSDictionary *titleTextAttr = @{
                                    NSForegroundColorAttributeName: [UIColor redColor]
                                    };
    NSString *ph = field.placeholder;
    NSMutableAttributedString *errorString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ cannot be empty", ph] attributes:titleTextAttr];
    [field setAttributedPlaceholder:errorString];
}

@end
