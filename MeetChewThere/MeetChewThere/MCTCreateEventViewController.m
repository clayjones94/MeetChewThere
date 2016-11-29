//
//  MCTCreateEventViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTCreateEventViewController.h"
#import "Masonry.h"
#import "MCTSelectDateViewController.h"

@implementation MCTCreateEventViewController {
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[MCTSelectDateViewController new]];
    [self presentViewController:nav animated:NO completion:nil];
}

-(void) layoutViews {
    
}

@end
