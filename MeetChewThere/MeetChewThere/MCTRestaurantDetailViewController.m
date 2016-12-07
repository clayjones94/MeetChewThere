//
//  MCTRestaurantDetailViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/5/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTRestaurantDetailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Masonry.h"
#import "MCTUtils.h"
#import "MCTContentManager.h"
#import "MCTDietRatingsTableViewCell.h"
#import <ChameleonFramework/Chameleon.h>
#import "MCTRestaurantEventTableViewCell.h"
#import "MCTReviewsViewController.h"
#import "MCTConstants.h"
#import "MCTEvent.h"
#import "MCTEventDetailViewController.h"

#define RATING_CELL_HEIGHT 40;

@implementation MCTRestaurantDetailViewController {
    UIImageView *_imageView;
    
    UIView *_introContainerView;
    
    UIView *_ratingsContainerView;
    UITableView *_ratingsTableView;
    
    UILabel *_costLabel;
    
    UIView *_eventsContainerView;
    UILabel *_eventsLabel;
    UITableView *_eventsTableView;
    
    UIView *_contactContainerView;
    
    MKMapView *_mapView;
    UILabel *_phoneLabel;
    UILabel *_websiteLabel;
    
    UIButton *_backButton;
    
    MCTContentManager *_contentManager;
    UIScrollView *_scrollView;
    
    NSArray<MCTEvent *> * _events;
}

@synthesize restaurant = _restaurant;

-(void)setRestaurant:(MCTRestaurant *)restaurant {
    _restaurant = restaurant;
    _contentManager = [MCTContentManager sharedManager];
    _events = [_contentManager getEventsForRestaurant:_restaurant];
    [_eventsTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidLoad {
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = _restaurant.name;
    
    _contentManager = [MCTContentManager sharedManager];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupScrollView];
    [self layoutViews];
}

-(void) setupScrollView {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame: self.view.frame];
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 1.8)];
    [_scrollView setBackgroundColor:[MCTUtils MCTRestaurantBackground]];
    [_scrollView setShowsVerticalScrollIndicator:YES];
    [_scrollView setBounces:NO];
    [self.view addSubview:_scrollView];
}

