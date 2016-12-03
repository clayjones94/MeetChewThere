//
//  MCTDiscoverViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTDiscoverViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "MCTDiscoverEventsViewController.h"
#import "MCTDiscoverRestaurantsViewController.h"
#import "MCTUtils.h"
#import "MCTConstants.h"
#import "MCTContentManager.h"
#import "MCTRegisterViewController.h"
#import "MCTRegisterViewController.h"

@implementation MCTDiscoverViewController {

    UIView *_topBar;
    HMSegmentedControl *_segControl;
    MCTListType _type;
    MCTDiscoverEventsViewController *_eventsVC;
    MCTDiscoverRestaurantsViewController *_restaurantsVC;
    UIViewController *_currentVC;
        
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self setExtendedLayoutIncludesOpaqueBars:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (![MCTContentManager sharedManager].user) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[MCTRegisterViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }
//    if (![MCTContentManager sharedManager].user) {
//        MCTUser *user = [MCTUser new];
//        user.name = @"Clayy";
//        user.password = @"pass";
//        [MCTContentManager sharedManager].user = user;
//    }
}

- (void)viewDidLoad {
    [self.view setBackgroundColor:[UIColor whiteColor]];

    _type = RESTAURANTS;
    [self layoutSegmentedControl];
    [self initControllers];
    [self displayController];
}

-(void) layoutSegmentedControl {
    _topBar = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)];
    [_topBar setBackgroundColor:[MCTUtils defaultBarColor]];
    [self.view addSubview:_topBar];
    
    _segControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Restaurants",@"Events"]];
    [_segControl setBackgroundColor:[UIColor clearColor]];
    [_segControl addTarget:self action:@selector(segmentedControlChangedValue) forControlEvents:UIControlEventValueChanged];
    NSDictionary *titleTextAttr = @{
                                    NSFontAttributeName:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:15],
                                    NSForegroundColorAttributeName: [UIColor whiteColor]
                                    };
    NSDictionary *selectedTitleTextAttr = @{
                                            NSFontAttributeName:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:15],
                                            NSForegroundColorAttributeName:[UIColor whiteColor]
                                            };
    
    _segControl.titleTextAttributes = titleTextAttr;
    _segControl.selectedTitleTextAttributes = selectedTitleTextAttr;
    _segControl.selectionIndicatorColor = [UIColor whiteColor];
    _segControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segControl.selectionIndicatorHeight = 3.0f;
    _segControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, -2, 0);
    _segControl.borderType = HMSegmentedControlBorderTypeBottom;
    _segControl.borderWidth = 0.0f;
    _segControl.borderColor = [UIColor clearColor];
    [_segControl setFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, _topBar.frame.size.width, _topBar.frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height)];
    [_topBar addSubview:_segControl];
}

-(void) segmentedControlChangedValue {
    if (_segControl.selectedSegmentIndex == 0 && _type != RESTAURANTS) {
        _type = RESTAURANTS;
        [self displayController];
    } else if(_segControl.selectedSegmentIndex == 1 && _type != EVENTS) {
        _type = EVENTS;
        [self displayController];
    }
}

-(void) initControllers {
    _eventsVC = [MCTDiscoverEventsViewController new];
    _restaurantsVC = [MCTDiscoverRestaurantsViewController new];
}

-(void) displayController {
    if (_type == RESTAURANTS) {
        _currentVC = _restaurantsVC;
        [_eventsVC removeFromParentViewController];
    } else {
        _currentVC = _eventsVC;
        [_restaurantsVC removeFromParentViewController];
    }
    [_currentVC.view setFrame:CGRectMake(0, _topBar.frame.origin.y + _topBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - (_topBar.frame.origin.y + _topBar.frame.size.height))];
    [self addChildViewController:_currentVC];
    [self.view addSubview:_currentVC.view];
}


@end
