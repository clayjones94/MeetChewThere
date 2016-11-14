//
//  MCTRegisterPickDietViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 11/13/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTRegisterPickDietViewController.h"
#import "MCTContentManager.h"
#import "MCTUtils.h"
#import <ChameleonFramework/Chameleon.h>
#import "Masonry.h"
#import "MCTDietTag.h"
#import "MCTConstants.h"

@implementation MCTRegisterPickDietViewController {
    UITableView *_tableView;
    
    NSArray<MCTDietTag *> *_dietTags;
    NSMutableArray<MCTDietTag *> *_selectedTags;
    
    MCTContentManager *_contentManager;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finish)];
    
    _contentManager = [MCTContentManager sharedManager];
    _selectedTags = [NSMutableArray new];
    
    _dietTags = [_contentManager getAllDietTags];
    [self.view setBackgroundColor:[MCTUtils defaultBarColor]];
    [self setThemeUsingPrimaryColor:[UIColor whiteColor] withSecondaryColor:[MCTUtils defaultBarColor] andContentStyle:UIContentStyleLight];
    
    [self layoutViews];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}

-(void) layoutViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"diet tag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.tintColor = [UIColor whiteColor];
        [cell.textLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:14]];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    MCTDietTag *tag = _dietTags[indexPath.row];
    cell.textLabel.text = tag.name;
    if([_selectedTags containsObject:tag]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dietTags.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    if ([_selectedTags containsObject:_dietTags[indexPath.row]]) {
        [_selectedTags removeObject:_dietTags[indexPath.row]];
    } else {
        [_selectedTags addObject:_dietTags[indexPath.row]];
    }
    [tableView reloadData];
}

-(void) finish {
    _contentManager.user.dietTags = _selectedTags;
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