-(void) layoutViews {
    CGFloat LEFT_MARGIN = 10;
    
    _imageView = [[UIImageView alloc] init];
    [_scrollView addSubview:_imageView];
    [_imageView setImage:[UIImage imageNamed:_restaurant.imageName]];
    [_imageView setBackgroundColor:[UIColor grayColor]];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setClipsToBounds:YES];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    UIView *imageOverlay = [[UIView alloc] init];
    [imageOverlay setBackgroundColor:[MCTUtils MCTRestaurantBackground]];
    [_imageView addSubview:imageOverlay];
    [imageOverlay setAlpha:.1];
    
    [imageOverlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(_imageView);
    }];
    
    
    //Add gradient overlay
    UIView *gradientView = [[UIView alloc] init];
    UIColor *gradientColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) andColors:@[[UIColor clearColor], [MCTUtils MCTRestaurantBackground]]];
    [gradientView setBackgroundColor:gradientColor];
    [_imageView addSubview:gradientView];
    
    [gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(_imageView);
    }];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:[[UIImage imageNamed:@"back"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setClipsToBounds:YES];
    [_backButton setBackgroundColor:[UIColor clearColor]];
    [_backButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:_backButton];
    
    [_backButton sizeToFit];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_scrollView).with.offset(20);
    }];
    
    _introContainerView = [[UIView alloc] init];
    [_scrollView addSubview:_introContainerView];
    
    [_introContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView);
        make.width.equalTo(self.view);
        make.top.equalTo(_imageView.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:nameLabel];
    [nameLabel setText: _restaurant.name];
    [nameLabel setFont:[UIFont fontWithName:MCT_BOLD_FONT_NAME size:24]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel sizeToFit];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(_introContainerView);
    }];
    
    _costLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:_costLabel];
    [_costLabel setText: [NSString stringWithFormat:@"%@ - American, Burgers, Shakes", [MCTUtils priceStringForRestaurant:_restaurant]]];
    [_costLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:14]];
    [_costLabel setTextColor:[UIColor whiteColor]];
    [_costLabel sizeToFit];
    
    [_costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).with.offset(2);
    }];
    
    UIView *separator = [UIView new];
    [separator setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_introContainerView);
        make.top.equalTo(_introContainerView.mas_bottom).with.offset(15);
        make.height.mas_equalTo(1.f);
        make.width.mas_equalTo(80.f);
    }];
    
    
    UIView *buttonContainer = [[UIView alloc] init];
    [_scrollView addSubview:buttonContainer];
    
    [buttonContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView);
        make.width.equalTo(self.view);
        make.top.equalTo(separator.mas_bottom).with.offset(15);
        make.height.mas_equalTo(60);
    }];
    
    NSArray *buttonNames = @[@"phone", @"website", @"car"];
    
    UIButton *button = [[UIButton alloc] init];
    [buttonContainer addSubview:button];
    [button setBackgroundImage:[[UIImage imageNamed:buttonNames[0]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setClipsToBounds:YES];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTintColor:[UIColor whiteColor]];
    [button sizeToFit];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonContainer).with.offset(10);
        make.centerX.equalTo(buttonContainer).with.offset(-70);
    }];
    
    button = [[UIButton alloc] init];
    [buttonContainer addSubview:button];
    [button setBackgroundImage:[[UIImage imageNamed:buttonNames[1]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setClipsToBounds:YES];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTintColor:[UIColor whiteColor]];
    [button sizeToFit];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonContainer).with.offset(10);
        make.centerX.equalTo(buttonContainer);
    }];
    
    button = [[UIButton alloc] init];
    [buttonContainer addSubview:button];
    [button setBackgroundImage:[[UIImage imageNamed:buttonNames[2]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setClipsToBounds:YES];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTintColor:[UIColor whiteColor]];
    [button sizeToFit];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonContainer).with.offset(10);
        make.centerX.equalTo(buttonContainer).with.offset(70);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(buttonContainer);
        make.top.equalTo(buttonContainer.mas_bottom).with.offset(15);
        make.height.mas_equalTo(1.f);
        make.width.mas_equalTo(80.f);
    }];
    
    _ratingsContainerView = [[UIView alloc] init];
    [_scrollView addSubview:_ratingsContainerView];
    
    _ratingsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _ratingsTableView.delegate = self;
    _ratingsTableView.dataSource = self;
    [_ratingsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_ratingsTableView setBackgroundColor:[UIColor clearColor]];
    [_ratingsContainerView addSubview:_ratingsTableView];
    
    [_ratingsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(_introContainerView);
        make.top.equalTo(separator.mas_bottom).with.offset(20);
        CGFloat cellHeight = RATING_CELL_HEIGHT;
        CGFloat tvHeight = cellHeight * (_restaurant.dietTags.count);
        make.height.mas_equalTo(tvHeight);
    }];
    
    [_ratingsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(_ratingsContainerView);
        make.top.equalTo(_ratingsContainerView);
        CGFloat cellHeight = RATING_CELL_HEIGHT;
        CGFloat tvHeight = cellHeight * (_restaurant.dietTags.count);
        make.height.mas_equalTo(tvHeight);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[UIColor whiteColor]];
    [_ratingsContainerView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_ratingsContainerView);
        make.top.equalTo(_ratingsContainerView.mas_bottom).with.offset(20);
        make.height.mas_equalTo(1.f);
        make.width.mas_equalTo(80.f);
    }];
    
    _eventsContainerView = [[UIView alloc] init];
    [_scrollView addSubview:_eventsContainerView];
    
    UILabel *eventDetailLabel = [[UILabel alloc] init];
    [_eventsContainerView addSubview:eventDetailLabel];
    if (_events.count > 0) {
        [eventDetailLabel setText:@"Upcoming Events"];
        [eventDetailLabel setFont:[UIFont fontWithName:MCT_BOLD_FONT_NAME size:18]];
        [eventDetailLabel setTextColor:[UIColor whiteColor]];
    } else {
        [eventDetailLabel setText:@"No Upcoming Events"];
        [eventDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:16]];
        [eventDetailLabel setTextColor:[MCTUtils MCTLightGrayColor]];
    }
    [eventDetailLabel sizeToFit];
    
    [eventDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LEFT_MARGIN);
        make.centerX.equalTo(_eventsContainerView);
    }];
    
    _eventsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _eventsTableView.delegate = self;
    _eventsTableView.dataSource = self;
    [_eventsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_eventsTableView setBackgroundColor:[UIColor clearColor]];
    [_eventsContainerView addSubview:_eventsTableView];
    
    [_eventsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(_introContainerView);
        make.top.equalTo(separator.mas_bottom).with.offset(20);
        CGFloat cellHeight = 80;
        CGFloat tvHeight = cellHeight * (_events.count);
        make.height.mas_equalTo(tvHeight);
    }];
    
    [_eventsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(_eventsContainerView);
        make.top.equalTo(eventDetailLabel.mas_bottom).with.offset(20);
        CGFloat cellHeight = 80;
        CGFloat tvHeight = cellHeight * (_events.count);
        make.height.mas_equalTo(tvHeight);
    }];
    
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 600 + 60 * _events.count + _restaurant.dietTags.count * 40)];
}

-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma TableView Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if ([tableView isEqual:_ratingsTableView]) {
        NSString *identifier = @"rating cell";
        MCTDietRatingsTableViewCell *ratingsCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!ratingsCell){
            ratingsCell = [[MCTDietRatingsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        ratingsCell.dietTag = _restaurant.dietTags[indexPath.row];
        return ratingsCell;
    } else if([tableView isEqual:_eventsTableView]) {
        NSString *identifier = @"event cell";
        MCTRestaurantEventTableViewCell *eventCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(!eventCell){
            eventCell = [[MCTRestaurantEventTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        eventCell.event = _events[indexPath.row];
        return eventCell;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_ratingsTableView]) {
        return _restaurant.dietTags.count;
    } else if([tableView isEqual:_eventsTableView]) {
        return _events.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_ratingsTableView]) {
        return RATING_CELL_HEIGHT;
    } else if([tableView isEqual:_eventsTableView]) {
        return 60;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    if ([tableView isEqual:_ratingsTableView]) {
        MCTReviewsViewController *vc = [MCTReviewsViewController new];
        vc.dietTag = _restaurant.dietTags[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        MCTEventDetailViewController *vc = [MCTEventDetailViewController new];
        vc.event = _events[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
