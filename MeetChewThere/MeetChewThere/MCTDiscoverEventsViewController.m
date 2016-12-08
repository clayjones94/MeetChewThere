//
//  MCTDiscoverEventsViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTDiscoverEventsViewController.h"
#import "Masonry.h"
#import "MCTContentManager.h"
#import "MCTEventTableViewCell.h"
#import "MCTEvent.h"
#import "MCTEventDetailViewController.h"
#import "MCTConstants.h"

@implementation MCTDiscoverEventsViewController {

    ZLDropDownMenu *_filterMenu;
    NSArray *_filterTitles;
    NSMutableDictionary *_filterOptions;
    UITableView *_tableView;
    MCTContentManager *_contentManager;
    NSArray<MCTEvent *> *_events;
}

int _selectedIndexes[4] = {0,0,3,0};

-(void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutDropDownMenu];
    [self layoutTableView];
}

-(void)viewWillAppear:(BOOL)animated {
    _contentManager = [MCTContentManager sharedManager];
    [_contentManager updateRestaurantsAndEvents];
    [self updateEventsTable];
}

-(void) layoutDropDownMenu {
    _filterTitles = @[@"Date", @"Time", @"Distance", @"Price"];
    _filterOptions = [[NSMutableDictionary alloc] initWithDictionary:
    @{
      _filterTitles[0]: @[@"Anytime", @"Today", @"This Week", @"Next Week"],
      _filterTitles[1]: @[@"Anytime", @"Morning", @"Afternoon", @"Evening"],
      _filterTitles[2]: @[@0, @1, @10, @25, @50],
      _filterTitles[3]: @[@0, @1, @2, @3],
      }];
    
    _filterMenu = [[ZLDropDownMenu alloc] init];
    _filterMenu.delegate = self;
    _filterMenu.dataSource = self;
    [self.view addSubview:_filterMenu];
    [_filterMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.view addSubview:_filterMenu];
}

-(void) layoutTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_filterMenu.mas_bottom);
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
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = 0;
    if ([_events count] > 0) {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections = 1;
        _tableView.backgroundView = nil;
    }
    else {
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, _tableView.bounds.size.height)];
        [noDataLabel setText:[NSString stringWithFormat:@"There are no events for these filters."]];
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

#pragma MENU-DELEGATE

- (NSInteger)numberOfColumnsInMenu:(ZLDropDownMenu *)menu {
    return _filterTitles.count;
}

- (NSInteger)menu:(ZLDropDownMenu *)menu numberOfRowsInColumns:(NSInteger)column {
    return ((NSArray *)_filterOptions[_filterTitles[column]]).count;
}

- (NSString *)menu:(ZLDropDownMenu *)menu titleForColumn:(NSInteger)column {
    return [_filterTitles objectAtIndex:column];
}

- (NSString *)menu:(ZLDropDownMenu *)menu titleForRowAtIndexPath:(ZLIndexPath *)indexPath {
    if (indexPath.column == 2) {
        if ([[((NSArray *)_filterOptions[_filterTitles[indexPath.column]]) objectAtIndex:indexPath.row] integerValue] == 0) {
            return @"Any Distance";
        }
        return [NSString stringWithFormat:@"%@ mi",[((NSArray *)_filterOptions[_filterTitles[indexPath.column]]) objectAtIndex:indexPath.row]];
    }
    if (indexPath.column == 3) {
        int price = [[((NSArray *)_filterOptions[_filterTitles[indexPath.column]]) objectAtIndex:indexPath.row] intValue];
        if (price == 0) {
            return @"Any Price";
        }
        NSMutableString *str = [[NSMutableString alloc] initWithString: @""];
        for (int i = 0; i < price; i++) {
            [str appendString:@"$"];
        }
        return str;
    }
    return [NSString stringWithFormat:@"%@",[((NSArray *)_filterOptions[_filterTitles[indexPath.column]]) objectAtIndex:indexPath.row]];
}

- (void)menu:(ZLDropDownMenu *)menu didSelectRowAtIndexPath:(ZLIndexPath *)indexPath {
    _selectedIndexes[(int)indexPath.column] = (int)indexPath.row;

    [self updateEventsTable];
    [_filterMenu reloadInputViews];
}

-(void) updateEventsTable {
    _events = [_contentManager getEventsForPrice:_filterOptions[_filterTitles[3]][_selectedIndexes[3]] beforeDate:_filterOptions[_filterTitles[0]][_selectedIndexes[0]] withinDistanceMiles:_filterOptions[_filterTitles[2]][_selectedIndexes[2]] forTimeOfDay:_filterOptions[_filterTitles[1]][_selectedIndexes[1]]];
    [_tableView reloadData];
}

@end
