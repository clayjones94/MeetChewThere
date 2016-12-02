//
//  MCTSelectTimeViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/18/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTSelectTimeViewController.h"
#import "MCTSelectRestaurantViewController.h"
#import "MCTUtils.h"

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
    _datePicker.minuteInterval = 15;
    _datePicker.frame = self.view.frame;
    [self.view addSubview:_datePicker];
}

-(void) nextPage {
    MCTSelectRestaurantViewController *vc = [MCTSelectRestaurantViewController new];
    _event.date = [MCTUtils dateWithYear:[MCTUtils getYearForDate:_event.date] month:[MCTUtils getMonthForDate:_event.date] day:[MCTUtils getDayForDate:_event.date] hour:[MCTUtils getHourForDate:_datePicker.date] minute:[MCTUtils getMinuteForDate:_datePicker.date]];
    vc.event = _event;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
