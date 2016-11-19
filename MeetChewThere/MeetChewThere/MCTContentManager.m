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
    restaurant.phone = @"650-123-4567";
    restaurant.location = [[CLLocation alloc] initWithLatitude:37.447606 longitude:-122.159583];
    restaurant.details = @"Great burger joint!";
    restaurant.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2]];
    restaurant.price = 3;
    [_restaurants addObject:restaurant];
    MCTRestaurant *restaurant1 = [[MCTRestaurant alloc] init];
    restaurant1.objectID = 1;
    restaurant1.name = @"Chilli's Restaurant";
    restaurant1.urlString = @"chillisrestaurant.com";
    restaurant1.imageName = @"chillis_prof";
    restaurant1.phone = @"650-888-1234";
    restaurant1.location = [[CLLocation alloc] initWithLatitude:37.457606 longitude:-122.169583];
    restaurant1.details = @"Best place to get Sandwiches!";
    restaurant1.dietTags = @[_dietTags[2], _dietTags[3], _dietTags[2]];
    restaurant1.price = 1;
    [_restaurants addObject:restaurant1];
    MCTRestaurant *restaurant2 = [[MCTRestaurant alloc] init];
    restaurant2.objectID = 2;
    restaurant2.name = @"Don's Pizza";
    restaurant2.urlString = @"donspizza.com";
    restaurant2.imageName = @"dons_prof";
    restaurant2.phone = @"650-789-1234";
    restaurant2.location = [[CLLocation alloc] initWithLatitude:37.452606 longitude:-122.169183];
    restaurant2.details = @"Must visit for pizza lovers!";
    restaurant2.dietTags = @[_dietTags[0], _dietTags[1]];
    restaurant2.price = 2;
    [_restaurants addObject:restaurant2];
    MCTRestaurant *restaurant3 = [[MCTRestaurant alloc] init];
    restaurant3.objectID = 2;
    restaurant3.name = @"Wang's Chinese Kitchen";
    restaurant3.urlString = @"wangschinesekitchen.com";
    restaurant3.imageName = @"wangs_prof";
    restaurant3.phone = @"650-333-2222";
    restaurant3.location = [[CLLocation alloc] initWithLatitude:37.451606 longitude:-122.163183];
    restaurant3.details = @"Traditional chinese!";
    restaurant3.dietTags = @[_dietTags[1]];
    restaurant3.price = 1;
    [_restaurants addObject:restaurant3];
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

- (NSArray *) getAllRestaurantsByRating {
    //Yet to implement
    return _restaurants;
}

- (NSArray *) getAllRestaurantsByDistance {
    NSMutableArray<MCTRestaurant *> *_restaurants1 = [[NSMutableArray<MCTRestaurant *> alloc] init];
    NSMutableArray<NSString *> *distances = [[NSMutableArray<NSString *> alloc] init];
    for (int i = 0; i < _restaurants.count; i++) {
        CLLocationDistance distance = [_restaurants[i].location distanceFromLocation: _locationManager.location];
        [distances addObject:[NSString stringWithFormat:@"%.1f", distance/1607.0]];
    }
    [distances sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for (int i = 0; i < distances.count; i++) {
        for (int j = 0; j < _restaurants.count; j++) {
            CLLocationDistance distance = [_restaurants[j].location distanceFromLocation: _locationManager.location];
            if ([distances[i] isEqualToString:[NSString stringWithFormat:@"%.1f", distance/1607.0]]) {
                [_restaurants1 addObject:_restaurants[j]];
            }
        }
    }
    return _restaurants1;
}

- (NSArray *) getAllRestaurantsByPrice {
    NSMutableArray<MCTRestaurant *> *_restaurants1 = [[NSMutableArray<MCTRestaurant *> alloc] init];
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < _restaurants.count; j++) {
            if (i+1 == _restaurants[j].price) {
                [_restaurants1 addObject:_restaurants[j]];
            }
        }
    }
    return _restaurants1;
}

- (NSArray *) getAllRestaurantsByName {
    NSMutableArray<MCTRestaurant *> *_restaurants1 = [[NSMutableArray<MCTRestaurant *> alloc] init];
    NSMutableArray<NSString *> *names = [[NSMutableArray<NSString *> alloc] init];
    for (int i = 0; i < _restaurants.count; i++) {
        [names addObject:_restaurants[i].name];
    }
    [names sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for (int i = 0; i < names.count; i++) {
        for (int j = 0; j < _restaurants.count; j++) {
            if ([names[i] isEqualToString:_restaurants[j].name]) {
                [_restaurants1 addObject:_restaurants[j]];
            }
        }
    }
    return _restaurants1;
}

#pragma Location Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

}

@end
