//
//  MCTSelectRestaurantViewController.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/20/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTEvent.h"
#import "ZLDropDownMenu.h"

@interface MCTSelectRestaurantViewController : UIViewController <ZLDropDownMenuDataSource, ZLDropDownMenuDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) MCTEvent *event;

@end
