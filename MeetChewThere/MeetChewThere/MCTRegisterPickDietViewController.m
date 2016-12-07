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
#import <POP.h>

@implementation MCTRegisterPickDietViewController {
    UITableView *_tableView;
    
    NSArray<MCTDietTag *> *_dietTags;
    NSMutableArray<MCTDietTag *> *_selectedTags;
    
    UITextField *_searchBar;
    
    MCTContentManager *_contentManager;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finish)];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title = @"Diet Preferences";
    
    _contentManager = [MCTContentManager sharedManager];
    _selectedTags = [NSMutableArray new];
    
    _dietTags = [_contentManager getAllDietTags];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setThemeUsingPrimaryColor:[UIColor whiteColor] withSecondaryColor:[MCTUtils defaultBarColor] andContentStyle:UIContentStyleLight];
    
    [self layoutViews];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}

-(void) layoutViews {
    _searchBar = [[UITextField alloc] init];
    UIView *leftView = [[UIView alloc] init];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
    [icon sizeToFit];
    [leftView setFrame:CGRectMake(0, 0, icon.frame.size.width + 10, icon.frame.size.height)];
    [icon setFrame:CGRectMake(0, 0, icon.frame.size.width, icon.frame.size.height)];
    [leftView addSubview:icon];
    
    [_searchBar setLeftView:leftView];
    [_searchBar setLeftViewMode:UITextFieldViewModeUnlessEditing];
    _searchBar.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    [_searchBar setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:18]];
    [_searchBar setPlaceholder:@"Search"];
    [_searchBar setReturnKeyType:UIReturnKeySearch];
    [_searchBar setDelegate:self];
    [self.view addSubview:_searchBar];
    
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UIView * bottomSeparator = [[UIView alloc] init];
    [bottomSeparator setBackgroundColor:[MCTUtils MCTLightGrayColor]];
    [self.view addSubview:bottomSeparator];
    
    [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_searchBar);
        make.height.mas_equalTo(.5);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_searchBar.mas_bottom);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"diet tag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.tintColor = [MCTUtils defaultBarColor];
        [cell.textLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:14]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    MCTDietTag *tag = _dietTags[indexPath.row];
    cell.textLabel.text = tag.name;
    if([_selectedTags containsObject:tag]){
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete_diet_minus"]];
    } else {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_diet_plus"]];
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
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
    springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    springAnimation.springBounciness = 20.f;
    [cell.accessoryView pop_addAnimation:springAnimation forKey:@"springAnimation"];
    [springAnimation setAnimationDidReachToValueBlock:^(POPAnimation * animation) {
        if([_selectedTags containsObject:_dietTags[indexPath.row]]){
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete_diet_minus"]];
        } else {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_diet_plus"]];
        }
    }];
}

-(void) finish {
    _contentManager.user.dietTags = _selectedTags;
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma text field

-(BOOL)textFieldShouldBeginEditing:(UITextView *)textView {
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextView *)textView {
    [_searchBar resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_searchBar resignFirstResponder];
    NSString *searchText = textField.text;
    _dietTags = [_contentManager searchDietTagsBySearchText:searchText];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    _dietTags = [_contentManager searchDietTagsBySearchText:searchText];
    [_tableView reloadData];
    return YES;
}

@end
