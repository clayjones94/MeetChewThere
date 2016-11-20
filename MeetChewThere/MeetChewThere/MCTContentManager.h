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
- (NSArray *) getAllUsers;
- (NSArray *) getAllReviews;
- (NSArray *) getAllDietTags;
- (NSArray *) getAllEvents;
- (NSArray *) getAllRestaurants;
- (NSArray *) getAllRestaurantsByRating;
- (NSArray *) getAllRestaurantsByDistance;
- (NSArray *) getAllRestaurantsByName;
- (NSArray *) getAllRestaurantsByPrice;
-(NSArray *) getEventsForRestaurant: (MCTRestaurant *) restaurant;
- (NSArray *) getReviewsForRestaurant: (MCTRestaurant *) restaurant WithTag: (MCTDietTag *) dietTag;
- (NSArray *) getAllEventsByAnytime1;
- (NSArray *) getAllEventsByToday;
- (NSArray *) getAllEventsByThisWeek;
- (NSArray *) getAllEventsByNextWeek;
- (NSArray *) getAllEventsByAnytime2;
- (NSArray *) getAllEventsByMorning;
- (NSArray *) getAllEventsByAfternoon;
- (NSArray *) getAllEventsByEvening;
- (NSArray *) getAllEventsByDistance1;
- (NSArray *) getAllEventsByDistance50;
- (NSArray *) getAllEventsByDistance10;
- (NSArray *) getAllEventsByDistance25;
- (NSArray *) getAllEventsByPriceAny;
- (NSArray *) getAllEventsByPrice1;
- (NSArray *) getAllEventsByPrice2;
- (NSArray *) getAllEventsByPrice3;



@end
