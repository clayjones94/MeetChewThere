//
//  MCTSelectDateViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/18/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTSelectDateViewController.h"
#import "MCTSelectTimeViewController.h"

@implementation MCTSelectDateViewController {
    RSDFDatePickerView *_datePickerView;
}

@synthesize event = _event;

-(void)viewDidLoad {
    [self.navigationItem setTitle:@"Pick a Date"];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextPage)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    _event.date = [NSDate date];
    
    [self layoutSubviews];
}

-(void) layoutSubviews {
    _datePickerView = [[RSDFDatePickerView alloc] initWithFrame:self.view.bounds];
    _datePickerView.delegate = self;
    _datePickerView.dataSource = self;
    [self.view addSubview:_datePickerView];
}

// Returns YES if the date should be highlighted or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date
{
    if (date < [NSDate date]) {
        return NO;
    }
    return YES;
}

// Returns YES if the date should be selected or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date
{
    if ( [date timeIntervalSinceDate:[NSDate date]] < -60*60*24 ) {
        return NO;
    }
    return YES;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date
{
    _event.date = date;
}

// Returns YES if the date should be marked or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldMarkDate:(NSDate *)date
{
    // The date is an `NSDate` object without time components.
    // So, we need to use dates without time components.
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *todayComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    return [date isEqual:today];
}

// Returns the color of the default mark image for the specified date.
- (UIColor *)datePickerView:(RSDFDatePickerView *)view markImageColorForDate:(NSDate *)date
{
    if (arc4random() % 2 == 0) {
        return [UIColor grayColor];
    } else {
        return [UIColor greenColor];
    }
}

// Returns the mark image for the specified date.
- (UIImage *)datePickerView:(RSDFDatePickerView *)view markImageForDate:(NSDate *)date
{
    if (arc4random() % 2 == 0) {
        return [UIImage imageNamed:@"img_gray_mark"];
    } else {
        return [UIImage imageNamed:@"img_green_mark"];
    }
}

-(void) nextPage {
    MCTSelectTimeViewController *vc = [MCTSelectTimeViewController new];
    vc.event = _event;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
