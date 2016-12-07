//
//  MCTEventTableViewCell.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTEventTableViewCell.h"
#import "Masonry.h"
#import "MCTUtils.h"
#import "MCTConstants.h"

@implementation MCTEventTableViewCell {
    UILabel *_nameLabel;
    UILabel *_restaurantButton;
    UILabel *_dietTagsLabel;
    UILabel *_guestsLabel;
    UILabel *_dateLabel;
    UIImageView *_imageView;
    UIView *_separator;
}

@synthesize event = _event;

-(void)setEvent:(MCTEvent *)event {
    _event = event;
    [self layoutSubviews];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:15];
        [_nameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        
        _restaurantButton = [UILabel new];
        _restaurantButton.textColor = [MCTUtils defaultBarColor];
        _restaurantButton.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        
        _dietTagsLabel = [UILabel new];
        _dietTagsLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        _dietTagsLabel.textColor = [UIColor grayColor];
        [_dietTagsLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        
        _guestsLabel = [UILabel new];
        _guestsLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        _guestsLabel.textColor = [UIColor blackColor];
        
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        _dateLabel.textColor = [UIColor blackColor];
        
        _imageView = [UIImageView new];
        _imageView.layer.cornerRadius = 3;
        [_imageView setBackgroundColor:[MCTUtils MCTLightGrayColor]];
        
        _separator = [[UIView alloc] init];
        [_separator setBackgroundColor:[MCTUtils MCTSearchSeperatorColor]];
        
        [self addSubview:_nameLabel];
        [self addSubview:_restaurantButton];
        [self addSubview:_dietTagsLabel];
        [self addSubview:_guestsLabel];
        [self addSubview:_imageView];
        [self addSubview:_dateLabel];
        [self addSubview:_separator];
    }
    
    return self;
}

-(void)layoutSubviews {
    CGFloat LEFT = 20;
    CGFloat TOP = 10;
    CGFloat RIGHT = 20;
    CGFloat BOTTOM = 10;
    
    if (_event) {
        [_nameLabel setText:_event.name];
        [_restaurantButton setText:[NSString stringWithFormat:@"%@ - %@", _event.restaurant.name, [MCTUtils priceStringForRestaurant:_event.restaurant]]];
        [_dietTagsLabel setText:_event.dietTags.firstObject.name];
        [_guestsLabel setText:[NSString stringWithFormat:@"%lu guests", (unsigned long)_event.guests.count]];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init] ;
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"h:mma";
        NSString *timeString = [timeFormatter stringFromDate:_event.date];
        _dateLabel.text = [NSString stringWithFormat:@"%@ - %@ %ld", timeString, [[MCTUtils getMonthStringForDate:_event.date] substringToIndex:3], (long)[MCTUtils getDayForDate:_event.date]];
        [_imageView setImage:[UIImage imageNamed:_event.restaurant.imageName]];
    }
    
    [_nameLabel sizeToFit];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP);
        make.left.mas_equalTo(LEFT);
        make.right.equalTo(_imageView.mas_left).with.offset(-10);
    }];
    
    [_restaurantButton sizeToFit];
    [_restaurantButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(_nameLabel);
    }];
    
    [_dietTagsLabel sizeToFit];
    [_dietTagsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_restaurantButton.mas_bottom).with.offset(5);
        make.left.equalTo(_nameLabel);
    }];
    
    [_dateLabel sizeToFit];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel);
        make.right.mas_equalTo(-RIGHT);
    }];
    
    [_imageView sizeToFit];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateLabel.mas_bottom);
        make.right.equalTo(_dateLabel.mas_right);
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
