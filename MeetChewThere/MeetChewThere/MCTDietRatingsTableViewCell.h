//
//  MCTDietRatingsTableViewCell.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/11/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTDietTag.h"
#import "MCTRestaurant.h"

@interface MCTDietRatingsTableViewCell : UITableViewCell

@property (weak, nonatomic) MCTDietTag *dietTag;
@property (weak, nonatomic) MCTRestaurant *restaurant;

@end
