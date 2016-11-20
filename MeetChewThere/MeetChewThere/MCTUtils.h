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
+(UIColor *) gradientBackgroundColorWithFrame: (CGRect) frame;
+(NSString *) priceStringForRestaurant: (MCTRestaurant *) restaurant;
+(NSString *) dietTagsListtoString: (NSArray <MCTDietTag *> * ) tags;


@end
