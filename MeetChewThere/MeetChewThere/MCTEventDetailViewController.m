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
}

@synthesize event = _event;

- (void)setEvent:(MCTEvent *)event {
    _event = event;
}

-(void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    [_monthLabel setText:@"OCTOBER"];
    [_monthLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:12]];
    [_monthLabel setTextColor:[MCTUtils defaultBarColor]];
    [_monthLabel sizeToFit];
    
    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LEFT_MARGIN);
        make.top.mas_equalTo(10);
    }];
    
    _dateLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:_dateLabel];
    [_dateLabel setText:@"30"];
    [_dateLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:35]];
    [_dateLabel setTextColor:[UIColor blackColor]];
    [_dateLabel sizeToFit];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_monthLabel);
        make.top.equalTo(_monthLabel.mas_bottom);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:_timeLabel];
    [_timeLabel setText:@"7:30pm"];
    [_timeLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:12]];
    [_timeLabel setTextColor:[MCTUtils defaultBarColor]];
    [_timeLabel sizeToFit];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_monthLabel);
        make.top.equalTo(_dateLabel.mas_bottom);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    [_introContainerView addSubview:_nameLabel];
    [_nameLabel setText:_event.name];
    [_nameLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:22]];
    [_nameLabel setTextColor:[UIColor blackColor]];
    [_nameLabel sizeToFit];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_monthLabel.frame.origin.x + _monthLabel.frame.size.width + 30);
        make.top.equalTo(_monthLabel);
    }];
    
    _restaurantButton = [[UILabel alloc] init];
    [_introContainerView addSubview:_restaurantButton];
    [_restaurantButton setText:_event.restaurant.name];
    [_restaurantButton setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:14]];
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
    [guestDetailLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:12]];
    [guestDetailLabel setTextColor:[UIColor lightGrayColor]];
    [guestDetailLabel sizeToFit];
    
    [guestDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(LEFT_MARGIN);
    }];
    
    _guestsLabel = [[UILabel alloc] init];
    [_guestsContainerView addSubview:_guestsLabel];
    [_guestsLabel setText:[NSString stringWithFormat:@"%lu of %ld spots are filled", (unsigned long)_event.guests.count, (long)_event.capacity]];
    [_guestsLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:16]];
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
    [descriptionDetailLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:12]];
    [descriptionDetailLabel setTextColor:[UIColor lightGrayColor]];
    [descriptionDetailLabel sizeToFit];
    
    [descriptionDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(LEFT_MARGIN);
    }];
    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.numberOfLines = 0;
    [_descriptionContainerView addSubview:_descriptionLabel];
    [_descriptionLabel setText:_event.details];
    [_descriptionLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:12]];
    [_descriptionLabel setTextColor:[UIColor blackColor]];
    [_descriptionLabel sizeToFit];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(descriptionDetailLabel);
        make.top.equalTo(descriptionDetailLabel.mas_bottom);
    }];
}

@end
