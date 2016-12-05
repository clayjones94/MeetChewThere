//
//  MCTContentManager.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTContentManager.h"
#import "MCTUtils.h"

@implementation MCTContentManager {
    NSMutableArray<MCTDietTag *> *_dietTags;
    NSMutableArray<MCTUser *> *_users;
    NSMutableArray<MCTRestaurantReview *> *_reviews;
    NSMutableArray<MCTEvent *> *_events;
    NSMutableArray<MCTRestaurant *> *_restaurants;
    NSMutableArray<MCTRestaurant *> *_allRestaurants;
    NSMutableArray<MCTEvent *> *_attendingEvents;
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
        _attendingEvents = [NSMutableArray new];
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
    NSArray *tags = @[@"Vegetarian", @"Vegan", @"Dairy", @"Eggs", @"Shellfish", @"Soy", @"Peanuts & Tree Nuts", @"Gluten Free"];
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
    MCTUser *user0 = [[MCTUser alloc] init];     user0.objectID = 0;	user0.name = @"Emily B.";	user0.imageName = @"user0_prof";	user0.dietTags = @[_dietTags[2], _dietTags[7]];	[_users addObject:user0];
    MCTUser *user1 = [[MCTUser alloc] init];     user1.objectID = 1;	user1.name = @"Daniel M.";	user1.imageName = @"user1_prof";	user1.dietTags = @[_dietTags[7]];	[_users addObject:user1];
    MCTUser *user2 = [[MCTUser alloc] init];     user2.objectID = 2;	user2.name = @"Doris T.";	user2.imageName = @"user2_prof";	user2.dietTags = @[_dietTags[7]];	[_users addObject:user2];
    MCTUser *user3 = [[MCTUser alloc] init];     user3.objectID = 3;	user3.name = @"Erin W.";	user3.imageName = @"user3_prof";	user3.dietTags = @[_dietTags[2], _dietTags[7]];	[_users addObject:user3];
    MCTUser *user4 = [[MCTUser alloc] init];     user4.objectID = 4;	user4.name = @"Karen O.";	user4.imageName = @"user4_prof";	user4.dietTags = @[_dietTags[6]];	[_users addObject:user4];
    MCTUser *user5 = [[MCTUser alloc] init];     user5.objectID = 5;	user5.name = @"Kate B.";	user5.imageName = @"user5_prof";	user5.dietTags = @[_dietTags[2], _dietTags[7]];	[_users addObject:user5];
    MCTUser *user6 = [[MCTUser alloc] init];     user6.objectID = 6;	user6.name = @"Kelly M.";	user6.imageName = @"user6_prof";	user6.dietTags = @[_dietTags[6], _dietTags[1]];	[_users addObject:user6];
    MCTUser *user7 = [[MCTUser alloc] init];     user7.objectID = 7;	user7.name = @"Sarah R.";	user7.imageName = @"user7_prof";	user7.dietTags = @[_dietTags[7], _dietTags[6]];	[_users addObject:user7];
    MCTUser *user8 = [[MCTUser alloc] init];     user8.objectID = 8;	user8.name = @"Ron L.";	user8.imageName = @"user8_prof";	user8.dietTags = @[_dietTags[7]];	[_users addObject:user8];
    MCTUser *user9 = [[MCTUser alloc] init];     user9.objectID = 9;	user9.name = @"Jodi H.";	user9.imageName = @"user9_prof";	user9.dietTags = @[_dietTags[7], _dietTags[6]];	[_users addObject:user9];
    MCTUser *user10 = [[MCTUser alloc] init];     user10.objectID = 10;	user10.name = @"Amy E.";	user10.imageName = @"user10_prof";	user10.dietTags = @[_dietTags[6]];	[_users addObject:user10];
    MCTUser *user11 = [[MCTUser alloc] init];     user11.objectID = 11;	user11.name = @"Hugh F.";	user11.imageName = @"user11_prof";	user11.dietTags = @[_dietTags[6]];	[_users addObject:user11];
    MCTUser *user12 = [[MCTUser alloc] init];     user12.objectID = 12;	user12.name = @"Alaina E.";	user12.imageName = @"user12_prof";	user12.dietTags = @[_dietTags[7]];	[_users addObject:user12];
    MCTUser *user13 = [[MCTUser alloc] init];     user13.objectID = 13;	user13.name = @"Lara C.";	user13.imageName = @"user13_prof";	user13.dietTags = @[_dietTags[7], _dietTags[0]];	[_users addObject:user13];
    MCTUser *user14 = [[MCTUser alloc] init];     user14.objectID = 14;	user14.name = @"Katie-Rose N";	user14.imageName = @"user14_prof";	user14.dietTags = @[_dietTags[1]];	[_users addObject:user14];
    MCTUser *user15 = [[MCTUser alloc] init];     user15.objectID = 15;	user15.name = @"Tej R.";	user15.imageName = @"user15_prof";	user15.dietTags = @[_dietTags[0]];	[_users addObject:user15];
    MCTUser *user16 = [[MCTUser alloc] init];     user16.objectID = 16;	user16.name = @"Keily S.";	user16.imageName = @"user16_prof";	user16.dietTags = @[_dietTags[0]];	[_users addObject:user16];
    MCTUser *user17 = [[MCTUser alloc] init];     user17.objectID = 17;	user17.name = @"Nishad J.";	user17.imageName = @"user17_prof";	user17.dietTags = @[_dietTags[0]];	[_users addObject:user17];
    MCTUser *user18 = [[MCTUser alloc] init];     user18.objectID = 18;	user18.name = @"Teagan T.";	user18.imageName = @"user18_prof";	user18.dietTags = @[_dietTags[1]];	[_users addObject:user18];
    MCTUser *user19 = [[MCTUser alloc] init];     user19.objectID = 19;	user19.name = @"Yugan S.";	user19.imageName = @"user19_prof";	user19.dietTags = @[_dietTags[1]];	[_users addObject:user19];
    MCTUser *user20 = [[MCTUser alloc] init];     user20.objectID = 20;	user20.name = @"Scott K.";	user20.imageName = @"user20_prof";	user20.dietTags = @[_dietTags[0]];	[_users addObject:user20];
    MCTUser *user21 = [[MCTUser alloc] init];     user21.objectID = 21;	user21.name = @"Ellen B.";	user21.imageName = @"user21_prof";	user21.dietTags = @[_dietTags[6]];	[_users addObject:user21];
    MCTUser *user22 = [[MCTUser alloc] init];     user22.objectID = 22;	user22.name = @"Rachel G.";	user22.imageName = @"user22_prof";	user22.dietTags = @[_dietTags[7], _dietTags[6]];	[_users addObject:user22];
    MCTUser *user23 = [[MCTUser alloc] init];     user23.objectID = 23;	user23.name = @"Barbara R.";	user23.imageName = @"user23_prof";	user23.dietTags = @[_dietTags[7]];	[_users addObject:user23];
    MCTUser *user24 = [[MCTUser alloc] init];     user24.objectID = 24;	user24.name = @"Ginger K.";	user24.imageName = @"user24_prof";	user24.dietTags = @[_dietTags[6]];	[_users addObject:user24];
    MCTUser *user25 = [[MCTUser alloc] init];     user25.objectID = 25;	user25.name = @"Natalie L.";	user25.imageName = @"user25_prof";	user25.dietTags = @[_dietTags[7], _dietTags[6], _dietTags[1]];	[_users addObject:user25];
    MCTUser *user26 = [[MCTUser alloc] init];     user26.objectID = 26;	user26.name = @"Lisa B.";	user26.imageName = @"user26_prof";	user26.dietTags = @[_dietTags[3], _dietTags[4]];	[_users addObject:user26];
    MCTUser *user27 = [[MCTUser alloc] init];     user27.objectID = 27;	user27.name = @"Sterling B.";	user27.imageName = @"user27_prof";	user27.dietTags = @[_dietTags[1]];	[_users addObject:user27];
    MCTUser *user28 = [[MCTUser alloc] init];     user28.objectID = 28;	user28.name = @"Peter S.";	user28.imageName = @"user28_prof";	user28.dietTags = @[_dietTags[1]];	[_users addObject:user28];
    MCTUser *user29 = [[MCTUser alloc] init];     user29.objectID = 29;	user29.name = @"Julie S.";	user29.imageName = @"user29_prof";	user29.dietTags = @[_dietTags[0]];	[_users addObject:user29];
    MCTUser *user30 = [[MCTUser alloc] init];     user30.objectID = 30;	user30.name = @"Jen B.";	user30.imageName = @"user30_prof";	user30.dietTags = @[_dietTags[1]];	[_users addObject:user30];
    MCTUser *user31 = [[MCTUser alloc] init];     user31.objectID = 31;	user31.name = @"Surfer B.";	user31.imageName = @"user31_prof";	user31.dietTags = @[_dietTags[2], _dietTags[1]];	[_users addObject:user31];
    MCTUser *user32 = [[MCTUser alloc] init];     user32.objectID = 32;	user32.name = @"Diana W.";	user32.imageName = @"user32_prof";	user32.dietTags = @[_dietTags[2], _dietTags[7]];	[_users addObject:user32];
    MCTUser *user33 = [[MCTUser alloc] init];     user33.objectID = 33;	user33.name = @"Diana P.";	user33.imageName = @"user33_prof";	user33.dietTags = @[_dietTags[1], _dietTags[0]];	[_users addObject:user33];
    MCTUser *user34 = [[MCTUser alloc] init];     user34.objectID = 34;	user34.name = @"Earl J.";	user34.imageName = @"user34_prof";	user34.dietTags = @[_dietTags[7], _dietTags[5], _dietTags[1]];	[_users addObject:user34];
    MCTUser *user35 = [[MCTUser alloc] init];     user35.objectID = 35;	user35.name = @"Miriam K.";	user35.imageName = @"user35_prof";	user35.dietTags = @[_dietTags[2], _dietTags[5], _dietTags[7]];	[_users addObject:user35];
    MCTUser *user36 = [[MCTUser alloc] init];     user36.objectID = 36;	user36.name = @"Shwetha K.";	user36.imageName = @"user36_prof";	user36.dietTags = @[_dietTags[0]];	[_users addObject:user36];
    MCTUser *user37 = [[MCTUser alloc] init];     user37.objectID = 37;	user37.name = @"Shree K.";	user37.imageName = @"user37_prof";	user37.dietTags = @[_dietTags[0]];	[_users addObject:user37];
    MCTUser *user38 = [[MCTUser alloc] init];     user38.objectID = 38;	user38.name = @"Bob S.";	user38.imageName = @"user38_prof";	user38.dietTags = @[_dietTags[0]];	[_users addObject:user38];
    MCTUser *user39 = [[MCTUser alloc] init];     user39.objectID = 39;	user39.name = @"Acacio D.";	user39.imageName = @"user39_prof";	user39.dietTags = @[_dietTags[1]];	[_users addObject:user39];
    MCTUser *user40 = [[MCTUser alloc] init];     user40.objectID = 40;	user40.name = @"Eric H.";	user40.imageName = @"user40_prof";	user40.dietTags = @[_dietTags[0]];	[_users addObject:user40];
    MCTUser *user41 = [[MCTUser alloc] init];     user41.objectID = 41;	user41.name = @"Rosalina R.";	user41.imageName = @"user41_prof";	user41.dietTags = @[_dietTags[0]];	[_users addObject:user41];
    MCTUser *user42 = [[MCTUser alloc] init];     user42.objectID = 42;	user42.name = @"Nora T.";	user42.imageName = @"user42_prof";	user42.dietTags = @[_dietTags[0]];	[_users addObject:user42];
    MCTUser *user43 = [[MCTUser alloc] init];     user43.objectID = 43;	user43.name = @"Jister Y.";	user43.imageName = @"user43_prof";	user43.dietTags = @[_dietTags[0]];	[_users addObject:user43];
    MCTUser *user44 = [[MCTUser alloc] init];     user44.objectID = 44;	user44.name = @"Dana F.";	user44.imageName = @"user44_prof";	user44.dietTags = @[_dietTags[0]];	[_users addObject:user44];
    MCTUser *user45 = [[MCTUser alloc] init];     user45.objectID = 45;	user45.name = @"Brian O.";	user45.imageName = @"user45_prof";	user45.dietTags = @[_dietTags[7], _dietTags[0]];	[_users addObject:user45];
    MCTUser *user46 = [[MCTUser alloc] init];     user46.objectID = 46;	user46.name = @"Evan H.";	user46.imageName = @"user46_prof";	user46.dietTags = @[_dietTags[6]];	[_users addObject:user46];
    MCTUser *user47 = [[MCTUser alloc] init];     user47.objectID = 47;	user47.name = @"Tina L.";	user47.imageName = @"user47_prof";	user47.dietTags = @[_dietTags[6], _dietTags[4]];	[_users addObject:user47];
    MCTUser *user48 = [[MCTUser alloc] init];     user48.objectID = 48;	user48.name = @"Ellie F.";	user48.imageName = @"user48_prof";	user48.dietTags = @[_dietTags[0]];	[_users addObject:user48];
    MCTUser *user49 = [[MCTUser alloc] init];     user49.objectID = 49;	user49.name = @"Priyal M.";	user49.imageName = @"user49_prof";	user49.dietTags = @[_dietTags[0]];	[_users addObject:user49];
    MCTUser *user50 = [[MCTUser alloc] init];     user50.objectID = 50;	user50.name = @"Len R.";	user50.imageName = @"user50_prof";	user50.dietTags = @[_dietTags[4]];	[_users addObject:user50];
    MCTUser *user51 = [[MCTUser alloc] init];     user51.objectID = 51;	user51.name = @"Addie M.";	user51.imageName = @"user51_prof";	user51.dietTags = @[_dietTags[6], _dietTags[4]];	[_users addObject:user51];
    MCTUser *user52 = [[MCTUser alloc] init];     user52.objectID = 52;	user52.name = @"Ray C.";	user52.imageName = @"user52_prof";	user52.dietTags = @[_dietTags[2], _dietTags[6]];	[_users addObject:user52];
    MCTUser *user53 = [[MCTUser alloc] init];     user53.objectID = 53;	user53.name = @"Mari T.";	user53.imageName = @"user53_prof";	user53.dietTags = @[_dietTags[6]];	[_users addObject:user53];
    MCTUser *user54 = [[MCTUser alloc] init];     user54.objectID = 54;	user54.name = @"Diana L.";	user54.imageName = @"user54_prof";	user54.dietTags = @[_dietTags[6]];	[_users addObject:user54];
    MCTUser *user55 = [[MCTUser alloc] init];     user55.objectID = 55;	user55.name = @"Zin M.";	user55.imageName = @"user55_prof";	user55.dietTags = @[_dietTags[4]];	[_users addObject:user55];
    MCTUser *user56 = [[MCTUser alloc] init];     user56.objectID = 56;	user56.name = @"Dawn B.";	user56.imageName = @"user56_prof";	user56.dietTags = @[_dietTags[7]];	[_users addObject:user56];
    MCTUser *user57 = [[MCTUser alloc] init];     user57.objectID = 57;	user57.name = @"Azin A.";	user57.imageName = @"user57_prof";	user57.dietTags = @[_dietTags[2]];	[_users addObject:user57];
    MCTUser *user58 = [[MCTUser alloc] init];     user58.objectID = 58;	user58.name = @"Alexis D.";	user58.imageName = @"user58_prof";	user58.dietTags = @[_dietTags[7]];	[_users addObject:user58];
    MCTUser *user59 = [[MCTUser alloc] init];     user59.objectID = 59;	user59.name = @"Ginger W.";	user59.imageName = @"user59_prof";	user59.dietTags = @[_dietTags[2], _dietTags[7]];	[_users addObject:user59];
    MCTUser *user60 = [[MCTUser alloc] init];     user60.objectID = 60;	user60.name = @"Larry B.";	user60.imageName = @"user60_prof";	user60.dietTags = @[_dietTags[2]];	[_users addObject:user60];
    MCTUser *user61 = [[MCTUser alloc] init];     user61.objectID = 61;	user61.name = @"Ceecee M.";	user61.imageName = @"user61_prof";	user61.dietTags = @[_dietTags[6]];	[_users addObject:user61];
    MCTUser *user62 = [[MCTUser alloc] init];     user62.objectID = 62;	user62.name = @"Christina L.";	user62.imageName = @"user62_prof";	user62.dietTags = @[_dietTags[7]];	[_users addObject:user62];
    MCTUser *user63 = [[MCTUser alloc] init];     user63.objectID = 63;	user63.name = @"Stephanie B.";	user63.imageName = @"user63_prof";	user63.dietTags = @[_dietTags[7]];	[_users addObject:user63];
    MCTUser *user64 = [[MCTUser alloc] init];     user64.objectID = 64;	user64.name = @"Tanya N.";	user64.imageName = @"user64_prof";	user64.dietTags = @[_dietTags[2], _dietTags[7]];	[_users addObject:user64];
    MCTUser *user65 = [[MCTUser alloc] init];     user65.objectID = 65;	user65.name = @"Aimee A.";	user65.imageName = @"user65_prof";	user65.dietTags = @[_dietTags[4]];	[_users addObject:user65];
    MCTUser *user66 = [[MCTUser alloc] init];     user66.objectID = 66;	user66.name = @"Gerald F.";	user66.imageName = @"user66_prof";	user66.dietTags = @[_dietTags[4]];	[_users addObject:user66];
    MCTUser *user67 = [[MCTUser alloc] init];     user67.objectID = 67;	user67.name = @"Mimi T.";	user67.imageName = @"user67_prof";	user67.dietTags = @[_dietTags[6]];	[_users addObject:user67];
    MCTUser *user68 = [[MCTUser alloc] init];     user68.objectID = 68;	user68.name = @"Suzanne D.";	user68.imageName = @"user68_prof";	user68.dietTags = @[_dietTags[6]];	[_users addObject:user68];
    MCTUser *user69 = [[MCTUser alloc] init];     user69.objectID = 69;	user69.name = @"Christianna A.";	user69.imageName = @"user69_prof";	user69.dietTags = @[_dietTags[2]];	[_users addObject:user69];
    MCTUser *user70 = [[MCTUser alloc] init];     user70.objectID = 70;	user70.name = @"Jennifer V.";	user70.imageName = @"user70_prof";	user70.dietTags = @[_dietTags[4]];	[_users addObject:user70];
    MCTUser *user71 = [[MCTUser alloc] init];     user71.objectID = 71;	user71.name = @"Jenny H.";	user71.imageName = @"user71_prof";	user71.dietTags = @[_dietTags[2], _dietTags[7]];	[_users addObject:user71];
    MCTUser *user72 = [[MCTUser alloc] init];     user72.objectID = 72;	user72.name = @"Marissa C.";	user72.imageName = @"user72_prof";	user72.dietTags = @[_dietTags[2]];	[_users addObject:user72];
    MCTUser *user73 = [[MCTUser alloc] init];     user73.objectID = 73;	user73.name = @"Michael D.";	user73.imageName = @"user73_prof";	user73.dietTags = @[_dietTags[7]];	[_users addObject:user73];
    MCTUser *user74 = [[MCTUser alloc] init];     user74.objectID = 74;	user74.name = @"Lisa H.";	user74.imageName = @"user74_prof";	user74.dietTags = @[_dietTags[7]];	[_users addObject:user74];
    MCTUser *user75 = [[MCTUser alloc] init];     user75.objectID = 75;	user75.name = @"Xue H.";	user75.imageName = @"user75_prof";	user75.dietTags = @[_dietTags[7], _dietTags[5]];	[_users addObject:user75];
    MCTUser *user76 = [[MCTUser alloc] init];     user76.objectID = 76;	user76.name = @"Eddie M.";	user76.imageName = @"user76_prof";	user76.dietTags = @[_dietTags[7], _dietTags[1], _dietTags[0]];	[_users addObject:user76];
    MCTUser *user77 = [[MCTUser alloc] init];     user77.objectID = 77;	user77.name = @"Jenna F.";	user77.imageName = @"user77_prof";	user77.dietTags = @[_dietTags[7]];	[_users addObject:user77];
    MCTUser *user78 = [[MCTUser alloc] init];     user78.objectID = 78;	user78.name = @"Sav V.";	user78.imageName = @"user78_prof";	user78.dietTags = @[_dietTags[6]];	[_users addObject:user78];
    MCTUser *user79 = [[MCTUser alloc] init];     user79.objectID = 79;	user79.name = @"Alexis A.";	user79.imageName = @"user79_prof";	user79.dietTags = @[_dietTags[2]];	[_users addObject:user79];
    MCTUser *user80 = [[MCTUser alloc] init];     user80.objectID = 80;	user80.name = @"Eliot K.";	user80.imageName = @"user80_prof";	user80.dietTags = @[_dietTags[7], _dietTags[1], _dietTags[0]];	[_users addObject:user80];
    MCTUser *user81 = [[MCTUser alloc] init];     user81.objectID = 81;	user81.name = @"Baby B.";	user81.imageName = @"user81_prof";	user81.dietTags = @[_dietTags[7]];	[_users addObject:user81];
    MCTUser *user82 = [[MCTUser alloc] init];     user82.objectID = 82;	user82.name = @"Tuan V.";	user82.imageName = @"user82_prof";	user82.dietTags = @[_dietTags[2], _dietTags[7]];	[_users addObject:user82];
    MCTUser *user83 = [[MCTUser alloc] init];     user83.objectID = 83;	user83.name = @"Kim D.";	user83.imageName = @"user83_prof";	user83.dietTags = @[_dietTags[2], _dietTags[7], _dietTags[5]];	[_users addObject:user83];
    MCTUser *user84 = [[MCTUser alloc] init];     user84.objectID = 84;	user84.name = @"Phillippe A.";	user84.imageName = @"user84_prof";	user84.dietTags = @[_dietTags[7], _dietTags[0]];	[_users addObject:user84];
    MCTUser *user85 = [[MCTUser alloc] init];     user85.objectID = 85;	user85.name = @"Mary H.";	user85.imageName = @"user85_prof";	user85.dietTags = @[_dietTags[7]];	[_users addObject:user85];
    MCTUser *user86 = [[MCTUser alloc] init];     user86.objectID = 86;	user86.name = @"David J.";	user86.imageName = @"user86_prof";	user86.dietTags = @[_dietTags[7]];	[_users addObject:user86];
    MCTUser *user87 = [[MCTUser alloc] init];     user87.objectID = 87;	user87.name = @"Carolina T.";	user87.imageName = @"user87_prof";	user87.dietTags = @[_dietTags[1]];	[_users addObject:user87];
    MCTUser *user88 = [[MCTUser alloc] init];     user88.objectID = 88;	user88.name = @"Brandi W.";	user88.imageName = @"user88_prof";	user88.dietTags = @[_dietTags[1]];	[_users addObject:user88];
}

