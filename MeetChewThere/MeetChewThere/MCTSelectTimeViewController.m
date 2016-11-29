//
//  MCTSelectTimeViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/18/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTSelectTimeViewController.h"
#import "MCTSelectRestaurantViewController.h"

@implementation MCTSelectTimeViewController {
    UIDatePicker *_datePicker;
}

@synthesize event = _event;

-(void)viewDidLoad {
    [self.navigationItem setTitle:@"Pick a Time"];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextPage)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self layoutSubviews];
}

-(void) layoutSubviews {
    _datePicker = [UIDatePicker new];
    _datePicker.datePickerMode = UIDatePickerModeTime;
    _datePicker.frame = self.view.frame;
    [self.view addSubview:_datePicker];
}

-(void) nextPage {
    MCTSelectRestaurantViewController *vc = [MCTSelectRestaurantViewController new];
    vc.event = _event;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
