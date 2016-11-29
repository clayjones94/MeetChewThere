//
//  MCTRestaurantTableViewCell.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/5/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTRestaurantTableViewCell.h"
#import "Masonry.h"
#import "MCTUtils.h"
#import "MCTContentManager.h"
#import "MCTConstants.h"

@implementation MCTRestaurantTableViewCell {
    UILabel *_nameLabel;
    UILabel *_ratingsButton;
    UILabel *_dietTagsLabel;
    UILabel *_eventsLabel;
    UILabel *_distanceLabel;
    UIImageView *_imageView;
    UIView *_separator;
    MCTContentManager *_contentManager;
}

@synthesize restaurant = _restaurant;

-(void)setRestaurant:(MCTRestaurant *)restaurant {
    _restaurant = restaurant;
    [self layoutSubviews];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _contentManager = [MCTContentManager sharedManager];
    
    if (self) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:15];
        
        _ratingsButton = [UILabel new];
        _ratingsButton.textColor = [MCTUtils defaultBarColor];
        _ratingsButton.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        
        _dietTagsLabel = [UILabel new];
        _dietTagsLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        _dietTagsLabel.textColor = [UIColor grayColor];
        
        _eventsLabel = [UILabel new];
        _eventsLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        _eventsLabel.textColor = [UIColor blackColor];
        
        _distanceLabel = [UILabel new];
        _distanceLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        _distanceLabel.textColor = [UIColor blackColor];
        
        _imageView = [UIImageView new];
        _imageView.layer.cornerRadius = 3;
        [_imageView setBackgroundColor:[UIColor grayColor]];
        
        _separator = [[UIView alloc] init];
        [_separator setBackgroundColor:[UIColor lightGrayColor]];
        
        [self addSubview:_nameLabel];
        [self addSubview:_ratingsButton];
        [self addSubview:_dietTagsLabel];
        [self addSubview:_eventsLabel];
        [self addSubview:_imageView];
        [self addSubview:_distanceLabel];
        [self addSubview:_separator];
    }
    
    return self;
}

-(void)layoutSubviews {
    CGFloat LEFT = 20;
    CGFloat TOP = 10;
    CGFloat RIGHT = 20;
    CGFloat BOTTOM = 10;
    
    if (_restaurant) {
        [_nameLabel setText:_restaurant.name];
        [_ratingsButton setText:[NSString stringWithFormat:@"%@", [MCTUtils priceStringForRestaurant:_restaurant]]];
        [_dietTagsLabel setText: [MCTUtils dietTagsListtoString: _restaurant.dietTags]];
//        [_dietTagsLabel setText:_restaurant.dietTags.firstObject.name];
        [_eventsLabel setText:[NSString stringWithFormat:@"%lu events", (unsigned long)[_contentManager getEventsForRestaurant:_restaurant].count]];
        CLLocationDistance distance = [_restaurant.location distanceFromLocation: [_contentManager locationManager].location];
        _distanceLabel.text = [NSString stringWithFormat:@"%.1f mi", distance/1607.0];
        [_imageView setImage:[UIImage imageNamed:_restaurant.imageName]];
    }
    
    [_nameLabel sizeToFit];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP);
        make.left.mas_equalTo(LEFT);
    }];
    
    [_ratingsButton sizeToFit];
    [_ratingsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(_nameLabel);
    }];
    
    [_dietTagsLabel sizeToFit];
    [_dietTagsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ratingsButton.mas_bottom).with.offset(5);
        make.left.equalTo(_nameLabel);
    }];
    
    [_distanceLabel sizeToFit];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel);
        make.right.mas_equalTo(-RIGHT);
    }];
    
    [_imageView sizeToFit];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_distanceLabel.mas_bottom);
        make.right.equalTo(_distanceLabel.mas_right);
        make.bottom.mas_equalTo(-BOTTOM);
        make.width.mas_equalTo(self.frame.size.width * .25);
    }];
    
    [_separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.left.mas_equalTo(LEFT);
        make.height.mas_equalTo(1.f);
    }];
}



@end