#define ARC4RANDOM_MAX 0x100000000

-(void) initRestaurants {
    _restaurants = [[NSMutableArray<MCTRestaurant *> alloc] init];
    MCTRestaurant *restaurant0 = [[MCTRestaurant alloc] init];	restaurant0.objectID = 0;	restaurant0.name = @"RawDaddy’s Fun Cone Food";	restaurant0.urlString = @"rawdaddys.com";	restaurant0.imageName = @"0_prof";	restaurant0.phone = @"(818) 571-5730";	restaurant0.location = [[CLLocation alloc] initWithLatitude:37.441883 longitude:-122.143019];	restaurant0.details = @"Caterers";	restaurant0.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	[_restaurants addObject:restaurant0];
    MCTRestaurant *restaurant1 = [[MCTRestaurant alloc] init];	restaurant1.objectID = 1;	restaurant1.name = @"Calafia Cafe";	restaurant1.urlString = @"calafiapaloalto.com";	restaurant1.imageName = @"1_prof";	restaurant1.phone = @"(650)322-9200";	restaurant1.location = [[CLLocation alloc] initWithLatitude:37.438625 longitude:-122.160529];	restaurant1.details = @"American (New), Sandwiches";	restaurant1.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	[_restaurants addObject:restaurant1];
    MCTRestaurant *restaurant2 = [[MCTRestaurant alloc] init];	restaurant2.objectID = 2;	restaurant2.name = @"California Pizza Kitchen";	restaurant2.urlString = @"";	restaurant2.imageName = @"2_prof";	restaurant2.phone = @"(650) 325-2753";	restaurant2.location = [[CLLocation alloc] initWithLatitude:37.443358 longitude:-122.17224];	restaurant2.details = @"Pizza, American (Traditional)";	restaurant2.dietTags = @[_dietTags[2], _dietTags[3], _dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant2];
    MCTRestaurant *restaurant3 = [[MCTRestaurant alloc] init];	restaurant3.objectID = 3;	restaurant3.name = @"Shuly's Bakery";	restaurant3.urlString = @"";	restaurant3.imageName = @"3_prof";	restaurant3.phone = @"(877) 228-2165";	restaurant3.location = [[CLLocation alloc] initWithLatitude:37.242941 longitude:-121.931365];	restaurant3.details = @"Bakeries";	restaurant3.dietTags = @[_dietTags[1], _dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant3];
    MCTRestaurant *restaurant4 = [[MCTRestaurant alloc] init];	restaurant4.objectID = 4;	restaurant4.name = @"Lyfe Kitchen";	restaurant4.urlString = @"";	restaurant4.imageName = @"4_prof";	restaurant4.phone = @"(650) 325-5933";	restaurant4.location = [[CLLocation alloc] initWithLatitude:37.443572 longitude:-122.162216];	restaurant4.details = @"American (New)";	restaurant4.dietTags = @[_dietTags[1], _dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant4];
    MCTRestaurant *restaurant5 = [[MCTRestaurant alloc] init];	restaurant5.objectID = 5;	restaurant5.name = @"The Melt Stanford";	restaurant5.urlString = @"";	restaurant5.imageName = @"5_prof";	restaurant5.phone = @"(650) 461-4450";	restaurant5.location = [[CLLocation alloc] initWithLatitude:37.444289 longitude:-122.171079];	restaurant5.details = @"Sandwiches, American (Traditional)";	restaurant5.dietTags = @[ _dietTags[6]];	[_restaurants addObject:restaurant5];
    MCTRestaurant *restaurant6 = [[MCTRestaurant alloc] init];	restaurant6.objectID = 6;	restaurant6.name = @"Gott's Roadside ";	restaurant6.urlString = @"";	restaurant6.imageName = @"6_prof";	restaurant6.phone = @"(650) 521-9996";	restaurant6.location = [[CLLocation alloc] initWithLatitude:37.438625 longitude:-122.160529];	restaurant6.details = @"American (New), Burgers";	restaurant6.dietTags = @[ _dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant6];
    MCTRestaurant *restaurant7 = [[MCTRestaurant alloc] init];	restaurant7.objectID = 7;	restaurant7.name = @"Tacolicous";	restaurant7.urlString = @"";	restaurant7.imageName = @"7_prof";	restaurant7.phone = @"(415) 649-6077";	restaurant7.location = [[CLLocation alloc] initWithLatitude:37.443355 longitude:-122.161124];	restaurant7.details = @"Mexican, Cocktail Bars";	restaurant7.dietTags = @[ _dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant7];
    MCTRestaurant *restaurant8 = [[MCTRestaurant alloc] init];	restaurant8.objectID = 8;	restaurant8.name = @"Cascal Restaurant";	restaurant8.urlString = @"";	restaurant8.imageName = @"8_prof";	restaurant8.phone = @"(650) 940-9500";	restaurant8.location = [[CLLocation alloc] initWithLatitude:37.391202 longitude:-122.081099];	restaurant8.details = @"Tapas/Small Plates, Spanish";	restaurant8.dietTags = @[_dietTags[2], _dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant8];
    MCTRestaurant *restaurant9 = [[MCTRestaurant alloc] init];	restaurant9.objectID = 9;	restaurant9.name = @"JJ Magoo's Pizza";	restaurant9.urlString = @"";	restaurant9.imageName = @"9_prof";	restaurant9.phone = @"(408) 358-2000";	restaurant9.location = [[CLLocation alloc] initWithLatitude:37.243396 longitude:-121.960645];	restaurant9.details = @"Pizza, Sandwiches, Brewery";	restaurant9.dietTags = @[_dietTags[6]];	[_restaurants addObject:restaurant9];
    MCTRestaurant *restaurant10 = [[MCTRestaurant alloc] init];	restaurant10.objectID = 10;	restaurant10.name = @"Crouching Tiger Restaurant";	restaurant10.urlString = @"";	restaurant10.imageName = @"10_prof";	restaurant10.phone = @"(650) 298-8881";	restaurant10.location = [[CLLocation alloc] initWithLatitude:37.486492 longitude:-122.234295];	restaurant10.details = @"Chinese";	restaurant10.dietTags = @[_dietTags[2], _dietTags[3], _dietTags[4], _dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant10];
    MCTRestaurant *restaurant11 = [[MCTRestaurant alloc] init];	restaurant11.objectID = 11;	restaurant11.name = @"Cuban Kitchen";	restaurant11.urlString = @"";	restaurant11.imageName = @"11_prof";	restaurant11.phone = @"(650) 627-4636";	restaurant11.location = [[CLLocation alloc] initWithLatitude:37.533799 longitude:-122.293453];	restaurant11.details = @"Cuban, Latin American";	restaurant11.dietTags = @[_dietTags[6]];	[_restaurants addObject:restaurant11];
    MCTRestaurant *restaurant12 = [[MCTRestaurant alloc] init];	restaurant12.objectID = 12;	restaurant12.name = @"Kingfish Restaurant";	restaurant12.urlString = @"";	restaurant12.imageName = @"12_prof";	restaurant12.phone = @"(650) 343-1226";	restaurant12.location = [[CLLocation alloc] initWithLatitude:37.566317 longitude:-122.322877];	restaurant12.details = @"American (New), Seafood, Steakhouse";	restaurant12.dietTags = @[_dietTags[2], _dietTags[3], _dietTags[4]];	[_restaurants addObject:restaurant12];
    MCTRestaurant *restaurant13 = [[MCTRestaurant alloc] init];	restaurant13.objectID = 13;	restaurant13.name = @"Garden Fresh Chinese Vegan Cuisine";	restaurant13.urlString = @"http://www.gardenfresh.us/";	restaurant13.imageName = @"13_prof";	restaurant13.phone = @"(650) 462-9298";	restaurant13.location = [[CLLocation alloc] initWithLatitude:37.445573 longitude:-122.162864];	restaurant13.details = @"Chinese";	restaurant13.dietTags = @[_dietTags[0], _dietTags[1]];	[_restaurants addObject:restaurant13];
    MCTRestaurant *restaurant14 = [[MCTRestaurant alloc] init];	restaurant14.objectID = 14;	restaurant14.name = @"True Food Kitchen";	restaurant14.urlString = @"http://www.truefoodkitchen.com/locations/palo-alto/";	restaurant14.imageName = @"14_prof";	restaurant14.phone = @"(650) 272-5157";	restaurant14.location = [[CLLocation alloc] initWithLatitude:37.444289 longitude:-122.171079];	restaurant14.details = @"American (New)";	restaurant14.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[7]];	[_restaurants addObject:restaurant14];
    MCTRestaurant *restaurant15 = [[MCTRestaurant alloc] init];	restaurant15.objectID = 15;	restaurant15.name = @"Oren's Hummus";	restaurant15.urlString = @"";	restaurant15.imageName = @"15_prof";	restaurant15.phone = @"(650)752-6492";	restaurant15.location = [[CLLocation alloc] initWithLatitude:37.445717 longitude:-122.162173];	restaurant15.details = @"Mediterrranean, Middle Eastern";	restaurant15.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	[_restaurants addObject:restaurant15];
    MCTRestaurant *restaurant16 = [[MCTRestaurant alloc] init];	restaurant16.objectID = 16;	restaurant16.name = @"Curry-Up Now";	restaurant16.urlString = @"";	restaurant16.imageName = @"16_prof";	restaurant16.phone = @"(650) 300-4690";	restaurant16.location = [[CLLocation alloc] initWithLatitude:37.445479 longitude:-122.160241];	restaurant16.details = @"Indian";	restaurant16.dietTags = @[_dietTags[0], _dietTags[1],_dietTags[7]];	[_restaurants addObject:restaurant16];
    MCTRestaurant *restaurant17 = [[MCTRestaurant alloc] init];	restaurant17.objectID = 17;	restaurant17.name = @"Veggie Garden";	restaurant17.urlString = @"";	restaurant17.imageName = @"17_prof";	restaurant17.phone = @"(650) 961-6888";	restaurant17.location = [[CLLocation alloc] initWithLatitude:37.398932 longitude:-122.108886];	restaurant17.details = @"Chinese";	restaurant17.dietTags = @[_dietTags[0], _dietTags[1]];	[_restaurants addObject:restaurant17];
    MCTRestaurant *restaurant18 = [[MCTRestaurant alloc] init];	restaurant18.objectID = 18;	restaurant18.name = @"The Phoenix";	restaurant18.urlString = @"";	restaurant18.imageName = @"18_prof";	restaurant18.phone = @"(650) 282 - 5701";	restaurant18.location = [[CLLocation alloc] initWithLatitude:37.387999 longitude:-122.082985];	restaurant18.details = @"Juice Bars & Smoothies, Breakfast & Brunch";	restaurant18.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[5]];	[_restaurants addObject:restaurant18];
    MCTRestaurant *restaurant19 = [[MCTRestaurant alloc] init];	restaurant19.objectID = 19;	restaurant19.name = @"Bowl of Heaven";	restaurant19.urlString = @"";	restaurant19.imageName = @"19_prof";	restaurant19.phone = @"(650) 282-5710";	restaurant19.location = [[CLLocation alloc] initWithLatitude:37.379282 longitude:-122.075126];	restaurant19.details = @"Juice Bars & Smoothies";	restaurant19.dietTags = @[_dietTags[0], _dietTags[1]];	[_restaurants addObject:restaurant19];
    MCTRestaurant *restaurant20 = [[MCTRestaurant alloc] init];	restaurant20.objectID = 20;	restaurant20.name = @"Vitality Bowls";	restaurant20.urlString = @"";	restaurant20.imageName = @"20_prof";	restaurant20.phone = @"(650) 473-9740";	restaurant20.location = [[CLLocation alloc] initWithLatitude:37.428148 longitude:-122.143141];	restaurant20.details = @"Juice Bars & Smoothies";	restaurant20.dietTags = @[_dietTags[0], _dietTags[7]];	[_restaurants addObject:restaurant20];
    MCTRestaurant *restaurant21 = [[MCTRestaurant alloc] init];	restaurant21.objectID = 21;	restaurant21.name = @"La Fontaine Restaurant";	restaurant21.urlString = @"";	restaurant21.imageName = @"21_prof";	restaurant21.phone = @"(650) 968-2300";	restaurant21.location = [[CLLocation alloc] initWithLatitude:37.394169 longitude:-122.079113];	restaurant21.details = @"Italian, French";	restaurant21.dietTags = @[_dietTags[0]];	[_restaurants addObject:restaurant21];
    MCTRestaurant *restaurant22 = [[MCTRestaurant alloc] init];	restaurant22.objectID = 22;	restaurant22.name = @"Reposado";	restaurant22.urlString = @"";	restaurant22.imageName = @"22_prof";	restaurant22.phone = @"(650) 833-3141";	restaurant22.location = [[CLLocation alloc] initWithLatitude:37.444154 longitude:-122.160942];	restaurant22.details = @"Mexican";	restaurant22.dietTags = @[_dietTags[0]];	[_restaurants addObject:restaurant22];
    MCTRestaurant *restaurant23 = [[MCTRestaurant alloc] init];	restaurant23.objectID = 23;	restaurant23.name = @"Darbar Indian Cuisine";	restaurant23.urlString = @"";	restaurant23.imageName = @"23_prof";	restaurant23.phone = @"(650) 321-6688";	restaurant23.location = [[CLLocation alloc] initWithLatitude:37.444848 longitude:-122.165156];	restaurant23.details = @"Indian";	restaurant23.dietTags = @[_dietTags[0]];	[_restaurants addObject:restaurant23];
    MCTRestaurant *restaurant24 = [[MCTRestaurant alloc] init];	restaurant24.objectID = 24;	restaurant24.name = @"Amber Dhara";	restaurant24.urlString = @"";	restaurant24.imageName = @"24_prof";	restaurant24.phone = @"(650) 329-9644";	restaurant24.location = [[CLLocation alloc] initWithLatitude:37.443997 longitude:-122.162979];	restaurant24.details = @"Indian";	restaurant24.dietTags = @[_dietTags[0]];	[_restaurants addObject:restaurant24];
    MCTRestaurant *restaurant25 = [[MCTRestaurant alloc] init];	restaurant25.objectID = 25;	restaurant25.name = @"Plutos";	restaurant25.urlString = @"";	restaurant25.imageName = @"25_prof";	restaurant25.phone = @"(650) 853-1556";	restaurant25.location = [[CLLocation alloc] initWithLatitude:37.447989 longitude:-122.159237];	restaurant25.details = @"Salad, Sandwiches";	restaurant25.dietTags = @[_dietTags[0]];	[_restaurants addObject:restaurant25];
    MCTRestaurant *restaurant26 = [[MCTRestaurant alloc] init];	restaurant26.objectID = 26;	restaurant26.name = @"So Gong Dong Tofu House";	restaurant26.urlString = @"";	restaurant26.imageName = @"26_prof";	restaurant26.phone = @"(650) 424-8805";	restaurant26.location = [[CLLocation alloc] initWithLatitude:37.413804 longitude:-122.12537];	restaurant26.details = @"Korean, Barbeque";	restaurant26.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[4],_dietTags[6]];	[_restaurants addObject:restaurant26];
    MCTRestaurant *restaurant27 = [[MCTRestaurant alloc] init];	restaurant27.objectID = 27;	restaurant27.name = @"Evvia Estiatorio";	restaurant27.urlString = @"";	restaurant27.imageName = @"27_prof";	restaurant27.phone = @"(650)326-0983";	restaurant27.location = [[CLLocation alloc] initWithLatitude:37.445079 longitude:-122.163794];	restaurant27.details = @"Greek";	restaurant27.dietTags = @[_dietTags[4]];	[_restaurants addObject:restaurant27];
    MCTRestaurant *restaurant28 = [[MCTRestaurant alloc] init];	restaurant28.objectID = 28;	restaurant28.name = @"Chez TJ";	restaurant28.urlString = @"";	restaurant28.imageName = @"28_prof";	restaurant28.phone = @"(650) 964-7466";	restaurant28.location = [[CLLocation alloc] initWithLatitude:37.394648 longitude:-122.080441];	restaurant28.details = @"French";	restaurant28.dietTags = @[_dietTags[4], _dietTags[6]];	[_restaurants addObject:restaurant28];
    MCTRestaurant *restaurant29 = [[MCTRestaurant alloc] init];	restaurant29.objectID = 29;	restaurant29.name = @"Asian Box";	restaurant29.urlString = @"";	restaurant29.imageName = @"29_prof";	restaurant29.phone = @"(650) 391-9305";	restaurant29.location = [[CLLocation alloc] initWithLatitude:37.438625 longitude:-122.160529];	restaurant29.details = @"Vietnamese";	restaurant29.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	[_restaurants addObject:restaurant29];
    MCTRestaurant *restaurant30 = [[MCTRestaurant alloc] init];	restaurant30.objectID = 30;	restaurant30.name = @"Shangri-La Chinese Restaurant";	restaurant30.urlString = @"";	restaurant30.imageName = @"30_prof";	restaurant30.phone = @"(408) 358-5020";	restaurant30.location = [[CLLocation alloc] initWithLatitude:37.234294 longitude:-121.961557];	restaurant30.details = @"Chinese";	restaurant30.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	[_restaurants addObject:restaurant30];
    MCTRestaurant *restaurant31 = [[MCTRestaurant alloc] init];	restaurant31.objectID = 31;	restaurant31.name = @"Bare Bowls";	restaurant31.urlString = @"";	restaurant31.imageName = @"31_prof";	restaurant31.phone = @"(650) 272-6885";	restaurant31.location = [[CLLocation alloc] initWithLatitude:37.444132 longitude:-122.162373];	restaurant31.details = @"Juice Bars & Smoohies";	restaurant31.dietTags = @[_dietTags[2], _dietTags[7]];	[_restaurants addObject:restaurant31];
    MCTRestaurant *restaurant32 = [[MCTRestaurant alloc] init];	restaurant32.objectID = 32;	restaurant32.name = @"Slow Hand BBQ";	restaurant32.urlString = @"";	restaurant32.imageName = @"32_prof";	restaurant32.phone = @"(925) 942-0149";	restaurant32.location = [[CLLocation alloc] initWithLatitude:37.933444 longitude:-122.075484];	restaurant32.details = @"Barbeque";	restaurant32.dietTags = @[_dietTags[2], _dietTags[7]];	[_restaurants addObject:restaurant32];
    MCTRestaurant *restaurant33 = [[MCTRestaurant alloc] init];	restaurant33.objectID = 33;	restaurant33.name = @"Country Gourmet Restaurant";	restaurant33.urlString = @"country-gourmet.com";	restaurant33.imageName = @"33_prof";	restaurant33.phone = @"(408) 733-9446 ";	restaurant33.location = [[CLLocation alloc] initWithLatitude:37.351231 longitude:-122.049484];	restaurant33.details = @"American (Traditional)";	restaurant33.dietTags = @[_dietTags[2],_dietTags[4],_dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant33];
    MCTRestaurant *restaurant34 = [[MCTRestaurant alloc] init];	restaurant34.objectID = 34;	restaurant34.name = @"Pizza Antica";	restaurant34.urlString = @"pizzaantica.com";	restaurant34.imageName = @"34_prof";	restaurant34.phone = @"(408) 557-8373";	restaurant34.location = [[CLLocation alloc] initWithLatitude:37.321848 longitude:-121.947451];	restaurant34.details = @"Pizza";	restaurant34.dietTags = @[_dietTags[3], _dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant34];
    MCTRestaurant *restaurant35 = [[MCTRestaurant alloc] init];	restaurant35.objectID = 35;	restaurant35.name = @"Zest Bakery";	restaurant35.urlString = @"www.zestbakery.com/";	restaurant35.imageName = @"35_prof";	restaurant35.phone = @"(650) 241-9378";	restaurant35.location = [[CLLocation alloc] initWithLatitude:37.502421 longitude:-122.257132];	restaurant35.details = @"Bakeries";	restaurant35.dietTags = @[_dietTags[3],_dietTags[7]];	[_restaurants addObject:restaurant35];
    MCTRestaurant *restaurant36 = [[MCTRestaurant alloc] init];	restaurant36.objectID = 36;	restaurant36.name = @"Sam's Chowder House";	restaurant36.urlString = @"";	restaurant36.imageName = @"36_prof";	restaurant36.phone = @"(650) 614-1177";	restaurant36.location = [[CLLocation alloc] initWithLatitude:37.444722 longitude:-122.163156];	restaurant36.details = @"Seafood, Breakfast & Brunch";	restaurant36.dietTags = @[_dietTags[4], _dietTags[6]];	[_restaurants addObject:restaurant36];
    MCTRestaurant *restaurant37 = [[MCTRestaurant alloc] init];	restaurant37.objectID = 37;	restaurant37.name = @"Il Fornaio Cucina Italiana";	restaurant37.urlString = @"ilfornaio.com";	restaurant37.imageName = @"37_prof";	restaurant37.phone = @"(650) 853-3888";	restaurant37.location = [[CLLocation alloc] initWithLatitude:37.447745 longitude:-122.159036];	restaurant37.details = @"Italian, Pizza, Seafood";	restaurant37.dietTags = @[_dietTags[2], _dietTags[3], _dietTags[7]];	[_restaurants addObject:restaurant37];
    MCTRestaurant *restaurant38 = [[MCTRestaurant alloc] init];	restaurant38.objectID = 38;	restaurant38.name = @"P F Chang's China Bistro";	restaurant38.urlString = @"pfchangs.com";	restaurant38.imageName = @"38_prof";	restaurant38.phone = @"(408) 991-9078";	restaurant38.location = [[CLLocation alloc] initWithLatitude:37.364836 longitude:-122.028866];	restaurant38.details = @"Chinese, Asian Fusion";	restaurant38.dietTags = @[_dietTags[2], _dietTags[3], _dietTags[6], _dietTags[7]];	[_restaurants addObject:restaurant38];
    MCTRestaurant *restaurant39 = [[MCTRestaurant alloc] init];	restaurant39.objectID = 39;	restaurant39.name = @"Jamba Juice";	restaurant39.urlString = @"jambajuice.com";	restaurant39.imageName = @"39_prof";	restaurant39.phone = @"(650) 325-2582";	restaurant39.location = [[CLLocation alloc] initWithLatitude:37.438625 longitude:-122.160529];	restaurant39.details = @"Juice Bars & Smoothies";	restaurant39.dietTags = @[_dietTags[2], _dietTags[3]];	[_restaurants addObject:restaurant39];
    MCTRestaurant *restaurant40 = [[MCTRestaurant alloc] init];	restaurant40.objectID = 40;	restaurant40.name = @"Pampas";	restaurant40.urlString = @"pampaspaloalto.com";	restaurant40.imageName = @"40_prof";	restaurant40.phone = @"(650) 327-1323";	restaurant40.location = [[CLLocation alloc] initWithLatitude:37.443075 longitude:-122.162824];	restaurant40.details = @"Brazilian, Steakhouse, Barbeque";	restaurant40.dietTags = @[_dietTags[4], _dietTags[7]];	[_restaurants addObject:restaurant40];
    MCTRestaurant *restaurant41 = [[MCTRestaurant alloc] init];	restaurant41.objectID = 41;	restaurant41.name = @"Baja Fresh Mexican Grill";	restaurant41.urlString = @" bajafresh.com";	restaurant41.imageName = @"41_prof";	restaurant41.phone = @"(650) 424-8599";	restaurant41.location = [[CLLocation alloc] initWithLatitude:37.415473 longitude:-122.128963];	restaurant41.details = @"Mexican, Fast Food";	restaurant41.dietTags = @[_dietTags[3], _dietTags[5], _dietTags[6]];	[_restaurants addObject:restaurant41];
    MCTRestaurant *restaurant42 = [[MCTRestaurant alloc] init];	restaurant42.objectID = 42;	restaurant42.name = @"The Counter Palo Alto";	restaurant42.urlString = @"thecounterburger.com";	restaurant42.imageName = @"42_prof";	restaurant42.phone = @"(650) 321-3900";	restaurant42.location = [[CLLocation alloc] initWithLatitude:37.426681 longitude:-122.14415];	restaurant42.details = @"Burgers, Sandwiches";	restaurant42.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2]];	[_restaurants addObject:restaurant42];
    MCTRestaurant *restaurant43 = [[MCTRestaurant alloc] init];	restaurant43.objectID = 43;	restaurant43.name = @"Mozzeria";	restaurant43.urlString = @"mozzeria.com";	restaurant43.imageName = @"43_prof";	restaurant43.phone = @"(415) 489-0963";	restaurant43.location = [[CLLocation alloc] initWithLatitude:37.764962 longitude:-122.424874];	restaurant43.details = @"Pizza, Italian";	restaurant43.dietTags = @[_dietTags[2]];	[_restaurants addObject:restaurant43];
    MCTRestaurant *restaurant44 = [[MCTRestaurant alloc] init];	restaurant44.objectID = 44;	restaurant44.name = @"Sprout Cafe";	restaurant44.urlString = @"cafesprout.com";	restaurant44.imageName = @"44_prof";	restaurant44.phone = @"(650) 323-7688";	restaurant44.location = [[CLLocation alloc] initWithLatitude:37.444218 longitude:-122.162843];	restaurant44.details = @"Salads, Sandwiches, Coffee & Tea";	restaurant44.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	[_restaurants addObject:restaurant44];
    MCTRestaurant *restaurant45 = [[MCTRestaurant alloc] init];	restaurant45.objectID = 45;	restaurant45.name = @"Loving Hut";	restaurant45.urlString = @"lovinghut.us";	restaurant45.imageName = @"45_prof";	restaurant45.phone = @"(408) 943-0250";	restaurant45.location = [[CLLocation alloc] initWithLatitude:37.420556 longitude:-121.917218];	restaurant45.details = @"Asian Fusion";	restaurant45.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2]];	[_restaurants addObject:restaurant45];
    MCTRestaurant *restaurant46 = [[MCTRestaurant alloc] init];	restaurant46.objectID = 46;	restaurant46.name = @"Patxi's Pizza";	restaurant46.urlString = @"patxispizza.com";	restaurant46.imageName = @"46_prof";	restaurant46.phone = @"(650) 473-9999";	restaurant46.location = [[CLLocation alloc] initWithLatitude:37.445189 longitude:-122.163226];	restaurant46.details = @"Pizza, Salad, Italian";	restaurant46.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[5]];	[_restaurants addObject:restaurant46];
    MCTRestaurant *restaurant47 = [[MCTRestaurant alloc] init];	restaurant47.objectID = 47;	restaurant47.name = @"Mandarin Roots";	restaurant47.urlString = @"mandarinroots.com";	restaurant47.imageName = @"47_prof";	restaurant47.phone = @"(650) 565-8868";	restaurant47.location = [[CLLocation alloc] initWithLatitude:37.420282 longitude:-122.136033];	restaurant47.details = @"Chinese, Asian Fusion, Tapas/Small Plates";	restaurant47.dietTags = @[_dietTags[0],_dietTags[2], _dietTags[7]];	[_restaurants addObject:restaurant47];
    MCTRestaurant *restaurant48 = [[MCTRestaurant alloc] init];	restaurant48.objectID = 48;	restaurant48.name = @"Mayfield Bakery & Cafe";	restaurant48.urlString = @"mayfieldbakery.com";	restaurant48.imageName = @"48_prof";	restaurant48.phone = @"(650) 853-9200";	restaurant48.location = [[CLLocation alloc] initWithLatitude:37.438625 longitude:-122.160529];	restaurant48.details = @"American (New), Bakeries, Breakfast & Brunch";	restaurant48.dietTags = @[_dietTags[0], _dietTags[7]];	[_restaurants addObject:restaurant48];
    _allRestaurants = [[NSMutableArray alloc] init];
    for (MCTRestaurant *restaurant in _restaurants) {
        [restaurant setPrice: arc4random_uniform(3)+1];
        double rating = ((double)arc4random() / ARC4RANDOM_MAX) * (5) + 1;
        [restaurant setOverallRating: rating];
        [_allRestaurants addObject:restaurant];
    }
}


