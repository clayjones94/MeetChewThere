//
//  MCTAddEventDetailsViewController.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/18/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTEvent.h"

@interface MCTAddEventDetailsViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) MCTEvent *event;

@end
