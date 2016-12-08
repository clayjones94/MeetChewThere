//
//  MCTGuestsViewController.h
//  MeetChewThere
//
//  Created by Clay Jones on 12/7/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTUser.h"
#import <STPopup/STPopup.h>

@interface MCTGuestsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSArray<MCTUser *> *guests;

@end
