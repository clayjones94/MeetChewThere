//
//  MCTEventDetailViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/5/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTEventDetailViewController.h"
#import "Masonry.h"
#import "MCTUtils.h"
#import "MCTConstants.h"
#import "MCTContentManager.h"
#import "MCTRestaurantDetailViewController.h"
#import <ChameleonFramework/Chameleon.h>

@implementation MCTEventDetailViewController {
    UIImageView *_imageView;
    
    UIView *_introContainerView;
    UILabel *_nameLabel;
    UILabel *_restaurantButton;
    UILabel *_monthLabel;
    UILabel *_dateLabel;
    UILabel *_timeLabel;
    
    UIView *_guestsContainerView;
    UILabel *_guestsLabel;
    
    UIView *_descriptionContainerView;
    UILabel *_descriptionLabel;
    
    UIButton *_joinButton;
    UIScrollView *_scrollView;
    UIButton *_backButton;
    
    MCTContentManager *_contentManager;
}

@synthesize event = _event;

- (void)setEvent:(MCTEvent *)event {
    _event = event;
    _contentManager = [MCTContentManager sharedManager];
}

-(void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBarHidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _contentManager = [MCTContentManager sharedManager];
    [self setupScrollView];
    [self layoutViews];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

-(void) setupScrollView {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame: self.view.frame];
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 1.3)];
    [_scrollView setBackgroundColor:[MCTUtils MCTRestaurantBackground]];
    [_scrollView setShowsVerticalScrollIndicator:YES];
    [_scrollView setBounces:NO];
    [self.view addSubview:_scrollView];
}

-(void) layoutViews {
    CGFloat LEFT_MARGIN = 15;
    
    _imageView = [[UIImageView alloc] init];
    [_scrollView addSubview:_imageView];
    [_imageView setImage:[UIImage imageNamed:_event.restaurant.imageName]];
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
    
    _nameLabel = [[UILabel alloc] init];
    [_scrollView addSubview:_nameLabel];
    [_nameLabel setText:_event.name];
    [_nameLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:22]];
    [_nameLabel setTextColor:[UIColor whiteColor]];
    [_nameLabel sizeToFit];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_imageView.mas_bottom);
    }];
    
    _restaurantButton = [[UILabel alloc] init];
    [_scrollView addSubview:_restaurantButton];
    [_restaurantButton setText:_event.restaurant.name];
    [_restaurantButton setFont:[UIFont fontWithName:MCT_BOLD_FONT_NAME size:14]];
    [_restaurantButton setTextColor:[UIColor whiteColor]];
    [_restaurantButton sizeToFit];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRestaurant)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    [_restaurantButton setUserInteractionEnabled:YES];
    [_restaurantButton addGestureRecognizer:tap];
    
    [_restaurantButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom);
    }];
    
    UIView *separator = [UIView new];
    [separator setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_restaurantButton).with.offset(20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(1.f);
    }];
    
    _monthLabel = [[UILabel alloc] init];
    [_scrollView addSubview:_monthLabel];
    [_monthLabel setText:[[MCTUtils getMonthStringForDate:_event.date] substringToIndex:3].uppercaseString];
    [_monthLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [_monthLabel setTextColor:[UIColor whiteColor]];
    [_monthLabel sizeToFit];
    
    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(separator.mas_bottom).with.offset(20);
    }];
    
    _dateLabel = [[UILabel alloc] init];
    [_scrollView addSubview:_dateLabel];
    [_dateLabel setText:[NSString stringWithFormat:@"%lu", [MCTUtils getDayForDate:_event.date]]];
    [_dateLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:35]];
    [_dateLabel setTextColor:[UIColor whiteColor]];
    [_dateLabel sizeToFit];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_monthLabel);
        make.top.equalTo(_monthLabel.mas_bottom);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    [_scrollView addSubview:_timeLabel];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    timeFormatter.dateFormat = @"h:mma";
    NSString *timeString = [timeFormatter stringFromDate:_event.date];
    [_timeLabel setText:timeString];
    [_timeLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    [_timeLabel sizeToFit];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_monthLabel);
        make.top.equalTo(_dateLabel.mas_bottom);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_timeLabel).with.offset(20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(1.f);
    }];
    
