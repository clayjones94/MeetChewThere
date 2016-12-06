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
    LUNField *_nameField;
    LUNField *_usernameField;
    LUNField *_passwordField;
    UIScrollView *_scrollView;
    UIGestureRecognizer *tapper;
    
    UIButton *_registerButton;
    UIButton *_signUpButton;
    
    MCTContentManager *_contentManager;
}


-(void)viewDidLoad {
    [self setupScrollView];
    self.navigationController.navigationItem.backBarButtonItem = nil;
    _contentManager = [MCTContentManager sharedManager];
//    [_scrollView setBackgroundColor:[MCTUtils gradientBackgroundColorWithFrame:self.view.frame]];
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
//    [self setThemeUsingPrimaryColor:[UIColor whiteColor] withSecondaryColor:[MCTUtils defaultBarColor] andContentStyle:UIContentStyleLight];
    [self setupFields];
    [self setupTap];
}

-(void) setupTap {
    [super viewDidLoad];
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [_scrollView addGestureRecognizer:tapper];
}

-(void) setupScrollView {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame: self.view.frame];
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 1.3)];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setBounces:NO];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    [imageView sizeToFit];
    [_scrollView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView);
        make.top.equalTo(_scrollView).with.offset(20);
    }];
}

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

-(void) setupFields {
    UIColor *fieldColor = [MCTUtils defaultBarColor];
    UIColor *fieldDetailColor = [UIColor lightGrayColor];
    UIColor *correctColor = fieldColor;
    UIColor *incorrectColor = [UIColor redColor];
    _nameField = [LUNField LUNUnderlinedFieldWithDataSource:self delegate:self underliningHeight:1 underliningColor:fieldDetailColor];
    [_scrollView addSubview:_nameField];
    
    _usernameField = [LUNField LUNUnderlinedFieldWithDataSource:self delegate:self underliningHeight:1 underliningColor:fieldDetailColor];;
    [_scrollView addSubview:_usernameField];
    
    _passwordField = [LUNField LUNUnderlinedFieldWithDataSource:self delegate:self underliningHeight:1 underliningColor:fieldDetailColor];;
    [_scrollView addSubview:_passwordField];
    
    
    CGFloat FONT_SIZE = 14;
    _usernameField.placeholderText = @"Email";
    [_usernameField setPlaceholderFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:FONT_SIZE]];
    [_usernameField setPlaceholderFontColor:fieldColor];
    [_usernameField setUpperPlaceholderFontColor:fieldDetailColor];
    [_usernameField setTextFontColor:fieldColor];
    [_usernameField setUpperBorderColor:fieldDetailColor];
    [_usernameField setBorderColor:fieldDetailColor];
    [_usernameField setTintColor:fieldColor];
    [_usernameField setPlaceholderAlignment:LUNPlaceholderAlignmentLeft];
    [_usernameField setTextFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:FONT_SIZE]];
    _usernameField.incorrectLabelText = @"Invalid Email";
    _usernameField.incorrectStateBorderColor = incorrectColor;
    _usernameField.incorrectStatePlaceholderLabelTextColor = incorrectColor;
    _usernameField.correctStateBorderColor = correctColor;
    _usernameField.correctStatePlaceholderLabelTextColor = correctColor;
    _usernameField.accessoryViewMode = LUNAccessoryViewModeAlways;
    
    [_usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView);
        make.centerY.equalTo(_scrollView).with.offset(20);
        make.width.mas_equalTo(_scrollView.frame.size.width * .8);
        make.height.mas_equalTo(40);
    }];
    
    _nameField.placeholderText = @"Name";
    [_nameField setPlaceholderFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:FONT_SIZE]];
    [_nameField setPlaceholderFontColor:fieldColor];
    [_nameField setUpperPlaceholderFontColor: fieldDetailColor];
    [_nameField setTextFontColor:fieldColor];
    [_nameField setUpperBorderColor:fieldDetailColor];
    [_nameField setBorderColor:fieldDetailColor];
    [_nameField setTintColor:fieldColor];
    [_nameField setPlaceholderAlignment:LUNPlaceholderAlignmentLeft];
    [_nameField setTextFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:FONT_SIZE]];
    _nameField.incorrectStateBorderColor = incorrectColor;
    _nameField.incorrectStatePlaceholderLabelTextColor = incorrectColor;
    _nameField.correctStateBorderColor = correctColor;
    _nameField.correctStatePlaceholderLabelTextColor = correctColor;
    
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_usernameField.mas_top).with.offset(-20);
        make.left.right.equalTo(_usernameField);
        make.height.equalTo(_usernameField);
    }];
    
    _passwordField.placeholderText = @"Password";
    [_passwordField setPlaceholderFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:FONT_SIZE]];
    [_passwordField setPlaceholderFontColor:fieldColor];
    [_passwordField setUpperPlaceholderFontColor:fieldDetailColor];
    [_passwordField setTextFontColor:fieldColor];
    [_passwordField setUpperBorderColor:fieldDetailColor];
    [_passwordField setBorderColor:fieldDetailColor];
    [_passwordField setTintColor:fieldColor];
    [_passwordField setPlaceholderAlignment:LUNPlaceholderAlignmentLeft];
    [_passwordField setTextFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:FONT_SIZE]];
    _passwordField.incorrectStateBorderColor = incorrectColor;
    _passwordField.incorrectStatePlaceholderLabelTextColor = incorrectColor;
    _passwordField.correctStateBorderColor = correctColor;
    _passwordField.correctStatePlaceholderLabelTextColor = correctColor;
    for (UIView *view in _passwordField.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [((UITextField *)view) setSecureTextEntry:YES];
        }
    }
    
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_usernameField.mas_bottom).with.offset(30);
        make.left.right.equalTo(_usernameField);
        make.height.equalTo(_usernameField);
    }];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerButton setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:FONT_SIZE]];
    [_registerButton setTitle:@"Create Account" forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton.layer setCornerRadius:12];
    [_registerButton setClipsToBounds:YES];
    [_registerButton setBackgroundColor:fieldColor];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_scrollView addSubview:_registerButton];
    
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordField.mas_bottom).with.offset(20);
        make.left.right.equalTo(_usernameField);
        make.height.equalTo(_usernameField);
    }];
    
    _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_signUpButton setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:FONT_SIZE]];
    [_signUpButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [_signUpButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton setBackgroundColor:fieldColor];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_scrollView addSubview:_signUpButton];
    
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordField.mas_bottom).with.offset(20);
        make.left.right.equalTo(_usernameField);
        make.height.equalTo(_usernameField);
    }];
}

