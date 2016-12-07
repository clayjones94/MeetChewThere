//
//  MCTAddReviewViewController.h
//  MeetChewThere
//
//  Created by Clay Jones on 12/7/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTDietTag.h"
#import "MCTRestaurant.h"

@interface MCTAddReviewViewController : UIViewController<UITextViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) MCTDietTag *dietTag;
@property (weak, nonatomic) MCTRestaurant *restaurant;

@end
