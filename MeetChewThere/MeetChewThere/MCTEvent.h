//
//  MCTEvent.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCTRestaurant.h"
#import "MCTUser.h"
#import "MCTDietTag.h"

@interface MCTEvent : NSObject

@property (nonatomic) NSInteger objectID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) MCTUser *admin;
@property (nonatomic) BOOL isGoing;
@property (nonatomic) NSInteger capacity;
@property (strong, nonatomic) MCTRestaurant *restaurant;
@property (strong, nonatomic) NSArray<MCTDietTag *> *dietTags;
@property (strong, nonatomic) NSMutableArray<MCTUser *> *guests;

@end
