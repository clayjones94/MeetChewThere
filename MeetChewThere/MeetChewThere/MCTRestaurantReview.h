//
//  MCTRestaurantReview.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCTRestaurant.h"
#import "MCTUser.h"

@interface MCTRestaurantReview : NSObject

@property (nonatomic) NSInteger objectID;
@property (strong, nonatomic) MCTUser *user;
@property (strong, nonatomic) NSString *reviewString;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) NSInteger rating;
@property (strong, nonatomic) MCTRestaurant *restaurant;
@property (strong, nonatomic) NSArray<MCTDietTag *> *dietTags;

@end
