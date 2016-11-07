//
//  MCTRestaurantDetailViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/5/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTRestaurantDetailViewController.h"

@implementation MCTRestaurantDetailViewController {
    UIImageView *_imageView;
    
    UIScrollView *_scrollView;
}

@synthesize restaurant = _restaurant;

-(void)viewDidLoad {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.view = _scrollView;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBarHidden = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self layoutViews];
}

-(void) layoutViews {
    
}

-(void)setRestaurant:(MCTRestaurant *)restaurant {
    _restaurant = restaurant;
}

@end
