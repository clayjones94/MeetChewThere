//
//  MCTReviewsViewController.h
//  MeetChewThere
//
//  Created by Clay Jones on 12/7/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTDietTag.h"

@interface MCTReviewsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) MCTDietTag *dietTag;

@end
