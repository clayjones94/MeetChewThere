//
//  MCTRestaurantDetailViewController.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/5/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTRestaurant.h"

@interface MCTRestaurantDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) MCTRestaurant *restaurant;

@end
