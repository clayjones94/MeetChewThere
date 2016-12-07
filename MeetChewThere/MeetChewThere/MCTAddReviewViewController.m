//
//  MCTAddReviewViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 12/7/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTAddReviewViewController.h"
#import "MCTUtils.h"
#import <STPopup/STPopup.h>
#import "Masonry.h"
#import "MCTConstants.h"
#import "MCTContentManager.h"

@implementation MCTAddReviewViewController {
    UITextView *_textView;
    
    NSMutableArray<UIImageView *> *_starsImageViews;
    CGFloat _starCount;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"Add Review";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
        self.contentSizeInPopup = CGSizeMake(280, 200);
        self.landscapeContentSizeInPopup = CGSizeMake(400, 200);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutViews];
    _starCount = 1;
    [self setStars];
}

-(void) layoutViews {
    
    _starsImageViews = [NSMutableArray<UIImageView *> new];
    for (int i = 0; i < 5; i ++) {
        UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_star"]];
        [self.view addSubview:star];
        [star setContentMode:UIViewContentModeScaleToFill];
        [star setClipsToBounds:YES];
        [_starsImageViews addObject:star];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStar:)];
        tap.numberOfTapsRequired = 1;
        UIView *tapView = [UIView new];
        [self.view addSubview:tapView];
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(star);
            make.width.height.mas_equalTo(40);
        }];
        tapView.tag = i;
        [tapView addGestureRecognizer:tap];
    }
    
//    [[_starsImageViews objectAtIndex:0] sizeToFit];
    [[_starsImageViews objectAtIndex:0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(10);
        make.centerX.equalTo(self.view.mas_left).with.offset(self.view.frame.size.width * 1/6);
        make.width.height.mas_equalTo(25);
    }];
    
    for (int i = 1; i < 5; i++) {
        UIImageView *lastStar = [_starsImageViews objectAtIndex:i-1];
//        [_starsImageViews[i] sizeToFit];
        [_starsImageViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lastStar);
            make.centerX.equalTo(lastStar).with.offset(self.view.frame.size.width * 1/6);
            make.width.height.mas_equalTo(25);
        }];
    }
    
    _textView = [UITextView new];
    [_textView setDelegate:self];
    [_textView setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]];
    [self.view addSubview:_textView];
    [_textView becomeFirstResponder];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).with.offset(20);
        make.top.equalTo([_starsImageViews objectAtIndex:0].mas_bottom).with.offset(10);
    }];
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
    }
}

-(void) done{
    [_textView resignFirstResponder];
    MCTRestaurantReview *review = [MCTRestaurantReview new];
    review.user = [MCTContentManager sharedManager].user;
    review.restaurant = _restaurant;
    review.dietTags = @[_dietTag];
    review.rating = _starCount;
    review.reviewString = _textView.text;
    [[MCTContentManager sharedManager] addNewReview:review];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) tapStar: (UITapGestureRecognizer *)tap {
    _starCount = tap.view.tag + 1;
    [self setStars];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}

@end
