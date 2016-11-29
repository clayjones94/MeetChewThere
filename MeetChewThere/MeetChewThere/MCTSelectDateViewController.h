//
//  MCTSelectDateViewController.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/18/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTEvent.h"
#import "RSDFDatePickerView.h"

@interface MCTSelectDateViewController : UIViewController<RSDFDatePickerViewDelegate, RSDFDatePickerViewDataSource>

@property (strong, nonatomic) MCTEvent *event;

@end
