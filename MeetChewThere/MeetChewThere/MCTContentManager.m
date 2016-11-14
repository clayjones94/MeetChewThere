//
//  MCTContentManager.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTContentManager.h"

@implementation MCTContentManager {
    NSMutableArray<MCTDietTag *> *_dietTags;
    NSMutableArray<MCTUser *> *_users;
    NSMutableArray<MCTRestaurantReview *> *_reviews;
    NSMutableArray<MCTEvent *> *_events;
    NSMutableArray<MCTRestaurant *> *_restaurants;
}

@synthesize locationManager = _locationManager;
@synthesize user = _user;

+ (MCTContentManager *)sharedManager {
    static MCTContentManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if (self == [super init]) {
        [self getLocation];
        [self initDietTags];
        [self initUsers];
        [self initRestaurants];
        [self initEvents];
    }
    return self;
}

-(void) getLocation {
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
}

-(void) initDietTags {
    NSArray *tags = @[@"Gluten Free", @"Dairy Free", @"Vegetarian", @"Vegan", @"Nut Allergy"];
    _dietTags = [[NSMutableArray<MCTDietTag *> alloc] init];
    for (int i = 0; i < tags.count; i ++) {
        MCTDietTag *tag = [[MCTDietTag alloc] init];
        tag.objectID = i;
        tag.name = tags[i];
        [_dietTags addObject:tag];
    }
}

-(void) initUsers {
    _users = [[NSMutableArray<MCTUser *> alloc] init];
    MCTUser *user = [[MCTUser alloc] init];
    user.objectID = 0;
    user.name = @"Clay Jones";
    user.imageName = @"clay_prof";
    user.dietTags = @[_dietTags[0], _dietTags[1]];
    [_users addObject:user];
}

-(void) initRestaurants {
    _restaurants = [[NSMutableArray<MCTRestaurant *> alloc] init];
    MCTRestaurant *restaurant = [[MCTRestaurant alloc] init];
    restaurant.objectID = 0;
    restaurant.name = @"Umami Burger";
    restaurant.urlString = @"umamiburger.com";
    restaurant.imageName = @"umami_prof";
    restaurant.phone = @"888-888-8888";
    restaurant.location = [[CLLocation alloc] initWithLatitude:37.447606 longitude:-122.159583];
    restaurant.details = @"Great burger joint!";
    restaurant.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2]];
    restaurant.price = 3;
    [_restaurants addObject:restaurant];
}

-(void) initEvents {
    _events = [[NSMutableArray<MCTEvent *> alloc] init];
    MCTEvent *event = [[MCTEvent alloc] init];
    event.objectID = 0;
    event.name = @"Burger Party";
    event.details = @"Fun party!";
    event.date = [NSDate date];
    event.admin = _users[0];
    event.isGoing = NO;
    event.capacity = 10;
    event.restaurant = _restaurants[0];
    event.dietTags = @[_dietTags[0], _dietTags[1]];
    event.guests = [[NSMutableArray alloc] initWithArray: @[_users[0]]];
    [_events addObject:event];
}

-(void) initReviews {
    _reviews = [[NSMutableArray<MCTRestaurantReview *> alloc] init];
    MCTRestaurantReview *review = [[MCTRestaurantReview alloc] init];
    review.objectID = 0;
    review.user = _users[0];
    review.reviewString = @"Great restaurant!";
    review.date = [NSDate date];
    review.restaurant = _restaurants[0];
    review.dietTags = @[_dietTags[0], _dietTags[1]];
    review.rating = 5;
    [_reviews addObject:review];
}

- (NSArray *) getAllUsers {
    return _users;
}

- (NSArray *) getAllReviews {
    return _reviews;
}

- (NSArray *) getReviewsForRestaurant: (MCTRestaurant *) restaurant WithTag: (MCTDietTag *) dietTag {
    NSMutableArray *revs = [NSMutableArray new];
    for (int i = 0; i < _reviews.count; i ++) {
        MCTRestaurantReview *review = _reviews[i];
        if (![review.restaurant isEqual:restaurant]) continue;
        if (!dietTag) {
            [revs addObject:review];
        } else {
            if ([dietTag isEqual:dietTag]) {
                [revs addObject:review];
            }
        }
    }
    return revs;
}

-(NSArray *) getEventsForRestaurant: (MCTRestaurant *) restaurant  {
    NSMutableArray *revs = [NSMutableArray new];
    for (int i = 0; i < _events.count; i ++) {
        MCTEvent *review = _events[i];
        if ([review.restaurant isEqual:restaurant]){
            [revs addObject:review];
        }
    }
    return revs;
}

- (NSArray *) getAllDietTags {
    return _dietTags;
}

- (NSArray *) getAllEvents {
    return _events;
}

- (NSArray *) getAllRestaurants {
    return _restaurants;
}

#pragma Location Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

}

@end
