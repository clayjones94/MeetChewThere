//
//  MCTReviewsViewController.m
//  MeetChewThere
//
//  Created by Clay Jones on 12/7/16.
//  Copyright © 2016 CS147Group. All rights reserved.
//

#import "MCTReviewsViewController.h"
#import "MCTContentManager.h"
#import "MCTUtils.h"
#import <ChameleonFramework/Chameleon.h>
#import "MCTReviewTableViewCell.h"
#import "Masonry.h"
#import "MCTDietTag.h"
#import "MCTRestaurantReview.h"
#import "MCTConstants.h"
#import <POP.h>

@implementation MCTReviewsViewController {
    UITableView *_tableView;
    
    NSArray<MCTRestaurantReview *> *_reviews;
    
    MCTContentManager *_contentManager;
}

@synthesize dietTag = _dietTag;

-(void)setDietTag:(MCTDietTag *)dietTag {
    _dietTag = dietTag;
    self.navigationItem.title = [NSString stringWithFormat:@"%@ Reviews", _dietTag.name];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ Reviews", _dietTag.name];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationController.navigationBar setOpaque:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[MCTUtils MCTBarBackgroundColorForFrame:CGRectMake(0, 0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height)]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    _contentManager = [MCTContentManager sharedManager];

    _reviews = [_contentManager getAllReviews];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //    [self setThemeUsingPrimaryColor:[UIColor whiteColor] withSecondaryColor:[MCTUtils defaultBarColor] andContentStyle:UIContentStyleLight];
    
    [self layoutViews];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}

-(void) layoutViews {

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"diet tag";
    MCTReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) {
        cell = [[MCTReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.tintColor = [MCTUtils defaultBarColor];
        [cell.textLabel setFont:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:14]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MCTRestaurantReview *tag = _reviews[indexPath.row];
    cell.review = tag;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _reviews.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25 + [self getLabelHeight:[_reviews objectAtIndex:indexPath.row].reviewString];
}

- (CGFloat)getLabelHeight:(NSString *) str{
    CGSize constraint = CGSizeMake(self.view.frame.size.width * .8, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [str boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont fontWithName:MCT_REGULAR_FONT_NAME size:12]}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
}
@end
