//
//  MCTUtils.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MCTRestaurant.h"

@interface MCTUtils : NSObject

+(UIColor *) defaultBarColor;
+(UIColor *)MCTLightGrayColor;
+(UIColor *) gradientBackgroundColorWithFrame: (CGRect) frame;
+(NSString *) priceStringForRestaurant: (MCTRestaurant *) restaurant;
+(NSString *) dietTagsListtoString: (NSArray <MCTDietTag *> * ) tags;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
+ (NSInteger) getMonthForDate: (NSDate *)date;
+ (NSInteger) getDayForDate: (NSDate *)date;
+ (NSInteger) getHourForDate: (NSDate *)date;
+ (NSInteger) getMinuteForDate: (NSDate *)date;
+ (NSInteger) getYearForDate: (NSDate *)date;
+ (NSString *) getMonthStringForDate: (NSDate *)date;

@end