-(void) initEvents {
    _events = [[NSMutableArray<MCTEvent *> alloc] init];
    MCTEvent *event0= [[MCTEvent alloc] init]; event0.objectID = 0;	event0.name = @"Taco Tuesday Happy Hour";	event0.details = @"Fellow Celiac's and gluten-free friends come enjoy a fun, festive, and oh did I forget to mention tasty, happy hour at one of my favorite gluten-free spots in PA! I can't wait to meetchew(all)there ;) ";	event0.date = [MCTUtils dateWithYear:2016 month:12 day:12 hour:17 minute:30];	event0.admin = _users[13];	event0.isGoing = NO;	event0.capacity = 7;	event0.restaurant = _restaurants[7];	event0.dietTags = @[ _dietTags[6], _dietTags[7]];	event0.guests = [[NSMutableArray alloc] initWithArray: @[_users[13]]];	[_events addObject:event0];
    MCTEvent *event1= [[MCTEvent alloc] init]; event1.objectID = 1;	event1.name = @"Teagan's Vegan Extravaganza";	event1.details = @"Hi! I'm a vegan and a total foodie. I am new to the area and I'm super excited to explore the vegan food scene and I want to share my food adventures with you! Come join me as I test out Calafia Cafe - I've heard only great things, they even have an entire vegan/veggie friendly menu!! ";	event1.date = [MCTUtils dateWithYear:2016 month:12 day:13 hour:18 minute:30];	event1.admin = _users[18];	event1.isGoing = NO;	event1.capacity = 12;	event1.restaurant = _restaurants[1];	event1.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	event1.guests = [[NSMutableArray alloc] initWithArray: @[_users[18], _users[27]]];	[_events addObject:event1];
    MCTEvent *event2= [[MCTEvent alloc] init]; event2.objectID = 2;	event2.name = @"No Nuts Allowed";	event2.details = @"If you're like me then you find yourself constantly wondering why all the best baked goods have nuts? Come meet me at Shuly's to discuss this and other #nutallergypeopleproblems while we enjoy some of the best nut free baked goods I have ever had (sorry mom)";	event2.date = [MCTUtils dateWithYear:2016 month:12 day:10 hour:10 minute:0];	event2.admin = _users[21];	event2.isGoing = NO;	event2.capacity = 7;	event2.restaurant = _restaurants[3];	event2.dietTags = @[_dietTags[2], _dietTags[3], _dietTags[6], _dietTags[7]];	event2.guests = [[NSMutableArray alloc] initWithArray: @[_users[21], _users[10], _users[78]]];	[_events addObject:event2];
    MCTEvent *event3= [[MCTEvent alloc] init]; event3.objectID = 3;	event3.name = @"No Dairy With Larry";	event3.details = @"Hi, I'm Larry and I can't eat dairy. If you're like me and can't eat dairy, or your name rhymes with dairy, come join me for a nice weekend lunch of some of the area's best falafel and hummus (and did I mention it's all dairy free)!";	event3.date = [MCTUtils dateWithYear:2016 month:12 day:12 hour:12 minute:30];	event3.admin = _users[60];	event3.isGoing = NO;	event3.capacity = 8;	event3.restaurant = _restaurants[15];	event3.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[7]];	event3.guests = [[NSMutableArray alloc] initWithArray: @[_users[60], _users[57], _users[59]]];	[_events addObject:event3];
    MCTEvent *event4= [[MCTEvent alloc] init]; event4.objectID = 4;	event4.name = @"Bob's Brunch Bunch";	event4.details = @"Vegetarian Brunch - enough said. meetchewthere Saturday Dec 11 @ 11";	event4.date = [MCTUtils dateWithYear:2016 month:12 day:12 hour:11 minute:0];	event4.admin = _users[38];	event4.isGoing = NO;	event4.capacity = 5;	event4.restaurant = _restaurants[48];	event4.dietTags = @[_dietTags[0],_dietTags[2], _dietTags[7]];	event4.guests = [[NSMutableArray alloc] initWithArray: @[_users[38]]];	[_events addObject:event4];
    MCTEvent *event5= [[MCTEvent alloc] init]; event5.objectID = 5;	event5.name = @"Not Your Mom's BBQ";	event5.details = @"I've searched high and low and guys I finally found it - a dairy free, gluten free bbq joint in the bay area!!! If you're like me and salivating just thinking about all that smokey roasted bbq goodness meet me at this hidden gem - aka the most underated bbq joint in town!";	event5.date = [MCTUtils dateWithYear:2016 month:12 day:17 hour:18 minute:0];	event5.admin = _users[32];	event5.isGoing = NO;	event5.capacity = 12;	event5.restaurant = _restaurants[32];	event5.dietTags = @[_dietTags[2], _dietTags[7]];	event5.guests = [[NSMutableArray alloc] initWithArray: @[_users[32], _users[64], _users[82], _users[3]]];	[_events addObject:event5];
    MCTEvent *event6= [[MCTEvent alloc] init]; event6.objectID = 6;	event6.name = @"Beginning To Be A Vegan";	event6.details = @"Calling all vegans. I recently adopted a completely vegan lifestyle and I am looking for fellow vegans to eat and share/explore recipes and restaurants with. I can't wait to meetchewthere :)";	event6.date = [MCTUtils dateWithYear:2016 month:12 day:18 hour:17 minute:30];	event6.admin = _users[30];	event6.isGoing = NO;	event6.capacity = 11;	event6.restaurant = _restaurants[33];	event6.dietTags = @[_dietTags[2], _dietTags[7]];	event6.guests = [[NSMutableArray alloc] initWithArray: @[_users[30]]];	[_events addObject:event6];
    MCTEvent *event7= [[MCTEvent alloc] init]; event7.objectID = 7;	event7.name = @"Coffee-Break w/ Kate";	event7.details = @"Its Monday and we're all still wishing it was the weekend, so take a break from work and join me for some morning pastries and coffee at Zest Bakery. Their stuff is dariy free, gluten free and 100% delicious :D";	event7.date = [MCTUtils dateWithYear:2016 month:12 day:13 hour:10 minute:0];	event7.admin = _users[5];	event7.isGoing = NO;	event7.capacity = 9;	event7.restaurant = _restaurants[35];	event7.dietTags = @[_dietTags[3], _dietTags[6], _dietTags[7]];	event7.guests = [[NSMutableArray alloc] initWithArray: @[_users[5], _users[8], _users[9]]];	[_events addObject:event7];
    MCTEvent *event8= [[MCTEvent alloc] init]; event8.objectID = 8;	event8.name = @"No Eggs, No Problem";	event8.details = @"To all my egg free Italians. Are you looking for the perfect eggless and authentic pasta dishes, well come dine with me at Il Fornaio - it's pasta just like my Grandma used to make (minus the eggs)!";	event8.date = [MCTUtils dateWithYear:2016 month:12 day:16 hour:19 minute:00];	event8.admin = _users[26];	event8.isGoing = NO;	event8.capacity = 5;	event8.restaurant = _restaurants[37];	event8.dietTags = @[_dietTags[4], _dietTags[6]];	event8.guests = [[NSMutableArray alloc] initWithArray: @[_users[26]]];	[_events addObject:event8];
    MCTEvent *event9= [[MCTEvent alloc] init]; event9.objectID = 9;	event9.name = @"Vegan Juice Party";	event9.details = @"It may be Thursday, but who cares! Come celebrate the weekend early and see how Brazil does gluten free.";	event9.date = [MCTUtils dateWithYear:2016 month:12 day:16 hour:18 minute:0];	event9.admin = _users[85];	event9.isGoing = NO;	event9.capacity = 11;	event9.restaurant = _restaurants[40];	event9.dietTags = @[_dietTags[2], _dietTags[3]];	event9.guests = [[NSMutableArray alloc] initWithArray: @[_users[85], _users[84], _users[86]]];	[_events addObject:event9];
    MCTEvent *event10= [[MCTEvent alloc] init]; event10.objectID = 10;	event10.name = @"Hump Day Happy Hour";	event10.details = @"Any one else feeling a little slow and in a rut on hump day? Mix it up and come out to happy hour at Sam's - the fish place where you eat a totaly SHELLFISH FREE meal.";	event10.date = [MCTUtils dateWithYear:2016 month:12 day:13 hour:17 minute:30];	event10.admin = _users[47];	event10.isGoing = NO;	event10.capacity = 9;	event10.restaurant = _restaurants[36];	event10.dietTags = @[_dietTags[3], _dietTags[7]];	event10.guests = [[NSMutableArray alloc] initWithArray: @[_users[47], _users[51]]];	[_events addObject:event10];
    MCTEvent *event11= [[MCTEvent alloc] init]; event11.objectID = 11;	event11.name = @"Bowling for Breakfast";	event11.details = @"Hey hey early birds. If you like bowls and breakfast, come meet some fellow dairy free friends and join our pre-work breakfast hangout at the best smoothie/acai bowl/juice bar/whaterever you want to call it place in town!";	event11.date = [MCTUtils dateWithYear:2016 month:12 day:14 hour:19 minute:30];	event11.admin = _users[79];	event11.isGoing = NO;	event11.capacity = 7;	event11.restaurant = _restaurants[31];	event11.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	event11.guests = [[NSMutableArray alloc] initWithArray: @[_users[79]]];	[_events addObject:event11];
    MCTEvent *event12= [[MCTEvent alloc] init]; event12.objectID = 12;	event12.name = @"Mo Meat, Mo Problems";	event12.details = @"Love Indian food? Don't love meat? Love any excuse to leave the office on a Monday? Well so do we so hurry up now and RSVP.";	event12.date = [MCTUtils dateWithYear:2016 month:12 day:13 hour:12 minute:00];	event12.admin = _users[49];	event12.isGoing = NO;	event12.capacity = 6;	event12.restaurant = _restaurants[16];	event12.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	event12.guests = [[NSMutableArray alloc] initWithArray: @[_users[49], _users[48]]];	[_events addObject:event12];
    MCTEvent *event13= [[MCTEvent alloc] init]; event13.objectID = 13;	event13.name = @"Not About the Nuts";	event13.details = @"Fellow foodies with nut allergies, if you're like me and all about food, but not about the nuts, come check out Lyfe Kitchen with me! This place is great - they know exactly what goes into every dish and super careful not to cross-contaminate. This will be my third time back in 2 weeks (unless I can't resist the gourmet goodness and return between now and then haha).";	event13.date = [MCTUtils dateWithYear:2016 month:12 day:15 hour:8 minute:30];	event13.admin = _users[46];	event13.isGoing = NO;	event13.capacity = 7;	event13.restaurant = _restaurants[4];	event13.dietTags = @[_dietTags[1], _dietTags[6], _dietTags[7]];	event13.guests = [[NSMutableArray alloc] initWithArray: @[_users[46], _users[47], _users[67]]];	[_events addObject:event13];
    MCTEvent *event14= [[MCTEvent alloc] init]; event14.objectID = 14;	event14.name = @"Soy What?";	event14.details = @"Do you love food, but can't eat soy? Well me too and I'd love to meetchew for lunch at the Loving Hut :)";	event14.date = [MCTUtils dateWithYear:2016 month:12 day:13 hour:12 minute:30];	event14.admin = _users[75];	event14.isGoing = NO;	event14.capacity = 5;	event14.restaurant = _restaurants[45];	event14.dietTags = @[_dietTags[0], _dietTags[1], _dietTags[2], _dietTags[7]];	event14.guests = [[NSMutableArray alloc] initWithArray: @[_users[75]]];	[_events addObject:event14];
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

