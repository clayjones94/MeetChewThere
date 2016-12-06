//
//  MCTAddEventDetailsViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/18/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTAddEventDetailsViewController.h"
#import "MCTConstants.h"
#import "Masonry.h"
#import "MCTUtils.h"
#import "MCTSelectDateViewController.h"
#import "MCTContentManager.h"

@implementation MCTAddEventDetailsViewController {
    UITextField *_nameField;
    UITextView *_descriptionField;
    UITextField *_capacityField;
}

@synthesize event = _event;

-(void)viewDidLoad {
    [super viewDidLoad];
    _event = [MCTEvent new];
    _event.admin = [MCTContentManager sharedManager].user;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"New Event"];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextPage)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPage)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self checkForBackButton];
    
    [self layoutViews];
}

-(void) layoutViews {
    _nameField = [UITextField new];
    [self.view addSubview:_nameField];
    [_nameField setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:18]];
    [_nameField setPlaceholder:@"Name Your Event"];
    [_nameField setTextAlignment:NSTextAlignmentCenter];
    [_nameField setBackgroundColor:[UIColor whiteColor]];
    [_nameField becomeFirstResponder];
    _nameField.delegate = self;
    
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.view.frame.size.height * .20);
        make.width.mas_equalTo(self.view.frame.size.width * .8);
        make.height.mas_equalTo(40);
    }];
    
//    UIView *separator = [UIView new];
//    [separator setBackgroundColor:[MCTUtils defaultBarColor]];
//    [self.view addSubview:separator];
//    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.centerX.width.equalTo(_nameField);
//        make.height.mas_equalTo(1.0f);
//    }];
    
    UILabel *nameDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:nameDetailLabel];
    [nameDetailLabel setText:@"Name"];
    [nameDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [nameDetailLabel setTextColor:[MCTUtils defaultBarColor]];
    [nameDetailLabel sizeToFit];
    
    [nameDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nameField);
        make.bottom.equalTo(_nameField.mas_top);
    }];
    
    _capacityField = [UITextField new];
    [self.view addSubview:_capacityField];
    [_capacityField setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:18]];
    _capacityField.placeholder = @"How many people can come?";
    _capacityField.delegate = self;
    _capacityField.textColor = [UIColor blackColor];
    [_capacityField setTextAlignment:NSTextAlignmentCenter];
    [_capacityField setBackgroundColor:[UIColor whiteColor]];
    [_capacityField setKeyboardType:UIKeyboardTypeNumberPad];
    
    
    [_capacityField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(_nameField.mas_bottom).with.offset(30);
        make.width.equalTo(_nameField);
        make.height.mas_equalTo(40);
    }];
    
    //    separator = [UIView new];
    //    [separator setBackgroundColor:[MCTUtils defaultBarColor]];
    //    [self.view addSubview:separator];
    //    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.width.centerX.equalTo(_descriptionField);
    //        make.height.mas_equalTo(1.0f);
    //    }];
    
    UILabel *capacityDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:capacityDetailLabel];
    [capacityDetailLabel setText:@"Capacity"];
    [capacityDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [capacityDetailLabel setTextColor:[MCTUtils defaultBarColor]];
    [capacityDetailLabel sizeToFit];
    
    [capacityDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_capacityField);
        make.bottom.equalTo(_capacityField.mas_top);
    }];
    
    _descriptionField = [UITextView new];
    [self.view addSubview:_descriptionField];
    [_descriptionField setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:18]];
    _descriptionField.text = @"Describe Your Event...";
    _descriptionField.textColor = [UIColor lightGrayColor];
    _descriptionField.delegate = self;
    [_descriptionField setTextAlignment:NSTextAlignmentCenter];
    [_descriptionField setBackgroundColor:[UIColor whiteColor]];
    
    
    [_descriptionField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(_capacityField.mas_bottom).with.offset(30);
        make.width.equalTo(_capacityField);
        make.height.mas_equalTo(40);
    }];
    
//    separator = [UIView new];
//    [separator setBackgroundColor:[MCTUtils defaultBarColor]];
//    [self.view addSubview:separator];
//    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.width.centerX.equalTo(_descriptionField);
//        make.height.mas_equalTo(1.0f);
//    }];
    
    UILabel *descriptionDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:descriptionDetailLabel];
    [descriptionDetailLabel setText:@"Description"];
    [descriptionDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [descriptionDetailLabel setTextColor:[MCTUtils defaultBarColor]];
    [descriptionDetailLabel sizeToFit];
    
    [descriptionDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_descriptionField);
        make.bottom.equalTo(_descriptionField.mas_top);
    }];
}

-(void) nextPage {
    _event.name = _nameField.text;
    _event.capacity = [_capacityField.text integerValue];
    _event.details = _descriptionField.text;
    _event.dietTags = [[NSMutableArray alloc] init];
    _event.guests = [[NSMutableArray alloc] init];
    [_event.guests addObject:[MCTContentManager sharedManager].user];
    
    MCTSelectDateViewController *vc = [MCTSelectDateViewController new];
    vc.event = _event;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) cancelPage {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    _descriptionField.text = @"";
    _descriptionField.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView {
    if(_descriptionField.text.length == 0){
        _descriptionField.textColor = [UIColor lightGrayColor];
        _descriptionField.text = @"Describe Your Event...";
        [_descriptionField resignFirstResponder];
    }
    [self checkForBackButton];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self checkForBackButton];
    return YES;
}

-(void) checkForBackButton {
    if(([_descriptionField.text isEqualToString:@"Describe Your Event..."] || [_descriptionField.text isEqualToString:@""]) || !_capacityField.text || !_nameField.text) {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    } else {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
}

@end