-(void) registerAccount {
    MCTUser *new_user = [[MCTUser alloc] init];
    BOOL complete = YES;
    if (!_nameField.isCorrect) {
        complete = NO;
    } else {
        [new_user setName:_nameField.text];
    }
    if (!_usernameField.isCorrect) {
        complete = NO;
    } else {
        [new_user setUsername:_usernameField.text];
    }
    if (!_passwordField.isCorrect) {
        complete = NO;
    } else {
        [new_user setPassword:_passwordField.text];
    }
    if (complete) {
        [_contentManager setUser:new_user];
        [self.navigationController pushViewController:[MCTRegisterPickDietViewController new] animated:YES];
    }
}

-(void) signIn {
    
}

-(NSUInteger)numberOfSectionsInTextField:(LUNField *)LUNField{
    return 1;
}

-(NSUInteger)numberOfCharactersInSection:(NSInteger)section inTextField:(LUNField *)LUNField {
    return 24;
}

-(void)LUNFieldTextChanged:(LUNField *)LUNField {
    [_scrollView setContentOffset:CGPointMake(0, LUNField.frame.origin.y - self.view.frame.size.height * .4) animated:YES];
//    [_scrollView scrollRectToVisible:frame animated:YES];
}


-(BOOL)LUNField:(LUNField *)LUNField containsValidText:(NSString *)text {
    if (text.length < 1) {
        LUNField.incorrectLabelText = @"Field Required";
        return NO;
    }
    if ([LUNField isEqual:_usernameField]) {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        return [emailTest evaluateWithObject:text];
    } else if ([LUNField isEqual:_nameField]){

    } else if ([LUNField isEqual:_passwordField]){
        if (text.length < 7) {
            LUNField.incorrectLabelText = @"Too Short";
            return NO;
        } else if (text.length > 20){
            LUNField.incorrectLabelText = @"Too Long";
            return NO;
        }
    }
    LUNField.correctLabelText = @"Valid";
    return YES;
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [_scrollView endEditing:YES];
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_nameField resignFirstResponder];
}

@end
