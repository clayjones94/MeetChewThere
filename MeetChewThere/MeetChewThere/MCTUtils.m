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

@end
