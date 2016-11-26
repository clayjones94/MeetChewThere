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
    MCTUser *user = [[MCTUser alloc] init];
    user.objectID = 0;
    user.name = @"Clay Jones";
    user.imageName = @"clay_prof";
    user.dietTags = @[_dietTags[0], _dietTags[1]];
    [_users addObject:user];
}

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
    _events = [[NSMutableArray<MCTEvent *> alloc] init];
    MCTEvent *event1 = [[MCTEvent alloc] init];
    event1.objectID = 1;
    event1.name = @"Sandwich Party";
    event1.details = @"The best party in town!";
    event1.date = [NSDate date];
    event1.admin = _users[0];
    event1.isGoing = NO;
    event1.capacity = 15;
    event1.restaurant = _restaurants[2];
    event1.dietTags = @[_dietTags[1]];
    event1.guests = [[NSMutableArray alloc] initWithArray: @[_users[0]]];
    [_events addObject:event1];
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

- (NSArray *) getAllEventsByAnytime1 {
    return _events;
}

- (NSArray *) getAllEventsByToday {
    return _events;
}

- (NSArray *) getAllEventsByThisWeek {
    return _events;
}

- (NSArray *) getAllEventsByNextWeek {
    return _events;
}

- (NSArray *) getAllEventsByAnytime2 {
    return _events;
}

- (NSArray *) getAllEventsByMorning {
    return _events;
}

- (NSArray *) getAllEventsByAfternoon {
    return _events;
}

- (NSArray *) getAllEventsByEvening {
    return _events;
}

- (NSArray *) getAllEventsByDistance1 {
    NSMutableArray<MCTEvent *> *_events1 = [[NSMutableArray<MCTEvent *> alloc] init];
    for (int i = 0; i < _events.count; i++) {
        CLLocationDistance distance = [_events[i].restaurant.location distanceFromLocation: _locationManager.location];
        if (distance/1607.0 <= 1) {
            [_events1 addObject:_events[i]];
        }
    }
    return _events1;
}

- (NSArray *) getAllEventsByDistance50 {
    NSMutableArray<MCTEvent *> *_events1 = [[NSMutableArray<MCTEvent *> alloc] init];
    for (int i = 0; i < _events.count; i++) {
        CLLocationDistance distance = [_events[i].restaurant.location distanceFromLocation: _locationManager.location];
        if (distance/1607.0 <= 50) {
            [_events1 addObject:_events[i]];
        }
    }
    return _events1;
}

- (NSArray *) getAllEventsByDistance10 {
    NSMutableArray<MCTEvent *> *_events1 = [[NSMutableArray<MCTEvent *> alloc] init];
    for (int i = 0; i < _events.count; i++) {
        CLLocationDistance distance = [_events[i].restaurant.location distanceFromLocation: _locationManager.location];
        if (distance/1607.0 <= 10) {
            [_events1 addObject:_events[i]];
        }
    }
    return _events1;
}

- (NSArray *) getAllEventsByDistance25 {
    NSMutableArray<MCTEvent *> *_events1 = [[NSMutableArray<MCTEvent *> alloc] init];
    for (int i = 0; i < _events.count; i++) {
        CLLocationDistance distance = [_events[i].restaurant.location distanceFromLocation: _locationManager.location];
        if (distance/1607.0 <= 25) {
            [_events1 addObject:_events[i]];
        }
    }
    return _events1;
}

- (NSArray *) getAllEventsByPriceAny {
    return _events;
}

- (NSArray *) getAllEventsByPrice1 {
    NSMutableArray<MCTEvent *> *_events1 = [[NSMutableArray<MCTEvent *> alloc] init];
    for (int i = 0; i < _events.count; i++) {
        if (_events[i].restaurant.price == 1) {
            [_events1 addObject:_events[i]];
        }
    }
    return _events1;
}

- (NSArray *) getAllEventsByPrice2 {
    NSMutableArray<MCTEvent *> *_events1 = [[NSMutableArray<MCTEvent *> alloc] init];
    for (int i = 0; i < _events.count; i++) {
        if (_events[i].restaurant.price == 2) {
            [_events1 addObject:_events[i]];
        }
    }
    return _events1;
}

- (NSArray *) getAllEventsByPrice3 {
    NSMutableArray<MCTEvent *> *_events1 = [[NSMutableArray<MCTEvent *> alloc] init];
    for (int i = 0; i < _events.count; i++) {
        if (_events[i].restaurant.price == 3) {
            [_events1 addObject:_events[i]];
        }
    }
    return _events1;
}

#pragma Location Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

}

@end
