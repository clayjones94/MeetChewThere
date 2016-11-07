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

@implementation MCTDiscoverEventsViewController {

    ZLDropDownMenu *_filterMenu;
    NSArray *_filterTitles;
    NSMutableDictionary *_filterOptions;
    UITableView *_tableView;
    MCTContentManager *_contentManager;
    NSArray<MCTEvent *> *_events;
}

int _selectedIndexes[4] = {0,0,0,0};

-(void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _contentManager = [MCTContentManager sharedManager];
    _events = [_contentManager getAllEvents];
    
    [self layoutDropDownMenu];
    [self layoutTableView];
}

-(void) layoutDropDownMenu {
    _filterTitles = @[@"Date", @"Time", @"Distance", @"Price"];
    _filterOptions = [[NSMutableDictionary alloc] initWithDictionary:
    @{
      _filterTitles[0]: @[@"Anytime", @"Today", @"Tomorrow", @"This Week", @"Next Week"],
      _filterTitles[1]: @[@"Anytime", @"Morning", @"Mid Day", @"Afternoon", @"Evening", @"Late Night"],
      _filterTitles[2]: @[@1, @5, @10, @25, @50],
      _filterTitles[3]: @[@1, @2, @3, @4, @5],
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
        return [NSString stringWithFormat:@"%@ mi",[((NSArray *)_filterOptions[_filterTitles[indexPath.column]]) objectAtIndex:indexPath.row]];
    }
    if (indexPath.column == 3) {
        int price = [[((NSArray *)_filterOptions[_filterTitles[indexPath.column]]) objectAtIndex:indexPath.row] intValue];
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
    
    [_filterMenu reloadInputViews];
}

@end
