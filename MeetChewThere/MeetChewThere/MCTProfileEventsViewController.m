//
//  MCTProfileEventsViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTProfileEventsViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "MCTEventTableViewCell.h"
#import "MCTUtils.h"
#import "MCTConstants.h"
#import "MCTContentManager.h"
#import "Masonry.h"
#import "MCTEventDetailViewController.h"

@implementation MCTProfileEventsViewController {
    
    UIView *_topBar;
    HMSegmentedControl *_segControl;
    UITableView *_tableView;
    NSArray<MCTEvent *> *_events;
    MCTContentManager *_contentManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:YES];
    
    _contentManager = [MCTContentManager sharedManager];
    _events = [_contentManager getUserPastEvents];
    
    [self layoutSegmentedControl];
    [self layoutTableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:YES];
    
    if (_segControl.selectedSegmentIndex == 0) {
        _events = [_contentManager getUserPastEvents];
    } else if(_segControl.selectedSegmentIndex == 1) {
        _events = [_contentManager getUserUpcomingEvents];
    } else {
        _events = [_contentManager getUserHostingEvents];
    }
    [_tableView reloadData];
}

-(void) layoutSegmentedControl {
    _topBar = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)];
    [_topBar setBackgroundColor:[MCTUtils defaultBarColor]];
    [self.view addSubview:_topBar];
    
    _segControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Past",@"Upcoming", @"Hosting"]];
    [_segControl setBackgroundColor:[UIColor clearColor]];
    [_segControl addTarget:self action:@selector(segmentedControlChangedValue) forControlEvents:UIControlEventValueChanged];
    NSDictionary *titleTextAttr = @{
                                    NSFontAttributeName:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:15],
                                    NSForegroundColorAttributeName: [UIColor whiteColor]
                                    };
    NSDictionary *selectedTitleTextAttr = @{
                                            NSFontAttributeName:[UIFont fontWithName:MCT_BOLD_FONT_NAME size:15],
                                            NSForegroundColorAttributeName:[UIColor whiteColor]
                                            };
    
    _segControl.titleTextAttributes = titleTextAttr;
    _segControl.selectedTitleTextAttributes = selectedTitleTextAttr;
    _segControl.selectionIndicatorColor = [UIColor whiteColor];
    _segControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segControl.selectionIndicatorHeight = 3.0f;
    _segControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, -2, 0);
    _segControl.borderType = HMSegmentedControlBorderTypeBottom;
    _segControl.borderWidth = 0.0f;
    _segControl.borderColor = [UIColor clearColor];
    [_segControl setSelectedSegmentIndex:1];
    [_segControl setFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, _topBar.frame.size.width, _topBar.frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height)];
    [_topBar addSubview:_segControl];
}

-(void) layoutTableView {
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBar.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma TABLEVIEW DELEGATE/DATASOURCE

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _events.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Event";
    MCTEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MCTEventTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    [cell setEvent:_events[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    MCTEvent *event = _events[indexPath.row];
    MCTEventDetailViewController *vc = [[MCTEventDetailViewController alloc] init];
    vc.event = event;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = 0;
    if ([_events count] > 0) {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections = 1;
        //yourTableView.backgroundView   = nil;
        _tableView.backgroundView = nil;
    }
    else {
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, _tableView.bounds.size.height)];
        if (_segControl.selectedSegmentIndex == 0) {
            noDataLabel.text = @"You have no Past Events :(";
        } else if(_segControl.selectedSegmentIndex == 1) {
            noDataLabel.text = @"You have no Upcoming Events :(";
        } else {
            noDataLabel.text = @"You are not hosting Any Events :(";
        }
        noDataLabel.textColor = [UIColor blackColor];
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        [noDataLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:14]];
        [noDataLabel setNumberOfLines:0];
        [noDataLabel setLineBreakMode:NSLineBreakByWordWrapping];
        _tableView.backgroundView = noDataLabel;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return numOfSections;
}

-(void) segmentedControlChangedValue {
    if (_segControl.selectedSegmentIndex == 0) {
        _events = [_contentManager getUserPastEvents];
    } else if(_segControl.selectedSegmentIndex == 1) {
        _events = [_contentManager getUserUpcomingEvents];
    } else {
        _events = [_contentManager getUserHostingEvents];
    }
    [_tableView reloadData];
}

@end
