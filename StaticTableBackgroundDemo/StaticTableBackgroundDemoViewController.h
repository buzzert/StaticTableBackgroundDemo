//
//  StaticBackgroundScrollViewDemoViewController.h
//  StaticTableBackgroundDemo
//
//  This class serves as a proof of concept for a similar
//  implementation of Twitter for iPhone's "Sliding UITableView
//  Header Views" (referenced from chpwn's blog here <http://bit.ly/q4JLeS>)
//
//  Created by James Magahern on 7/17/11.
//  Copyright 2011 omegaHern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticTableBackgroundDemoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
    
    @private
    UIView *_fauxBackgroundView;
}

@end
