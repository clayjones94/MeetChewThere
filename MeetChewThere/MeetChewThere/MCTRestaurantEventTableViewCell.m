//
//  MCTRestaurantEventTableViewCell.m
//  MeetChewThere
//
//  Created by Clay Jones on 12/6/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTRestaurantEventTableViewCell.h"
#import "Masonry.h"
#import "MCTUtils.h"
#import "MCTConstants.h"

@implementation MCTRestaurantEventTableViewCell {
    UILabel *_nameLabel;
    UILabel *_dietTagsLabel;
    UILabel *_dateLabel;
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
        _nameLabel.textColor = [UIColor whiteColor];
        [_nameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        
        _dietTagsLabel = [UILabel new];
        _dietTagsLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        _dietTagsLabel.textColor = [MCTUtils MCTLightGrayColor];
        [_dietTagsLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        _dateLabel.textColor = [UIColor whiteColor];
        
        _separator = [[UIView alloc] init];
        [_separator setBackgroundColor:[MCTUtils MCTLightGrayColor]];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:_nameLabel];
        [self addSubview:_dietTagsLabel];
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
        [_dietTagsLabel setText:_event.dietTags.firstObject.name];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init] ;
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"h:mma";
        NSString *timeString = [timeFormatter stringFromDate:_event.date];
        _dateLabel.text = [NSString stringWithFormat:@"%@ - %@ %ld", timeString, [[MCTUtils getMonthStringForDate:_event.date] substringToIndex:3], (long)[MCTUtils getDayForDate:_event.date]];
    }
    
    [_dietTagsLabel sizeToFit];
    [_dietTagsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateLabel.mas_bottom).with.offset(3);
        make.centerX.equalTo(_nameLabel);
    }];
    
    [_nameLabel sizeToFit];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP).with.offset(3);
        make.centerX.equalTo(self);
    }];
    
    [_dateLabel sizeToFit];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(3);
        make.centerX.equalTo(self);
    }];
    
    
    [_separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(1.f);
    }];
}
@end