//    _guestsContainerView = [[UIView alloc] init];
//    [self.view addSubview:_guestsContainerView];
//    [_guestsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.left.equalTo(self.view);
//        make.top.equalTo(separator.mas_bottom).width.offset(20);
//        make.height.mas_equalTo(55);
//    }];
//
//    UILabel *guestDetailLabel = [[UILabel alloc] init];
//    [_guestsContainerView addSubview:guestDetailLabel];
//    [guestDetailLabel setText:@"Attending"];
//    [guestDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
//    [guestDetailLabel setTextColor:[UIColor lightGrayColor]];
//    [guestDetailLabel sizeToFit];
//    
//    [guestDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_equalTo(LEFT_MARGIN);
//    }];
    
    _guestsLabel = [[UILabel alloc] init];
    [_scrollView addSubview:_guestsLabel];
    [_guestsLabel setText:[NSString stringWithFormat:@"%lu of %ld people are going.", (unsigned long)_event.guests.count, (long)_event.capacity]];
    [_guestsLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:16]];
    [_guestsLabel setTextColor:[UIColor whiteColor]];
    [_guestsLabel sizeToFit];
    
    [_guestsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(separator).with.offset(20);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_guestsLabel).with.offset(20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(1.f);
    }];
    
//    UILabel *descriptionDetailLabel = [[UILabel alloc] init];
//    [_scrollView addSubview:descriptionDetailLabel];
//    [descriptionDetailLabel setText:@"Description"];
//    [descriptionDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
//    [descriptionDetailLabel setTextColor:[UIColor lightGrayColor]];
//    [descriptionDetailLabel sizeToFit];
//    
//    [descriptionDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(separator).with.offset(20);
//    }];
//    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.numberOfLines = 0;
    [_scrollView addSubview:_descriptionLabel];
    [_descriptionLabel setText:_event.details];
    [_descriptionLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [_descriptionLabel setTextColor:[UIColor whiteColor]];
    [_descriptionLabel setNumberOfLines:0];
    [_descriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [_descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(separator).with.offset(20);
        make.width.mas_equalTo(250);
    }];
    
    _joinButton = [[UIButton alloc] init];
    [_joinButton setFont:[UIFont fontWithName:MCT_BOLD_FONT_NAME size:14]];
    [_joinButton.layer setCornerRadius:5];
    [_joinButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    _joinButton.layer.borderWidth = 1;
    [self.view addSubview:_joinButton];
    [self updateJoinButton];
    [_joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_descriptionLabel.mas_bottom).with.offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    if ([_event.admin isEqual:_contentManager.user]) {
        [_joinButton setHidden:YES];
    }
}

-(void) updateJoinButton {
    if(_event.isGoing == YES) {
        [_joinButton setBackgroundColor:[UIColor whiteColor]];
        [_joinButton setTitleColor:[MCTUtils MCTRestaurantBackground] forState:UIControlStateNormal];
        [_joinButton setTitle:@"Unjoin" forState:UIControlStateNormal];
        [_joinButton addTarget:self action:@selector(unjoinEvent) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [_joinButton setBackgroundColor:[UIColor clearColor]];
        [_joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_joinButton setTitle:@"Join" forState:UIControlStateNormal];
        [_joinButton addTarget:self action:@selector(joinEvent) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) updateAttendanceLabel {
    [_guestsLabel setText:[NSString stringWithFormat:@"%lu of %ld spots are filled", (unsigned long)_event.guests.count, (long)_event.capacity]];
}

-(void) joinEvent {
    [_event setIsGoing:YES];
    if (![_event.guests containsObject:_contentManager.user] && _event.guests.count < _event.capacity) {
        [_event.guests addObject:_contentManager.user];
        [_contentManager attendEvent:_event];
    }
    [self updateJoinButton];
    [self updateAttendanceLabel];
}

-(void) unjoinEvent {
    [_event setIsGoing:NO];
    if ([_event.guests containsObject:_contentManager.user]) {
        [_event.guests removeObject:_contentManager.user];
        [_contentManager unattendEvent:_event];
    }
    [self updateJoinButton];
    [self updateAttendanceLabel];
}

-(void) tapRestaurant {
    MCTRestaurantDetailViewController *vc = [[MCTRestaurantDetailViewController alloc] init];
    vc.restaurant = _event.restaurant;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
