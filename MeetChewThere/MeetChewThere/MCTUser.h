//
//  MCTUser.h
//  MeetChewThere
//
//  Created by Clay Jones on 11/4/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCTDietTag.h"

@interface MCTUser : NSObject

@property (nonatomic) NSInteger objectID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (strong, nonatomic) NSArray *dietTags;
@property (strong, nonatomic) NSString *imageName;

@end
