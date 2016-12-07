//
//  MCTUtils.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTUtils.h"
#import <ChameleonFramework/Chameleon.h>

@implementation MCTUtils

+(UIColor *)defaultBarColor {
    return [UIColor colorWithRed:(0.0f/256.f)
                          green:(112.0f/256.f)
                           blue:(220.0f/256.f)
                          alpha:(1.0f)];
}

+(UIColor *)MCTLightGrayColor {
    return [UIColor colorWithRed:(172.0f/256.f)
                           green:(184.0f/256.f)
                            blue:(193.0f/256.f)
                           alpha:(1.0f)];
}

+(UIColor *)gradientBackgroundColorWithFrame: (CGRect) frame {
    UIColor *color1 = [UIColor colorWithRed:(15.0f/256.f)
                                      green:(141.0f/256.f)
                                       blue:(232.0f/256.f)
                                      alpha:(1.0f)];
    UIColor *color2 = [UIColor colorWithRed:(32.0f/256.f)
                                      green:(174.0f/256.f)
                                       blue:(245.0f/256.f)
                                      alpha:(1.0f)];
    UIColor *color3 = [UIColor colorWithRed:(110.0f/256.f)
                                      green:(214.0f/256.f)
                                       blue:(255.0f/256.f)
                                      alpha:(1.0f)];
    NSArray *colors = @[[self defaultBarColor], color1, color2, color3];
    return GradientColor(UIGradientStyleTopToBottom, frame, colors);
}

+(NSString *) priceStringForRestaurant: (MCTRestaurant *) restaurant {
    int price = (int)restaurant.price;
    NSMutableString *str = [[NSMutableString alloc] initWithString: @""];
    for (int i = 0; i < price; i++) {
        [str appendString:@"$"];
    }
    return str;
}

+(NSString *) dietTagsListtoString: (NSArray <MCTDietTag *> * ) tags {
    NSMutableString * str = [[NSMutableString alloc] initWithString: @""];
    for (int i = 0; i < tags.count; i++) {
        [str appendString: tags[i].name];
        if (i != tags.count-1) {
             [str appendString: @", "];
        }
    }
    return str;
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    return [calendar dateFromComponents:components];
}

+ (NSInteger) getMonthForDate: (NSDate *)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitMonth fromDate:date];
    
    return [components month];
}

+ (NSInteger) getHourForDate: (NSDate *)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitHour fromDate:date];
    
    return [components hour];
}

+ (NSInteger) getMinuteForDate: (NSDate *)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitMinute fromDate:date];
    
    return [components minute];
}

+ (NSInteger) getDayForDate: (NSDate *)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitDay fromDate:date];
    
    return [components day];
}

+ (NSInteger) getYearForDate: (NSDate *)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:date];
    
    return [components year];
}

+ (NSString *) getMonthStringForDate: (NSDate *)date {
    if ([self getMonthForDate:date] == 1) {
        return @"January";
    } else if ([self getMonthForDate:date] == 2) {
        return @"February";
    } else if ([self getMonthForDate:date] == 3) {
        return @"March";
    } else if ([self getMonthForDate:date] == 4) {
        return @"April";
    } else if ([self getMonthForDate:date] == 5) {
        return @"May";
    } else if ([self getMonthForDate:date] == 6) {
        return @"June";
    } else if ([self getMonthForDate:date] == 7) {
        return @"July";
    } else if ([self getMonthForDate:date] == 8) {
        return @"August";
    } else if ([self getMonthForDate:date] == 9) {
        return @"September";
    } else if ([self getMonthForDate:date] == 10) {
        return @"October";
    } else if ([self getMonthForDate:date] == 11) {
        return @"November";
    } else if ([self getMonthForDate:date] == 12) {
        return @"December";
    }
    return @"";
}

@end
