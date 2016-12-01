//
//  MCTRestaurant.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MCTDietTag.h"

@interface MCTRestaurant : NSObject

@property (nonatomic) NSInteger objectID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSString *imageName;
@property (nonatomic) NSInteger price;
@property (nonatomic) double overallRating;
@property (strong, nonatomic) NSArray<MCTDietTag *> *dietTags;

@end
