//
//  MCTContentManager.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCTDietTag.h"
#import "MCTUser.h"
#import "MCTRestaurant.h"
#import "MCTEvent.h"
#import "MCTRestaurantReview.h"

@interface MCTContentManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MCTUser *user;

+ (MCTContentManager *)sharedManager;
-(void) addNewEvent: (MCTEvent *)event;
- (NSArray *) getAllUsers;
- (NSArray *) getAllReviews;
- (NSArray *) getAllDietTags;
- (NSArray *) getAllEvents;
- (NSArray *) getAllRestaurants;
-(NSArray *) getEventsForRestaurant: (MCTRestaurant *) restaurant;
- (NSArray *) getReviewsForRestaurant: (MCTRestaurant *) restaurant WithTag: (MCTDietTag *) dietTag;

@end
