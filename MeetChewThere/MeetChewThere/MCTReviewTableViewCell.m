//
//  MCTReviewTableViewCell.m
//  MeetChewThere
//
//  Created by Clay Jones on 12/7/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTReviewTableViewCell.h"
#import "Masonry.h"
#import "MCTUtils.h"
#import "MCTConstants.h"

@implementation MCTReviewTableViewCell {
    UILabel *_nameLabel;
    UILabel *_descriptionLabel;
    UIImageView *_userImageView;
    NSMutableArray<UIImageView *> *_starsImageViews;
    CGFloat _starCount;
}

@synthesize review = _review;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _starsImageViews = [NSMutableArray new];
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont fontWithName:MCT_BOLD_FONT_NAME size:18];
        _nameLabel.textColor = [UIColor blackColor];
        [self addSubview:_nameLabel];
        
        _descriptionLabel = [UILabel new];
        _descriptionLabel.font = [UIFont fontWithName:MCT_REGULAR_FONT_NAME size:14];
        _descriptionLabel.textColor = [UIColor blackColor];
        [_descriptionLabel setNumberOfLines:0];
        [_descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:_descriptionLabel];
        
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
    [super layoutSubviews];
    
    [_nameLabel sizeToFit];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self).with.offset(5);
    }];
    
    [_descriptionLabel sizeToFit];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.width.mas_equalTo(self.frame.size.width * .8);
        make.top.equalTo([_starsImageViews objectAtIndex:0].mas_bottom).with.offset(5);
    }];
    
    [[_starsImageViews objectAtIndex:0] sizeToFit];
    [[_starsImageViews objectAtIndex:0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom);
        make.left.equalTo(_nameLabel);
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

-(void)setReview:(MCTRestaurantReview *)review {
    _review = review;
    [_nameLabel setText:review.user.name];
    _starCount = review.rating;
    [_descriptionLabel setText:_review.reviewString];
    [self setStars];
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
