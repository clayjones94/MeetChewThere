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
#import "MCTRestaurantDetailViewController.h"
#import "MCTConstants.h"
#import "MCTUtils.h"

@implementation MCTDiscoverRestaurantsViewController {
    ZLDropDownMenu *_filterMenu;
    NSArray *_filterOptions;
    UITableView *_tableView;
    MCTContentManager *_contentManager;
    NSArray<MCTRestaurant *> *_restaurants;
    UITextField *_searchBar;
    NSInteger _filterIndex;
    NSString *_searchText;
}

-(void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _searchText = @"";
    [self layoutSearch];
    [self layoutTableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _contentManager = [MCTContentManager sharedManager];
    [_contentManager updateRestaurantsAndEvents];
    [self loadTableView];
    [_tableView reloadData];
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
    
    _filterOptions = @[@"Distance", @"Rating", @"Name", @"Price"];
    
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
    [bottomSeparator setBackgroundColor:[MCTUtils MCTSearchSeperatorColor]];
    [self.view addSubview:bottomSeparator];
    
    [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(_searchBar);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView * sideSeparator = [[UIView alloc] init];
    [sideSeparator setBackgroundColor:[MCTUtils MCTSearchSeperatorColor]];
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
    MCTRestaurantDetailViewController *vc = [MCTRestaurantDetailViewController new];
    [vc setRestaurant:_restaurants[indexPath.row]];
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
    [_searchBar resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = 0;
    if ([_restaurants count] > 0) {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections = 1;
        //yourTableView.backgroundView   = nil;
        _tableView.backgroundView = nil;
    }
    else {
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, _tableView.bounds.size.height)];
        [noDataLabel setText:[NSString stringWithFormat:@"There are no restaurants for search \"%@%\"", _searchText]];
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
    _filterIndex = indexPath.row;
    [self loadTableView];
}

-(void) loadTableView {
    [_contentManager searchRestaurantsBySearchText:_searchText];
    if([_filterOptions[_filterIndex]  isEqual: @"Rating"]){
        _restaurants = [_contentManager getAllRestaurantsByRating];
        [_tableView reloadData];
    }
    else if([_filterOptions[_filterIndex]  isEqual: @"Distance"]){
        _restaurants = [_contentManager getAllRestaurantsByDistance];
        [_tableView reloadData];
    }
    else if([_filterOptions[_filterIndex]  isEqual: @"Price"]){
        _restaurants = [_contentManager getAllRestaurantsByPrice];
        [_tableView reloadData];
    }
    else if([_filterOptions[_filterIndex]  isEqual: @"Name"]){
        _restaurants = [_contentManager getAllRestaurantsByName];
        [_tableView reloadData];
    }
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
    _searchText = textField.text;
    [self loadTableView];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    _searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self loadTableView];
    return YES;
}


@end
