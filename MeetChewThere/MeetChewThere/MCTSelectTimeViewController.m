//
//  MCTSelectTimeViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/18/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTSelectTimeViewController.h"

@implementation MCTSelectTimeViewController {
    UIDatePicker *_datePicker;
}

@synthesize event = _event;

-(void)viewDidLoad {
    [self.navigationItem setTitle:@"Pick a Time"];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(nextPage)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self layoutSubviews];
}

-(void) layoutSubviews {
    _datePicker = [UIDatePicker new];
    _datePicker.datePickerMode = UIDatePickerModeTime;
    _datePicker.frame = self.view.frame;
    [self.view addSubview:_datePicker];
}

-(void) nextPage {
    MCTSelectTimeViewController *vc = [MCTSelectTimeViewController new];
    vc.event = _event;
}

-(void) cancelPage {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
