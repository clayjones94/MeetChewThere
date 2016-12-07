//
//  MCTProfileViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 12/6/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTProfileViewController.h"
#import "Masonry.h"
#import "MCTContentManager.h"
#import "MCTEventTableViewCell.h"
#import "MCTEvent.h"
#import "MCTEventDetailViewController.h"
#import "MCTConstants.h"
#import "MCTUtils.h"
#import <ChameleonFramework/Chameleon.h>
#import "MCTRegisterViewController.h"
#import "MCTRegisterPickDietViewController.h"
#import "MCTProfileEventsViewController.h"

@implementation MCTProfileViewController {
    UITableView *_dietTagTableView;
    UILabel *nameLabel;
    UILabel *dietLabel;
    UILabel *eventCountLabel;
    UILabel *_reviewCountLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:YES];
    [self layoutViews];
}

-(void)viewWillAppear:(BOOL)animated {
    [nameLabel setText:[MCTContentManager sharedManager].user.name];
    [nameLabel sizeToFit];
    
    [dietLabel setText: [MCTUtils dietTagsListtoString:[MCTContentManager sharedManager].user.dietTags]];
    
    [eventCountLabel setText:[NSString stringWithFormat:@"%lu",(unsigned long)[MCTContentManager sharedManager].getUserHostingEvents.count]];
    [eventCountLabel sizeToFit];
    
    [_reviewCountLabel setText:[NSString stringWithFormat:@"%lu",(unsigned long)[MCTContentManager sharedManager].getReviewsForUser.count]];
    [_reviewCountLabel sizeToFit];
}

