//
//  MCTDietRatingsTableViewCell.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/11/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTDietRatingsTableViewCell.h"
#import "Masonry.h"
#import "MCTConstants.h"

@implementation MCTDietRatingsTableViewCell {
    UILabel *_dietTagLabel;
    NSMutableArray<UIImageView *> *_starsImageViews;
    CGFloat _starCount;
}

@synthesize dietTag = _dietTag;
@synthesize restaurant = _restaurant;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _starsImageViews = [NSMutableArray new];
        _dietTagLabel = [UILabel new];
        _dietTagLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12];
        _dietTagLabel.textColor = [UIColor whiteColor];
        [self addSubview:_dietTagLabel];
        
        for (int i = 0; i < 5; i ++) {
            UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_star"]];
            [self addSubview:star];
            [_starsImageViews addObject:star];
        }
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)layoutSubviews {
    [_dietTagLabel sizeToFit];
    [_dietTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(5);
    }];
    
    [[_starsImageViews objectAtIndex:0] sizeToFit];
    [[_starsImageViews objectAtIndex:0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dietTagLabel.mas_bottom);
        make.left.equalTo(self.mas_centerX).with.offset(-[_starsImageViews objectAtIndex:0].frame.size.width * 3);
    }];
 
    
    for (int i = 1; i < 5; i++) {
        UIImageView *lastStar = [_starsImageViews objectAtIndex:i-1];
        [_starsImageViews[i] sizeToFit];
        [_starsImageViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lastStar);
            make.left.equalTo(lastStar.mas_right).with.offset(5);
        }];
    }
}

-(void)setDietTag:(MCTDietTag *)dietTag {
    _dietTag = dietTag;
    [_dietTagLabel setText:_dietTag.name];
    _starCount = 3.6;
    [self setStars];
}

-(void)setRestaurant:(MCTRestaurant *)restaurant {
    _restaurant = restaurant;
}

-(void) setStars {
    for (int i = 0; i < 5; i++) {
        UIImageView *star = [_starsImageViews objectAtIndex:i];
        if (i <= _starCount - 1) {
            [star setImage:[UIImage imageNamed:@"full_star"]];
        } else if(i >= _starCount){
            [star setImage:[UIImage imageNamed:@"empty_star"]];
        } else if(_starCount - (int)_starCount > .25 && _starCount - (int)_starCount < .75) {
            [star setImage:[UIImage imageNamed:@"half_star"]];
        }
        [star sizeToFit];
    }
}

@end