-(void) addNewEvent:(MCTEvent *)event {
    [_events addObject:event];
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

- (NSArray *) searchDietTagsBySearchText: (NSString *) text {
    NSMutableArray *dietTags = [NSMutableArray new];
    if ([text isEqualToString:@""]) {
        return _dietTags;
    } else {
        for (MCTDietTag *dietTag in _dietTags) {
            if ([[dietTag.name lowercaseString] containsString:[text lowercaseString]]) {
                [dietTags addObject:dietTag];
            }
        }
    }
    return dietTags;
}

- (NSArray *) getAllEvents {
    return _events;
}

- (NSArray *) getAllRestaurants {
    return _restaurants;
}

- (NSArray *) getAllRestaurantsByRating {
    NSArray *sortedArray;
    sortedArray = [_restaurants sortedArrayUsingComparator:^NSComparisonResult(MCTRestaurant *rest1, MCTRestaurant *rest2) {
        NSNumber *first = [NSNumber numberWithDouble: [rest1 overallRating]];
        NSNumber *second = [NSNumber numberWithDouble: [rest2 overallRating]];
        return [second compare:first];
    }];
    return sortedArray;
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

- (void) searchRestaurantsBySearchText: (NSString *) text {
    if ([text isEqualToString:@""]) {
        _restaurants = _allRestaurants;
    } else {
        _restaurants = [[NSMutableArray alloc] init];
        for (MCTRestaurant *restaurant in _allRestaurants) {
            if ([[restaurant.name lowercaseString] containsString:[text lowercaseString]]) {
                [_restaurants addObject:restaurant];
            }
        }
    }
}

-(NSArray *) getEventsForPrice: (NSNumber *) price beforeDate: (NSString *) dateString withinDistanceMiles: (NSNumber *) miles forTimeOfDay: (NSString *) timeOfDayString {
    NSMutableArray *events = [NSMutableArray new];
    for (MCTEvent *event in _events) {
        CLLocationDistance distance = [event.restaurant.location distanceFromLocation: _locationManager.location];
        if (([price integerValue] != event.restaurant.price && [price integerValue] != 0) || (distance/1607.0 > [miles doubleValue] && [miles integerValue] != 0)) {
            continue;
        }
        NSInteger hour = [MCTUtils getHourForDate:event.date];
        if ((hour > 12 && [timeOfDayString.lowercaseString isEqualToString:@"morning"])
            || ((hour > 17 || hour <= 12) && [timeOfDayString.lowercaseString isEqualToString:@"afternoon"])
            || (hour <= 17 && [timeOfDayString.lowercaseString isEqualToString:@"evening"])) {
            continue;
        }
        [events addObject:event];
    }
    return events;
}

-(void) attendEvent: (MCTEvent *)event {
    [_attendingEvents addObject:event];
}

-(void) unattendEvent: (MCTEvent *)event {
    [_attendingEvents removeObject:event];
}

-(NSArray *) getUserUpcomingEvents {
    NSMutableArray *events = [NSMutableArray new];
    for (MCTEvent *event in _attendingEvents) {
        if ([event.date timeIntervalSinceDate:[NSDate date]] >= 0) {
            [events addObject:event];
        }
    }
    return events;
}

-(NSArray *)getUserPastEvents {
    NSMutableArray *events = [NSMutableArray new];
    for (MCTEvent *event in _events) {
        if ([event.date timeIntervalSinceDate:[NSDate date]] < 0) {
            [events addObject:event];
        }
    }
    return events;
}

-(NSArray *)getUserHostingEvents {
    NSMutableArray *events = [NSMutableArray new];
    for (MCTEvent *event in _events) {
        if ([event.admin isEqual:_user]) {
            [events addObject:event];
        }
    }
    return events;
}

#pragma Location Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

}

@end
