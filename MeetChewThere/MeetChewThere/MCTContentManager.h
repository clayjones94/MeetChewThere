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
- (NSArray *) searchDietTagsBySearchText: (NSString *) text;
- (NSArray *) getAllEvents;
- (NSArray *) getAllRestaurants;
- (NSArray *) getAllRestaurantsByRating;
- (NSArray *) getAllRestaurantsByDistance;
- (NSArray *) getAllRestaurantsByName;
- (NSArray *) getAllRestaurantsByPrice;
-(NSArray *) getEventsForRestaurant: (MCTRestaurant *) restaurant;
- (NSArray *) getReviewsForRestaurant: (MCTRestaurant *) restaurant WithTag: (MCTDietTag *) dietTag;
-(void) attendEvent: (MCTEvent *)event;
-(void) unattendEvent: (MCTEvent *)event;
-(NSArray *) getUserUpcomingEvents;
-(NSArray *)getUserPastEvents;
-(NSArray *)getUserHostingEvents;


- (void) searchRestaurantsBySearchText: (NSString *) text;
-(NSArray *) getEventsForPrice: (NSNumber *) price beforeDate: (NSString *) dateString withinDistanceMiles: (NSNumber *) miles forTimeOfDay: (NSString *) timeOfDayString;

@end
