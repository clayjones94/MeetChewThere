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

#define RATING_CELL_HEIGHT 25;

@implementation MCTRestaurantDetailViewController {
    UIImageView *_imageView;
    
    UIView *_introContainerView;
    UITableView *_ratingsTableView;
    
    UILabel *_costLabel;
    
    UIView *_eventsContainerView;
    UILabel *_eventsLabel;
    
    UIView *_contactContainerView;
    
    MKMapView *_mapView;
    UILabel *_phoneLabel;
    UILabel *_websiteLabel;
    
    MCTContentManager *_contentManager;
}

@synthesize restaurant = _restaurant;

-(void)viewDidLoad {
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = _restaurant.name;
    
    _contentManager = [MCTContentManager sharedManager];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutViews];
}

-(void) layoutViews {
    CGFloat LEFT_MARGIN = 10;
    CGFloat TOP_MARGIN = 10;
    
    _imageView = [[UIImageView alloc] init];
    [self.view addSubview:_imageView];
    [_imageView setImage:[UIImage imageNamed:_restaurant.imageName]];
    [_imageView setBackgroundColor:[UIColor redColor]];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(90);
    }];
    
    _introContainerView = [[UIView alloc] init];
    [self.view addSubview:_introContainerView];
    
    _ratingsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _ratingsTableView.delegate = self;
    _ratingsTableView.dataSource = self;
    [_ratingsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_introContainerView addSubview:_ratingsTableView];
    
    [_introContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(_imageView.mas_bottom);
        CGFloat cellHeight = RATING_CELL_HEIGHT;
        CGFloat tvHeight = cellHeight * (_restaurant.dietTags.count);
        make.height.mas_equalTo(tvHeight + cellHeight);
    }];
    
    UIView *separator = [UIView new];
    [separator setBackgroundColor:[UIColor lightGrayColor]];
    [_introContainerView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_introContainerView);
        make.height.mas_equalTo(1.f);
    }];
    
    [_ratingsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.mas_equalTo(_introContainerView);
        CGFloat cellHeight = RATING_CELL_HEIGHT;
        CGFloat tvHeight = cellHeight * (_restaurant.dietTags.count);
        make.height.mas_equalTo(tvHeight);
    }];
    
    _costLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:_costLabel];
    [_costLabel setText: [NSString stringWithFormat:@"%@ - American, Burgers, Shakes", [MCTUtils priceStringForRestaurant:_restaurant]]];
    [_costLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:12]];
    [_costLabel setTextColor:[UIColor grayColor]];
    [_costLabel sizeToFit];
    
    [_costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LEFT_MARGIN);
        CGFloat cellHeight = RATING_CELL_HEIGHT;
        make.centerY.equalTo(_ratingsTableView.mas_bottom).with.offset(cellHeight/2);
    }];
    
    _eventsContainerView = [[UIView alloc] init];
    [self.view addSubview:_eventsContainerView];
    [_eventsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(_introContainerView.mas_bottom);
        make.height.mas_equalTo(55);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[UIColor lightGrayColor]];
    [_eventsContainerView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_eventsContainerView);
        make.height.mas_equalTo(1.f);
    }];
    
    UILabel *guestDetailLabel = [[UILabel alloc] init];
    [_eventsContainerView addSubview:guestDetailLabel];
    [guestDetailLabel setText:@"Events"];
    [guestDetailLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:12]];
    [guestDetailLabel setTextColor:[UIColor lightGrayColor]];
    [guestDetailLabel sizeToFit];
    
    [guestDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(LEFT_MARGIN);
    }];
    
    _eventsLabel = [[UILabel alloc] init];
    [_eventsContainerView addSubview:_eventsLabel];
    [_eventsLabel setText:[NSString stringWithFormat:@"%lu upcoming events", (unsigned long)3]];
    [_eventsLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:16]];
    [_eventsLabel setTextColor:[UIColor blackColor]];
    [_eventsLabel sizeToFit];
    
    [_eventsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guestDetailLabel);
        make.top.equalTo(guestDetailLabel.mas_bottom);
    }];
    
    _contactContainerView = [[UIView alloc] init];
    [self.view addSubview:_contactContainerView];
    [_contactContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.top.equalTo(_eventsContainerView.mas_bottom);
    }];
    
    _mapView = [[MKMapView alloc] init];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:_restaurant.location.coordinate];
    [annotation setTitle:_restaurant.name]; //You can set the subtitle too
    [_mapView addAnnotation:annotation];
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    region.span = span;
    region.center = _restaurant.location.coordinate;
    [_mapView setRegion:region animated:TRUE];
    [_mapView regionThatFits:region];
    [_contactContainerView addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(_contactContainerView);
        make.top.equalTo(_contactContainerView).with.offset(10);
        CGFloat contactCellHeight = 40;
        make.bottom.equalTo(_contactContainerView).with.offset(-contactCellHeight);
    }];
    
    UIView *phoneView = [[UIView alloc] init];
    [_contactContainerView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contactContainerView);
        make.width.mas_equalTo(self.view.frame.size.width/2);
        make.top.equalTo(_mapView.mas_bottom);
        make.bottom.equalTo(_contactContainerView);
    }];
    
    _phoneLabel = [[UILabel alloc] init];
    [_phoneLabel setText:_restaurant.phone];
    [_phoneLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
    [_phoneLabel setTextColor:[MCTUtils defaultBarColor]];
    [phoneView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(phoneView);
    }];
    
    UIView *websiteView = [[UIView alloc] init];
    [_contactContainerView addSubview:websiteView];
    [websiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneView.mas_right);
        make.right.mas_equalTo(_contactContainerView);
        make.top.equalTo(_mapView.mas_bottom);
        make.bottom.equalTo(_contactContainerView);
    }];
    
    _websiteLabel = [[UILabel alloc] init];
    [_websiteLabel setText:@"Website"];
    [_websiteLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14]];
    [_websiteLabel setTextColor:[MCTUtils defaultBarColor]];
    [websiteView addSubview:_websiteLabel];
    [_websiteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(websiteView);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[UIColor lightGrayColor]];
    [_contactContainerView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(phoneView);
        make.right.equalTo(phoneView).with.offset(-.5f);
        make.width.mas_equalTo(1.f);
    }];
}

-(void)setRestaurant:(MCTRestaurant *)restaurant {
    _restaurant = restaurant;
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
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _restaurant.dietTags.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RATING_CELL_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
}

@end