-(void) layoutViews {
    UIView *upperView = [[UIView alloc] init];
    UIColor *gradientColor = [MCTUtils MCTBarBackgroundColorForFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * .6)];
    [upperView setBackgroundColor:gradientColor];
    [self.view addSubview:upperView];
    
    [upperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(self.view.frame.size.height * .6);
    }];
    
    UIImageView *profileImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile"]];
    [profileImage sizeToFit];
    [profileImage.layer setCornerRadius:50];
    [profileImage.layer setBorderColor:[UIColor whiteColor].CGColor];
    [profileImage.layer setBorderWidth:5];
    [profileImage setBackgroundColor:[UIColor grayColor]];
    [profileImage setContentMode:UIViewContentModeScaleAspectFill];
    [profileImage setClipsToBounds:YES];
    
    [upperView addSubview:profileImage];
    [profileImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(upperView);
        make.centerY.equalTo(upperView).with.offset(-50);
        make.width.height.mas_equalTo(100);
    }];
    
    nameLabel = [[UILabel alloc] init];
    [upperView addSubview:nameLabel];
    [nameLabel setText:[MCTContentManager sharedManager].user.name];
    [nameLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:24]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel sizeToFit];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileImage.mas_bottom).with.offset(10);
        make.centerX.equalTo(profileImage);
    }];
    
    dietLabel = [[UILabel alloc] init];
    [upperView addSubview:dietLabel];
    [dietLabel setText: [MCTUtils dietTagsListtoString:[MCTContentManager sharedManager].user.dietTags]];
    [dietLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:14]];
    [dietLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [dietLabel setTextAlignment:NSTextAlignmentCenter];
    [dietLabel setTextColor:[UIColor whiteColor]];
    [dietLabel sizeToFit];
    
    [dietLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(-3);
        make.centerX.equalTo(nameLabel);
        make.width.mas_equalTo(280);
    }];
    
    UIView *labelView = [[UIView alloc] init];
    [labelView setBackgroundColor:[UIColor whiteColor]];
    [labelView setAlpha:0.5f];
    [upperView addSubview:labelView];
    
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(upperView);
        make.height.mas_equalTo(90);
    }];
    
    eventCountLabel = [[UILabel alloc] init];
    [upperView addSubview:eventCountLabel];
    [eventCountLabel setText:[NSString stringWithFormat:@"%lu",(unsigned long)[MCTContentManager sharedManager].getUserHostingEvents.count]];
    [eventCountLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:50]];
    [eventCountLabel setTextColor:[UIColor whiteColor]];
    [eventCountLabel sizeToFit];
    
    [eventCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(labelView.mas_centerY).with.offset(25);
        make.centerX.equalTo(labelView).with.offset(-self.view.frame.size.width * 1/4);
    }];
    
    UILabel *eventDetailLabel = [[UILabel alloc] init];
    [upperView addSubview:eventDetailLabel];
    [eventDetailLabel setText:@"Events"];
    [eventDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:14]];
    [eventDetailLabel setTextColor:[UIColor whiteColor]];
    [eventDetailLabel sizeToFit];
    
    [eventDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(eventCountLabel.mas_bottom).with.offset(-10);
        make.centerX.equalTo(eventCountLabel);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvents)];
    tap.numberOfTapsRequired = 1;
    UIView *tapView = [[UIView alloc] init];
    [labelView addSubview:tapView];
    [tapView addGestureRecognizer:tap];
    [tapView setUserInteractionEnabled:YES];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(labelView);
        make.right.equalTo(labelView.mas_centerX);
    }];
    
    _reviewCountLabel = [[UILabel alloc] init];
    [upperView addSubview:_reviewCountLabel];
    [_reviewCountLabel setText:@"0"];
    [_reviewCountLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:50]];
    [_reviewCountLabel setTextColor:[UIColor whiteColor]];
    [_reviewCountLabel sizeToFit];
    
    [_reviewCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(labelView.mas_centerY).with.offset(25);
        make.centerX.equalTo(labelView).with.offset(self.view.frame.size.width * 1/4);
    }];
    
    UILabel *reviewDetailLabel = [[UILabel alloc] init];
    [upperView addSubview:reviewDetailLabel];
    [reviewDetailLabel setText:@"Reviews"];
    [reviewDetailLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:14]];
    [reviewDetailLabel setTextColor:[UIColor whiteColor]];
    [reviewDetailLabel sizeToFit];
    
    [reviewDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_reviewCountLabel.mas_bottom).with.offset(-10);
        make.centerX.equalTo(_reviewCountLabel);
    }];
    
    UIView *separator = [UIView new];
    [separator setBackgroundColor:[UIColor whiteColor]];
    [upperView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(labelView);
        make.width.mas_equalTo(1.f);
        make.height.mas_equalTo(40.f);
    }];
    
    UIButton *editDietButton = [[UIButton alloc] init];
    [self.view addSubview:editDietButton];
    [editDietButton setTitle:@"Edit Diet" forState:UIControlStateNormal];
    [editDietButton setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:18]];
    [editDietButton setBackgroundColor:[UIColor clearColor]];
    [editDietButton addTarget:self action:@selector(editDiet) forControlEvents:UIControlEventTouchUpInside];
    [editDietButton setTitleColor:[MCTUtils defaultBarColor] forState:UIControlStateNormal];
    
    [editDietButton sizeToFit];
    
    [editDietButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upperView.mas_bottom).with.offset(22);
        make.centerX.equalTo(upperView);
    }];
    
    separator = [UIView new];
    [separator setBackgroundColor:[MCTUtils MCTLightGrayColor]];
    [self.view addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(editDietButton.mas_bottom).with.offset(22);
        make.height.mas_equalTo(1.f);
        make.width.mas_equalTo(100.f);
    }];
    
    UIButton *logoutButton = [[UIButton alloc] init];
    [self.view addSubview:logoutButton];
    [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [logoutButton setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:18]];
    [logoutButton setBackgroundColor:[UIColor clearColor]];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logoutButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [logoutButton sizeToFit];
    
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separator.mas_bottom).with.offset(22);
        make.centerX.equalTo(upperView);
    }];
}

-(void)tapEvents {
    MCTProfileEventsViewController *vc = [((UINavigationController *)[self.navigationController.tabBarController.viewControllers objectAtIndex:2]).viewControllers objectAtIndex:0];
    [vc setToHosted];
    [self.navigationController.tabBarController setSelectedIndex:2];
}

-(void) logout {
    [MCTContentManager sharedManager].user = nil;
    if (![MCTContentManager sharedManager].user) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[MCTRegisterViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(void) editDiet {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[MCTRegisterPickDietViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
