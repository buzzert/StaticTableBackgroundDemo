//
//  StaticBackgroundScrollViewDemoViewController.m
//  StaticTableBackgroundDemo
//
//  This class serves as a proof of concept for a similar
//  implementation of Twitter for iPhone's "Sliding UITableView
//  Header Views" (referenced from chpwn's blog here <http://bit.ly/q4JLeS>)
//
//  Created by James Magahern on 7/17/11.
//  Copyright 2011 omegaHern. All rights reserved.
//

#import "StaticTableBackgroundDemoViewController.h"

static const CGSize  topAreaSize = { 320.0f, 100.0f };
static const CGFloat runoffSize  = 300.0f;

@implementation StaticTableBackgroundDemoViewController

- (UIButton*)_createTestButton {
    CGRect buttonFrame;
    buttonFrame.size = CGSizeMake(220.0f, 35.0f);
    buttonFrame.origin = CGPointMake((topAreaSize.width  / 2.0f) - (buttonFrame.size.width / 2.0f),
                                     (topAreaSize.height / 2.0f) - (buttonFrame.size.height / 2.0f));
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [testButton setTitle:@"Tap Me!" forState:UIControlStateNormal];
    [testButton setFrame:buttonFrame];
    
    return testButton;
}

- (UIView*)fauxBackgroundView {
    if (!_fauxBackgroundView) {
        [tableView layoutIfNeeded];
        
        CGRect bgFrame;
        bgFrame.origin = CGPointMake(0.0f, tableView.contentInset.top);
        bgFrame.size   = CGSizeMake(self.view.frame.size.width,
                                    tableView.contentSize.height + runoffSize);
        
        _fauxBackgroundView = [[UIView alloc] initWithFrame:bgFrame];
        _fauxBackgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIImageView *shadowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scrollView_Top.png"]];
        CGSize imageSize = [[shadowImage image] size];
        shadowImage.frame = CGRectMake(0.0f, -1 * imageSize.height, imageSize.width, imageSize.height);
        
        [_fauxBackgroundView addSubview:shadowImage];
        [_fauxBackgroundView setClipsToBounds:NO];
    }
    
    return _fauxBackgroundView;
}

- (UITableView*)tableView {
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        UIView *background = [[UIView alloc] initWithFrame:tableView.bounds];
        [background setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
        
        UIButton *testButton = [self _createTestButton];
        [background addSubview:testButton];
        
        [tableView setBackgroundView:background];
        
        [tableView setContentInset:UIEdgeInsetsMake(topAreaSize.height, 0.0f, 0.0f, 0.0f)];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        
        [background addSubview:[self fauxBackgroundView]];
    }
    
    return tableView;
}


- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add tableview, with appropriate contentInsets assigned
    [self.view addSubview:[self tableView]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TestCell";

    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }

    [[cell textLabel] setText:@"Here's a cell"];

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect backgroundFrame = [_fauxBackgroundView frame];
    backgroundFrame.origin.y = -scrollView.contentOffset.y;
    
    [_fauxBackgroundView setFrame:backgroundFrame];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
