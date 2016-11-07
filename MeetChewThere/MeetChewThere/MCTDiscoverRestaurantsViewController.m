//
//  MCTDiscoverRestaurantsViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTDiscoverRestaurantsViewController.h"
#import "ZLDropDownMenu.h"
#import "MCTRestaurantTableViewCell.h"
#import "MCTContentManager.h"
#import "MCTRestaurant.h"
#import "Masonry.h"

@implementation MCTDiscoverRestaurantsViewController {
    ZLDropDownMenu *_filterMenu;
    NSArray *_filterOptions;
    UITableView *_tableView;
    MCTContentManager *_contentManager;
    NSArray<MCTRestaurant *> *_restaurants;
    UITextField *_searchBar;
}

-(void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _contentManager = [MCTContentManager sharedManager];
    _restaurants = [_contentManager getAllRestaurants];
    
    [self layoutSearch];
    [self layoutTableView];
}

-(void) layoutSearch {
    _searchBar = [[UITextField alloc] init];
    UIView *leftView = [[UIView alloc] init];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
    [icon sizeToFit];
    [leftView setFrame:CGRectMake(0, 0, icon.frame.size.width + 10, icon.frame.size.height)];
    [icon setFrame:CGRectMake(0, 0, icon.frame.size.width, icon.frame.size.height)];
    [leftView addSubview:icon];
    
    [_searchBar setLeftView:leftView];
    [_searchBar setLeftViewMode:UITextFieldViewModeUnlessEditing];
    _searchBar.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    [_searchBar setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:18]];
    [_searchBar setPlaceholder:@"Search"];
    [_searchBar setReturnKeyType:UIReturnKeySearch];
    [_searchBar setDelegate:self];
    [self.view addSubview:_searchBar];
    
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(self.view.frame.size.width * 3/4);
    }];
    
    _filterOptions = @[@"Distance", @"Rating", @"Events"];
    
    _filterMenu = [[ZLDropDownMenu alloc] init];
    _filterMenu.delegate = self;
    _filterMenu.dataSource = self;
    [self.view addSubview:_filterMenu];
    [_filterMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view);
        make.bottom.equalTo(_searchBar);
        make.left.equalTo(_searchBar.mas_right);
    }];
    
    UIView * bottomSeparator = [[UIView alloc] init];
    [bottomSeparator setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:bottomSeparator];
    
    [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(_searchBar);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(1.0);
    }];
    
    UIView * sideSeparator = [[UIView alloc] init];
    [sideSeparator setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:sideSeparator];
    
    [sideSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.equalTo(_searchBar);
        make.width.mas_equalTo(1.0);
    }];
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

#pragma TableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"Restaurant Cell";
    MCTRestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MCTRestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.restaurant = _restaurants[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _restaurants.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    [_searchBar resignFirstResponder];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}

#pragma Filter Menu

- (NSInteger)numberOfColumnsInMenu:(ZLDropDownMenu *)menu {
    return 4;
}

- (NSInteger)menu:(ZLDropDownMenu *)menu numberOfRowsInColumns:(NSInteger)column {
    return _filterOptions.count;
}

- (NSString *)menu:(ZLDropDownMenu *)menu titleForColumn:(NSInteger)column {
    return @"Sort by";
}

- (NSString *)menu:(ZLDropDownMenu *)menu titleForRowAtIndexPath:(ZLIndexPath *)indexPath {
    return _filterOptions[indexPath.row];
}

- (void)menu:(ZLDropDownMenu *)menu didSelectRowAtIndexPath:(ZLIndexPath *)indexPath {
    [_filterMenu reloadInputViews];
    [_searchBar resignFirstResponder];
}

#pragma text field

-(BOOL)textFieldShouldBeginEditing:(UITextView *)textView {
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextView *)textView {
    [_searchBar resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_searchBar resignFirstResponder];
    NSString *searchText = textField.text;
    return YES;
}

-(void)textFieldDidChange:(UITextField *)textField {
    NSString *searchText = textField.text;
    [_tableView reloadData];
}

@end
