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
    
    MCTContentManager *_contentManager;
}

@synthesize event = _event;

- (void)setEvent:(MCTEvent *)event {
    _event = event;
}

-(void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _contentManager = [MCTContentManager sharedManager];
    [self layoutViews];
}

-(void) layoutViews {
    CGFloat LEFT_MARGIN = 10;
    
    _imageView = [[UIImageView alloc] init];
    [self.view addSubview:_imageView];
    [_imageView setImage:[UIImage imageNamed:_event.restaurant.imageName]];
    [_imageView setBackgroundColor:[UIColor redColor]];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(90);
    }];
    
    _introContainerView = [[UIView alloc] init];
    [self.view addSubview:_introContainerView];
    [_introContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(_imageView.mas_bottom);
        make.height.mas_equalTo(90);
    }];
    
    UIView *separator = [UIView new];
    [separator setBackgroundColor:[UIColor lightGrayColor]];
    [_introContainerView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_introContainerView);
        make.left.mas_equalTo(self.view);
        make.height.mas_equalTo(1.f);
    }];
    
    _monthLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:_monthLabel];
    [_monthLabel setText:[[MCTUtils getMonthStringForDate:_event.date] substringToIndex:3].uppercaseString];
    [_monthLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [_monthLabel setTextColor:[MCTUtils defaultBarColor]];
    [_monthLabel sizeToFit];
    
    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LEFT_MARGIN);
        make.top.mas_equalTo(10);
    }];
    
    _dateLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:_dateLabel];
    [_dateLabel setText:[NSString stringWithFormat:@"%lu", [MCTUtils getDayForDate:_event.date]]];
    [_dateLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:35]];
    [_dateLabel setTextColor:[UIColor blackColor]];
    [_dateLabel sizeToFit];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_monthLabel);
        make.top.equalTo(_monthLabel.mas_bottom);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:_timeLabel];
    [_timeLabel setText:@"7:30pm"];
    [_timeLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [_timeLabel setTextColor:[MCTUtils defaultBarColor]];
    [_timeLabel sizeToFit];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_monthLabel);
        make.top.equalTo(_dateLabel.mas_bottom);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:_nameLabel];
    [_nameLabel setText:_event.name];
    [_nameLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:22]];
    [_nameLabel setTextColor:[UIColor blackColor]];
    [_nameLabel sizeToFit];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_monthLabel.frame.origin.x + _monthLabel.frame.size.width + 30);
        make.top.equalTo(_monthLabel);
    }];
    
    _restaurantButton = [[UILabel alloc] init];
    [_introContainerView addSubview:_restaurantButton];
    [_restaurantButton setText:_event.restaurant.name];
    [_restaurantButton setFont:[UIFont fontWithName:MCT_BOLD_FONT_NAME size:14]];
    [_restaurantButton setTextColor:[MCTUtils defaultBarColor]];
    [_restaurantButton sizeToFit];
    
    [_restaurantButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom);
    }];
    
    _guestsContainerView = [[UIView alloc] init];
    [self.view addSubview:_guestsContainerView];
    [_guestsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(_introContainerView.mas_bottom);
        make.height.mas_equalTo(55);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[UIColor lightGrayColor]];
    [_guestsContainerView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_guestsContainerView);
        make.height.mas_equalTo(1.f);
    }];
    
    UILabel *guestDetailLabel = [[UILabel alloc] init];
    [_guestsContainerView addSubview:guestDetailLabel];
    [guestDetailLabel setText:@"Attending"];
    [guestDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [guestDetailLabel setTextColor:[UIColor lightGrayColor]];
    [guestDetailLabel sizeToFit];
    
    [guestDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(LEFT_MARGIN);
    }];
    
    _guestsLabel = [[UILabel alloc] init];
    [_guestsContainerView addSubview:_guestsLabel];
    [_guestsLabel setText:[NSString stringWithFormat:@"%lu of %ld spots are filled", (unsigned long)_event.guests.count, (long)_event.capacity]];
    [_guestsLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:16]];
    [_guestsLabel setTextColor:[UIColor blackColor]];
    [_guestsLabel sizeToFit];
    
    [_guestsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guestDetailLabel);
        make.top.equalTo(guestDetailLabel.mas_bottom);
    }];
    
    _descriptionContainerView = [[UIView alloc] init];
    [self.view addSubview:_descriptionContainerView];
    [_descriptionContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(_guestsContainerView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[UIColor lightGrayColor]];
    [_descriptionContainerView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_descriptionContainerView);
        make.height.mas_equalTo(1.f);
    }];
    
    UILabel *descriptionDetailLabel = [[UILabel alloc] init];
    [_descriptionContainerView addSubview:descriptionDetailLabel];
    [descriptionDetailLabel setText:@"Description"];
    [descriptionDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [descriptionDetailLabel setTextColor:[UIColor lightGrayColor]];
    [descriptionDetailLabel sizeToFit];
    
    [descriptionDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(LEFT_MARGIN);
    }];
    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.numberOfLines = 0;
    [_descriptionContainerView addSubview:_descriptionLabel];
    [_descriptionLabel setText:_event.details];
    [_descriptionLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [_descriptionLabel setTextColor:[UIColor blackColor]];
    [_descriptionLabel setNumberOfLines:0];
    [_descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(descriptionDetailLabel);
        make.top.equalTo(descriptionDetailLabel.mas_bottom);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
    }];
    
    _joinButton = [[UIButton alloc] init];
    [_joinButton setFont:[UIFont fontWithName:MCT_BOLD_FONT_NAME size:14]];
    [self.view addSubview:_joinButton];
    [self updateJoinButton];
    [_joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

-(void) updateJoinButton {
    if(_event.isGoing == YES) {
        [_joinButton setBackgroundColor:[UIColor redColor]];
        [_joinButton setTitle:@"Unjoin" forState:UIControlStateNormal];
        [_joinButton addTarget:self action:@selector(unjoinEvent) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [_joinButton setBackgroundColor:[MCTUtils defaultBarColor]];
        [_joinButton setTitle:@"Join" forState:UIControlStateNormal];
        [_joinButton addTarget:self action:@selector(joinEvent) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void) updateAttendanceLabel {
    [_guestsLabel setText:[NSString stringWithFormat:@"%lu of %ld spots are filled", (unsigned long)_event.guests.count, (long)_event.capacity]];
}

-(void) joinEvent {
    [_event setIsGoing:YES];
    if (![_event.guests containsObject:_contentManager.user] && _event.guests.count < _event.capacity) {
        [_event.guests addObject:_contentManager.user];
    }
    [self updateJoinButton];
    [self updateAttendanceLabel];
}

-(void) unjoinEvent {
    [_event setIsGoing:NO];
    if ([_event.guests containsObject:_contentManager.user]) {
        [_event.guests removeObject:_contentManager.user];
    }
    [self updateJoinButton];
    [self updateAttendanceLabel];
}

@end
